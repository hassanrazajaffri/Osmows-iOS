//
//  NSManagedObject+Clone.h
//  GMCadallic
//
//  Created by Muhammad Baqir on 6/21/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Clone)


- (NSManagedObject *) clone;
- (NSManagedObject *) cloneTemp;
- (NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context withCopiedCache:(NSMutableDictionary *)alreadyCopied exludeEntities:(NSArray *)namesOfEntitiesToExclude;

@end
