//
//  LoginRequest.m
//  iMenu
//
//  Created by Mosib on 1/10/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "LoginRequest.h"

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
    [params setObject:self.userName forKey:@"UserName"];
    [params setObject:self.password forKey:@"UserPassword"];
    NSLog(@"%@",[Common getDeviceId]);
    [params setObject:[Common getDeviceId] forKey:@"DeviceID"];
    [self setRequestParams:params];
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    if (response != [NSNull null]) {
        if(![[response objectForKey:@"ResponseStatus"] boolValue])
        {
            [Common showAlertWithTitle:nil message:AppLanguage==ENGLISH? [response objectForKey:@"ResponseMessageEN"] : [response objectForKey:@"ResponseMessageAR"] delegate:nil withTag:0 cancelButtonTitle:[AppSettings getValueForKey:@"OK"] otherButtonTitles:nil];
            [Common hideLoader];

            
            if([[response objectForKey:@"ResponseID"] intValue] == 24)
            {
                if ([delegate respondsToSelector:didFail]) {
                     [Common saveUserInfo:nil];
                    [delegate performSelector:didFail withObject:self withObject:nil];
                }
            }
            
        }
        else
        {
            if ([[response objectForKey:@"RoleID"] intValue]==2) {
                
            [[User sharedInstance] setResturantID:[response objectForKey:@"RestaurantID"]];
            [[User sharedInstance] setLoginKey:[response objectForKey:@"LoginKey"]];
            [[User sharedInstance] setUserID:[response objectForKey:@"UserID"]];
            [[User sharedInstance] setUserName:[response objectForKey:@"FirstName"]];
            [[User sharedInstance] setRestaurantNameEN:[response objectForKey: @"RestaurantNameEN"]];
            [[User sharedInstance] setRestaurantNameAR:[response objectForKey:@"RestaurantNameAR"]];
                
            [[User sharedInstance] setRestaurantDetailsEN:[response objectForKey: @"RestaurantProfileTextEN"]];
            [[User sharedInstance] setRestaurantDetailsAR:[response objectForKey: @"RestaurantProfileTextAR"]];

            [[User sharedInstance] setRestaurantBackgroundImage:[response objectForKey:@"BackgroundImage"]];
            [[User sharedInstance] setRestaurantLogo:[response objectForKey:@"RestaurantLogo"]];
            [[User sharedInstance] setBarHexCode:[response objectForKey:@"RestaurantLogoBGColor"]];
            [[User sharedInstance] setFeatureList:[response objectForKey:@"Features"]];
            [[User sharedInstance] setTextureImageLogo:[response objectForKey:@"BarTexture"]];
            [[User sharedInstance] setProductFeature:[response objectForKey:@"ProductFeature"]];
            [Common saveUserInfo:[User sharedInstance]];
            [super didReceiveResponse:response parsedResult:object];
            }
           else if ([[response objectForKey:@"RoleID"] intValue]==3) {
                
                [[Waiter sharedInstance] setResturantID:[response objectForKey:@"RestaurantID"]];
                [[Waiter sharedInstance] setLoginKey:[response objectForKey:@"LoginKey"]];
                [[Waiter sharedInstance] setUserID:[response objectForKey:@"UserID"]];
                [[Waiter sharedInstance] setUserName:[response objectForKey:@"FirstName"]];
                [[Waiter sharedInstance] setRestaurantNameEN:[response objectForKey: @"RestaurantNameEN"]];
                [[Waiter sharedInstance] setRestaurantNameAR:[response objectForKey:@"RestaurantNameAR"]];
                [[Waiter sharedInstance] setRestaurantBackgroundImage:[response objectForKey:@"BackgroundImage"]];
                [[Waiter sharedInstance] setRestaurantLogo:[response objectForKey:@"RestaurantLogo"]];
                [[Waiter sharedInstance] setBarHexCode:[response objectForKey:@"RestaurantLogoBGColor"]];
                [[Waiter sharedInstance] setFeatureList:[response objectForKey:@"Features"]];
                [[Waiter sharedInstance] setTextureImageLogo:[response objectForKey:@"BarTexture"]];
                [[Waiter sharedInstance] setProductFeature:[response objectForKey:@"ProductFeature"]];
                [Common saveWaiterInfo:[Waiter sharedInstance]];
                [super didReceiveResponse:response parsedResult:object];
            }

        }

    }
    
    NSLog(@"%@",[response objectForKey:@"RestaurantID"]);
    
    }

- (void) didReceiveFailed:(NSError*)error {
    if ([delegate respondsToSelector:didFail]) {
        NSLog(@"Error: %@ " , [error description]);
        NSDictionary *userInfoDic = [error userInfo];
        NSString *errorString = [userInfoDic objectForKey:@"NSLocalizedDescription"];
        if (!errorString || [errorString isEqualToString:@""]) {
            //errorString = EMPTY_ERROR_MESSAGE;
        }
        
        [delegate performSelector:didFail withObject:self withObject:errorString];
    }
}

@end
