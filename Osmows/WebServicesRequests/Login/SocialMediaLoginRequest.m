//
//  LoginRequest.m
//  iMenu
//
//  Created by Mosib on 1/10/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "LoginRequest.h"
#import "LoginUser.h"
@implementation LoginRequest

- (id)init {
    self = [super init];
    if (self) {
        self.requestName = @"signin/";
        self.requestService = @"";
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userName forKey:@"user"];
    [params setObject:self.password forKey:@"password"];
    NSLog(@"%@",[Common getDeviceId]);
   // [params setObject:[Common getDeviceId] forKey:@"DeviceID"];
    [self setRequestParams:params];
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    if (response != [NSNull null]) {
        if(![[response objectForKey:@"error"] boolValue])
        {
//            [Common showAlertWithTitle:nil message:AppLanguage==ENGLISH? [response objectForKey:@"ResponseMessageEN"] : [response objectForKey:@"ResponseMessageAR"] delegate:nil withTag:0 cancelButtonTitle:[AppSettings getValueForKey:@"OK"] otherButtonTitles:nil];
            
            NSDictionary *data=( NSDictionary *)[response objectForKey:@"data"];
          
                
            [[LoginUser sharedInstance] setUserId:[NSNumber numberWithInt:[[data objectForKey:@"user_id"] intValue]]];
            [[LoginUser sharedInstance] setUserLogin:[data objectForKey:@"user"]];
            [[LoginUser sharedInstance] setEmail:[data objectForKey:@"email"]];
            [[LoginUser sharedInstance] setFirstName:[data objectForKey:@"first_name"]];
            [[LoginUser sharedInstance] setLastName:[data objectForKey:@"last_name"]];
            [[LoginUser sharedInstance] setPhoneNumber:[data objectForKey:@"phone"]];
            [[LoginUser sharedInstance] setApiKey:[data objectForKey:@"api_key"]];
            [[LoginUser sharedInstance] setProfilePicture:[data objectForKey:@"avatar"]];
             [[LoginUser sharedInstance] setAutorized:[[data objectForKey:@"Autorized"] boolValue]];
               [Common saveLoginUserInfo:[LoginUser sharedInstance]];
                [super didReceiveResponse:response parsedResult:object];
            //}
            
        }
else
{
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
