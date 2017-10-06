//
//  LoginRequest.h

//
//  Created by Mosib on 1/10/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "BaseRequest.h"

@interface VerifyCodeRequest : BaseRequest
@property(nonatomic,retain) NSString* code;
@property(nonatomic,retain) NSString* phone;
@property(nonatomic,retain) NSString* email;
@property(nonatomic,retain) NSString* user_id;
@end
