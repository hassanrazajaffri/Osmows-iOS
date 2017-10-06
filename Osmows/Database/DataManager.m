//
//  DataManager.m
//  Salik
//
//  Created by Faizan Ali on 5/18/14.
//  Copyright (c) 2014 Salik. All rights reserved.
//

#import "DataManager.h"
#import "Categories.h"
NSString * const DataManagerDidSaveNotification = @"DIBDataManagerDidSaveNotification";
NSString * const DataManagerDidSaveFailedNotification = @"DIBDataManagerDidSaveFailedNotification";

@interface DataManager ()

- (NSString*)sharedDocumentsPath;

@end

@implementation DataManager

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainObjectContext = _mainObjectContext;
@synthesize objectModel = _objectModel;

NSString * const kDataManagerModelName = @"iMenu";
NSString * const kDataManagerSQLiteName = @"iMenu.sqlite";

+ (DataManager*)sharedInstance {
	static dispatch_once_t pred;
	static DataManager *sharedInstance = nil;
    
	dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
	return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextDidSaveNotification object:nil];
        
        [self managedObjectContext]; // LightWeight Migration

    }
    


    
    return self;
}

- (NSManagedObjectModel*)objectModel {
    
    if (_objectModel != nil)
    {
        return _objectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kDataManagerModelName withExtension:@"momd"];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _objectModel;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
	if (_persistentStoreCoordinator)
		return _persistentStoreCoordinator;
    
    
    NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDataManagerSQLiteName];
    NSError *error = nil;
//
//
    NSString *defaultStorePath = [[NSBundle bundleForClass:[self class]] pathForResource:kDataManagerModelName ofType:@"sqlite"];
//
    if (![[NSFileManager defaultManager] fileExistsAtPath:storePath])
        //if (![[NSFileManager defaultManager] fileExistsAtPath:storePath])
    {
        if (defaultStorePath) {
            if ([[NSFileManager defaultManager] copyItemAtPath:defaultStorePath toPath:storePath error:&error]) {
                NSLog(@"Copied starting data to %@", storePath);
            }
            else {
                NSLog(@"Error copying default DB to %@ (%@)", storePath, error);
            }
        }
    }
    
	NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES,
                              NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}
                              };
    
	// Attempt to load the persistent store
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self objectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error]) {
		NSLog(@"Fatal error while creating persistent store: %@", error);
		abort();
	}
    
    //    NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
    //    if (![[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:storePath error:&error]) {
    //        // Handle error
    //        if (error) {
    //            NSLog(@"%@",[error description]);
    //        }
    //
    //    }
    
    
	return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_mainObjectContext != nil)
    {
        return _mainObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _mainObjectContext = [[NSManagedObjectContext alloc] init];
        [_mainObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _mainObjectContext;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (BOOL)save {
	if (![[self managedObjectContext] hasChanges])
		return YES;
    
	NSError *error = nil;
	if (![[self managedObjectContext] save:&error]) {
		NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
		[[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveFailedNotification
                                                            object:error];
		return NO;
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:DataManagerDidSaveNotification object:nil];
	return YES;
}


- (void)contextChanged:(NSNotification*)notification
{
    if ([notification object] == [self managedObjectContext]) return;
    
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(contextChanged:) withObject:notification waitUntilDone:YES];
        return;
    }
    NSManagedObjectContext *context = (NSManagedObjectContext *)notification.object;
    if( context.persistentStoreCoordinator == self.persistentStoreCoordinator ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.mainThreadContext mergeChangesFromContextDidSaveNotification:notification waitUntilDone:YES];
            [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
        });
        //[[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    }
}

#pragma -
#pragma ActionMethods

- (NSString*)sharedDocumentsPath {
	static NSString *SharedDocumentsPath = nil;
	if (SharedDocumentsPath)
		return SharedDocumentsPath;
    
	// Compose a path to the <Library>/Database directory
	NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	SharedDocumentsPath = [libraryPath stringByAppendingPathComponent:@"Database"] ;
    
	// Ensure the database directory exists
	NSFileManager *manager = [NSFileManager defaultManager];
	BOOL isDirectory;
	if (![manager fileExistsAtPath:SharedDocumentsPath isDirectory:&isDirectory] || !isDirectory) {
		NSError *error = nil;
		NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
		[manager createDirectoryAtPath:SharedDocumentsPath
		   withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
		if (error)
			NSLog(@"Error creating directory path: %@", [error localizedDescription]);
	}
    
	return SharedDocumentsPath;
}


#pragma -
#pragma public Methods

- (id) createUniqueObj:(NSString*)entityName withPredicate:(NSPredicate*)predicate {
    id  obj = [[self managedObjectContext] insertNewUniqueObjectForEntityForName:entityName withPredicate:predicate];
    return obj;
}

- (id) createUniqueObj:(NSString*)entityName withPredicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext*)context {
    id  obj = [context insertNewUniqueObjectForEntityForName:entityName withPredicate:predicate];
    return obj;
}

