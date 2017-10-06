//
//  NSMutableDictionary+MutableDictionaryUtility.m
//  GMG App
//
//  Created by Mosib on 6/9/15.
//  Copyright (c) 2015 Advansoft. All rights reserved.
//

#import "NSMutableDictionary+MutableDictionaryUtility.h"

@implementation NSMutableDictionary (MutableDictionaryUtility)

//Returns NO if `anObject` is nil; can be used by the sender of the message or ignored if it is irrelevant.
- (BOOL)setObjectOrNull:(id)anObject forKey:(id)aKey
{
    if(anObject!=nil) {
        [self setObject:anObject forKey:aKey];
        return YES;
    }
    else {
        [self setObject:[NSNull null] forKey:aKey];
        return NO;
    }
}


@end
