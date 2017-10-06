//
//  LoginRequest.h
//  iMenu
//
//  Created by Mosib on 1/10/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest
@property(nonatomic,retain) NSString* userName;
@property(nonatomic,retain) NSString* password;
@end
