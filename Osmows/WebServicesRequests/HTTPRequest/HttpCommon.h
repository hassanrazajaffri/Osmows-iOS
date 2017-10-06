//
//  HttpCommon.h
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    DEVELOPMENT,
//    STAGING,
//    PRODUCTION
//}
//
//SERVER_MODE;

@interface HttpCommon : NSObject


+ (NSString*) getBaseUrl;
+ (SERVER_MODE) getServerMode;

@end
