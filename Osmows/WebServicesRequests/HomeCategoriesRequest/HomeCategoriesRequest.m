//
//  VerifyCodeRequest.m

//
//  Created by Mosib on 1/10/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "VerifyCodeRequest.h"
#import "LoginUser.h"
@implementation VerifyCodeRequest

- (id)init {
    self = [super init];
    if (self) {
        self.requestName = @"verifycode/";
        self.requestService = @"";
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.user_id forKey:@"user_id"];
    [params setObject:self.code forKey:@"code"];
    [params setObject:self.phone forKey:@"phone"];
    [params setObject:self.email forKey:@"email"];
    
    NSLog(@"%@",[Common getDeviceId]);
  //  [params setObject:[Common getDeviceId] forKey:@"DeviceID"];
    [self setRequestParams:params];
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    if (response != [NSNull null]) {
        if(![[response objectForKey:@"error"] boolValue])
        {
            //            [Common showAlertWithTitle:nil message:AppLanguage==ENGLISH? [response objectForKey:@"ResponseMessageEN"] : [response objectForKey:@"ResponseMessageAR"] delegate:nil withTag:0 cancelButtonTitle:[AppSettings getValueForKey:@"OK"] otherButtonTitles:nil];
            [Common hideLoader];
            
            NSDictionary *data=( NSDictionary *)[response objectForKey:@"data"];
            
            
            [[LoginUser sharedInstance] setUserId:[NSNumber numberWithInt:[[data objectForKey:@"user_id"] intValue]]];
            [[LoginUser sharedInstance] setUserLogin:[data objectForKey:@"user"]];
            [[LoginUser sharedInstance] setEmail:[data objectForKey:@"email"]];
            [[LoginUser sharedInstance] setFirstName:[data objectForKey:@"first_name"]];
            [[LoginUser sharedInstance] setLastName:[data objectForKey:@"last_name"]];
            [[LoginUser sharedInstance] setPhoneNumber:[data objectForKey:@"image"]];
            [[LoginUser sharedInstance] setApiKey:[data objectForKey:@"api_key"]];
            [[LoginUser sharedInstance] setProfilePicture:[data objectForKey:@"image"]];
            [[LoginUser sharedInstance] setAutorized:YES];
            [Common saveLoginUserInfo:[LoginUser sharedInstance]];
            [super didReceiveResponse:response parsedResult:object];
            //}
            
        }
        else
        {
            [Common hideLoader];
            [super didReceiveResponse:response parsedResult:object];
        }
        
        
        
        NSLog(@"%@",[response objectForKey:@"RestaurantID"]);
        
    }
}

- (void) didReceiveFailed:(NSError*)error {
    if ([delegate respondsToSelector:didFail]) {
        NSLog(@"Error: %@ " , [error description]);
        NSDictionary *LoginUserInfoDic = [error userInfo];
        NSString *errorString = [LoginUserInfoDic objectForKey:@"NSLocalizedDescription"];
        if (!errorString || [errorString isEqualToString:@""]) {
            //errorString = EMPTY_ERROR_MESSAGE;
        }
        
        [delegate performSelector:didFail withObject:self withObject:errorString];
    }
}

@end
