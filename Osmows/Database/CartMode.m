//
//  CartMode.m
//  iMenu
//
//  Created by Mosib on 1/14/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "CartMode.h"

@implementation CartMode

+ (CartMode *)sharedInstance
{
    static dispatch_once_t pred;
    static CartMode *sharedInstance = nil;
    dispatch_once(&pred, ^{
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    });
    return(sharedInstance);
}
@end
 
