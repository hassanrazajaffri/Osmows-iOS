//
//  EnviromentInfo.h
//  Salik
//
//  Created by Mosib on 5/18/14.
//  Copyright (c) 2014 Salik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnviromentInfo : NSObject

@property (nonatomic,strong) NSString *authenticationToken;
@property (nonatomic,strong) NSString *sessionID;
@property (nonatomic,strong) NSString *userID;

+ (EnviromentInfo *)sharedInfo;
- (NSDictionary*) getHeader;


@end
