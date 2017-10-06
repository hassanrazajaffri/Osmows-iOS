//
//  HTTP.m
//  Advansoft
//
//  Created by Faizan Ali on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "HTTPCommon.h"
#import "Enum.h"
#import "Url.h"

@implementation HTTPCommon




+ (NSString*) getBaseUrl {
    
    
    NSString *baseUrl = nil;
    
    
    
    switch (mode) {
        case DEVELOPMENT:
            baseUrl = BASE_URL_DEVELOPMENT_UPDATED;
            break;
        case STAGING:
            baseUrl = BASE_URL_STAGING; 
            break;
        case PRODUCTION:
            baseUrl = BASE_URL_PRODUCTION;
            break;
        default:
            baseUrl = BASE_URL_PRODUCTION;
            break;
    }

    if ([[NSUserDefaults standardUserDefaults] objectForKey:kBASE_URL]) {
        baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:kBASE_URL];
    }
//    if ([[AppSettingsModal sharedInstance] baseURL]) {
//        baseUrl = [[AppSettingsModal sharedInstance] baseURL];
//    }
    
    return baseUrl;
}


@end
