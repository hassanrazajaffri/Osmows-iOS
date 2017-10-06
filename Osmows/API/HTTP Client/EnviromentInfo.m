//
//  EnviromentVariable.m
//  Salik
//
//  Created by Mosib on 5/18/14.
//  Copyright (c) 2014 Salik. All rights reserved.
//

#import "EnviromentInfo.h"

@implementation EnviromentInfo

static EnviromentInfo *_sharedInfo = nil;

+ (EnviromentInfo *)sharedInfo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_sharedInfo == nil) {
            _sharedInfo = [[EnviromentInfo alloc] init];
        }
    });
    return _sharedInfo;
}

- (id)init {
    self = [super init];
    if (self) {
       // _authenticationToken = AUTHENTICATION_CODE;
    }
    return self;
}


- (NSDictionary*) getHeader {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_authenticationToken forKey:@"AuthenticationToken"];
    [dic setObject:_sessionID forKey:@"SessionID"];
    [dic setObject:_userID forKey:@"UserID"];
    return dic;
}


@end
