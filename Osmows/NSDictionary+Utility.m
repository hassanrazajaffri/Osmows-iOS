//
//  NSDictionary+Utility.m
//  Salik
//
//  Created by Mosib on 5/21/14.
//  Copyright (c) 2014 Salik. All rights reserved.
//

#import "NSDictionary+Utility.h"

@implementation NSDictionary (Utility)

// in case of [NSNull null] values a nil is returned ...
- (id)objectForKeyNotNull:(id)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}




@end
