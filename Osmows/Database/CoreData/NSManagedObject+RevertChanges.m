//
//  NSManagedObject+RevertChanges.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/15/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "NSManagedObject+RevertChanges.h"

@implementation NSManagedObject (RevertChanges)

- (void) revertChanges {
    // Revert to original Values
    NSDictionary *changedValues = [self changedValues];
    NSDictionary *committedValues = [self committedValuesForKeys:[changedValues allKeys]];
    NSEnumerator *enumerator;
    id key;
    enumerator = [changedValues keyEnumerator];
    
    while ((key = [enumerator nextObject])) {
        //NSLog(@"Reverting field ""%@"" from ""%@"" to ""%@""", key, [changedValues objectForKey:key], [committedValues objectForKey:key]);
        [self setValue:[committedValues objectForKey:key] forKey:key];
    }
}

@end
