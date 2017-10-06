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
        self.requestName = @"login.php";
        self.requestService = @"";
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userName forKey:@"LoginUserName"];
    [params setObject:self.password forKey:@"LoginUserPassword"];
    NSLog(@"%@",[Common getDeviceId]);
    [params setObject:[Common getDeviceId] forKey:@"DeviceID"];
    [self setRequestParams:params];
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    if (response != [NSNull null]) {
        if(![[response objectForKey:@"ResponseStatus"] boolValue])
        {
//            [Common showAlertWithTitle:nil message:AppLanguage==ENGLISH? [response objectForKey:@"ResponseMessageEN"] : [response objectForKey:@"ResponseMessageAR"] delegate:nil withTag:0 cancelButtonTitle:[AppSettings getValueForKey:@"OK"] otherButtonTitles:nil];
            [Common hideLoader];

            
            if([[response objectForKey:@"ResponseID"] intValue] == 24)
            {
                if ([delegate respondsToSelector:didFail]) {
                    // [Common saveLoginUserInfo:nil];
                    [delegate performSelector:didFail withObject:self withObject:nil];
                }
            }
            
        }
        else
        {
            if ([[response objectForKey:@"RoleID"] intValue]==2) {
                
            [[LoginUser sharedInstance] setResturantID:[response objectForKey:@"RestaurantID"]];
            [[LoginUser sharedInstance] setLoginKey:[response objectForKey:@"LoginKey"]];
         //   [[LoginUser sharedInstance] setLoginUserID:[response objectForKey:@"LoginUserID"]];
     //       [[LoginUser sharedInstance] setLoginUserName:[response objectForKey:@"FirstName"]];
            [[LoginUser sharedInstance] setRestaurantNameEN:[response objectForKey: @"RestaurantNameEN"]];
            [[LoginUser sharedInstance] setRestaurantNameAR:[response objectForKey:@"RestaurantNameAR"]];
                
            [[LoginUser sharedInstance] setRestaurantDetailsEN:[response objectForKey: @"RestaurantProfileTextEN"]];
            [[LoginUser sharedInstance] setRestaurantDetailsAR:[response objectForKey: @"RestaurantProfileTextAR"]];

            [[LoginUser sharedInstance] setRestaurantBackgroundImage:[response objectForKey:@"BackgroundImage"]];
            [[LoginUser sharedInstance] setRestaurantLogo:[response objectForKey:@"RestaurantLogo"]];
            [[LoginUser sharedInstance] setBarHexCode:[response objectForKey:@"RestaurantLogoBGColor"]];
            [[LoginUser sharedInstance] setFeatureList:[response objectForKey:@"Features"]];
            [[LoginUser sharedInstance] setTextureImageLogo:[response objectForKey:@"BarTexture"]];
            [[LoginUser sharedInstance] setProductFeature:[response objectForKey:@"ProductFeature"]];
      //      [Common saveLoginUserInfo:[LoginUser sharedInstance]];
            [super didReceiveResponse:response parsedResult:object];
            }
           
        }

    }
    
    NSLog(@"%@",[response objectForKey:@"RestaurantID"]);
    
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
