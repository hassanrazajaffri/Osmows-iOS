//
//  DataManager.h
//  Salik
//
//  Created by Faizan Ali on 5/18/14.
//  Copyright (c) 2014 Salik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+CWCoreData.h"
#import "Categories.h"
#import "Dishes.h"
//#import "DatabaseImports.h"

extern NSString * const DataManagerDidSaveNotification;
extern NSString * const DataManagerDidSaveFailedNotification;

@interface DataManager : NSObject {
//    NSArray *array;
//    SalikAccount *accccc;
    //User *user;
}

@property (nonatomic, readonly, strong) NSManagedObjectModel *objectModel;
@property (nonatomic, readonly, strong) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager*)sharedInstance;
- (BOOL)save;
- (NSManagedObjectContext*)managedObjectContext;
- (id) createUniqueObj:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
- (id) createUniqueObj:(NSString*)entityName withPredicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext*)context;
- (id) createObj:(NSString*)entityName;
- (void) deleteAll:(NSPredicate*)predicate withTable:(NSString*)tableName;
- (void) deleteObject:(id)obj;
- (void) deleteEntity:(NSString*)entity;

- (NSArray *) getAllCategories;
- (Categories*) getCategoryWithID:(NSString*) categoryID;
- (NSArray*) getDishesWithCategoryID:(NSString*) categoryId;

- (Dishes*) getDishWithID:(NSString*) dishID;
- (NSArray *) getAllServingTables;
- (NSArray *) getAllServingAllTables;

- (NSArray *) getAllMenu;
- (NSArray*) getAllMenuWithRestaurantID:(NSString*)restaurantID;

@end
