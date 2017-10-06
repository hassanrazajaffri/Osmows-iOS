//
//  TwitterSignUpViewController.h
//  Restaurant
//
//  Created by Nadeem Ali on 11/2/14.
//
//

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"
@interface TwitterSignUpViewController : UIViewController
{
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
    
   IBOutlet  UIWebView *webview;
    
}
@property (nonatomic,strong) OAToken* accessToken;
@property (assign) id delegate;
-(IBAction)dismissTwitterView:(id)sender;
@end