- (id) createObj:(NSString*)entityName {
    return [NSEntityDescription insertNewObjectForEntityForName:entityName
                                  inManagedObjectContext:[self managedObjectContext]];
}



#pragma mark -
#pragma DB MANAGER FUNCTIONS

- (void) deleteAll:(NSPredicate*)predicate withTable:(NSString*)tableName {
    NSArray *objects = [[self managedObjectContext] objectsForEntityName:tableName withPredicate:predicate sortDescriptors:nil];
    for (NSManagedObject * obj in objects) {
        [self deleteObject:obj];
    }
    
}
- (void)didTurnIntoFault {


}
- (void) deleteObject:(id)obj {
    if (!obj) {
        return;
    }
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:obj];
    obj = nil;
    [self save];
}

- (void) deleteEntity:(NSString*)entity {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    [request setReturnsObjectsAsFaults:NO];
    [request setEntity:entityDesc];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *managedObject in objects) {
        [context deleteObject:managedObject];
    }
    if (![context save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entity,error);
    }
}
#pragma mark Categories
- (Categories*) getCategoryWithID:(NSString*) categoryID{
    
    
    NSString *query = [NSString stringWithFormat:@"categoryID = %d",[categoryID intValue]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"Categories" withPredicate:predicate sortDescriptors:nil];
    if ([objects count] > 0) {
        return [objects objectAtIndex:0];
    }
    return nil;
}

- (NSArray *) getAllCategories{
    
    NSSortDescriptor *sort= [[NSSortDescriptor alloc] initWithKey:@"sortID" ascending:YES];
    
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"Categories" withPredicate:nil sortDescriptors:[NSArray arrayWithObject:sort]];
    if ([objects count] > 0) {
        return objects;
    }
    return nil;
}
#pragma mark Menu
- (NSArray *) getAllMenu{
    
    NSSortDescriptor *sort= [[NSSortDescriptor alloc] initWithKey:@"menuID" ascending:YES];
    
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"Menu" withPredicate:nil sortDescriptors:[NSArray arrayWithObject:sort]];
    if ([objects count] > 0) {
        return objects;
    }
    return nil;
}
- (NSArray*) getAllMenuWithRestaurantID:(NSString*)restaurantID{
    
    NSSortDescriptor *sort= [[NSSortDescriptor alloc] initWithKey:@"menuID" ascending:YES];
    NSString *query = [NSString stringWithFormat:@"restaurantID = %d",[restaurantID intValue]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"Menu" withPredicate:predicate sortDescriptors:[NSArray arrayWithObject:sort]];
    if ([objects count] > 0) {
        return objects;
    }
    return nil;
}


#pragma mark Dishes

- (NSArray*) getDishesWithCategoryID:(NSString*) categoryId{

    NSSortDescriptor *sort= [[NSSortDescriptor alloc] initWithKey:@"sortID" ascending:YES];
    
    NSString *query = [NSString stringWithFormat:@"categoryID = %d",[categoryId intValue]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"Dishes" withPredicate:predicate sortDescriptors:[NSArray arrayWithObject:sort]];
    if ([objects count] > 0) {
        return objects;
    }
    return nil;
}
- (Dishes*) getDishWithID:(NSString*) dishID{
    
    
    NSString *query = [NSString stringWithFormat:@"dishID = %d",[dishID intValue]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"Dishes" withPredicate:predicate sortDescriptors:nil];
    if ([objects count] > 0) {
        return [objects objectAtIndex:0];
    }
    return nil;
}

#pragma mark Get Serving Tables

- (NSArray *) getAllServingTables{
    
    NSSortDescriptor *sort= [[NSSortDescriptor alloc] initWithKey:@"tableNo" ascending:YES];
    
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"ServingTable" withPredicate:nil sortDescriptors:[NSArray arrayWithObject:sort]];
    if ([objects count] > 0) {
        return objects;
    }
    return nil;
}
- (NSArray *) getAllServingAllTables{
    
    NSSortDescriptor *sort= [[NSSortDescriptor alloc] initWithKey:@"tableNo" ascending:YES];
    NSString *query = [NSString stringWithFormat:@"orderTypeID != 2"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *objects = [[self managedObjectContext]objectsForEntityName:@"ServingTable" withPredicate:predicate sortDescriptors:[NSArray arrayWithObject:sort]];
    if ([objects count] > 0) {
        return objects;
    }
    return nil;
}

@end
