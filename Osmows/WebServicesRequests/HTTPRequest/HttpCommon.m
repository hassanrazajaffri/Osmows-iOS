//
//  GMCommon.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "HttpCommon.h"
#import "SCURL.h"



@implementation HttpCommon

static SERVER_MODE mode = DEVELOPMENT;


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
    
    return baseUrl;
}

+ (SERVER_MODE) getServerMode {
    return mode;
}

@end
