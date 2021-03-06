//
//  TwitterSignUpViewController.m
//  Restaurant
//
//  Created by Nadeem Ali on 11/2/14.
//
//

#import "TwitterSignUpViewController.h"

@interface TwitterSignUpViewController ()

@end

@implementation TwitterSignUpViewController

NSString *callback = @"http://starschoice.com/callback";

@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}
-(void)viewDidAppear:(BOOL)animated{
     [self TwitterLoginView:nil];
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)dismissTwitterView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)TwitterLoginView:(id)sender
{
    //    TWTRLogInButton* logInButton =  [TWTRLogInButton
    //                                     buttonWithLogInCompletion:
    //                                     ^(TWTRSession* session, NSError* error) {
    //                                         if (session) {
    //                                             NSLog(@"signed in as %@", [session userName]);
    //                                         } else {
    //                                             NSLog(@"error: %@", [error localizedDescription]);
    //                                         }
    //                                     }];
    //    logInButton.center = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 170);;
    //    [self.view addSubview:logInButton];
    consumer = [[OAConsumer alloc] initWithKey:kOAuthConsumerKey secret:kOAuthConsumerSecret];
    NSURL* requestTokenUrl = [NSURL URLWithString:@"https://api.twitter.com/oauth/request_token"];
    OAMutableURLRequest* requestTokenRequest = [[OAMutableURLRequest alloc] initWithURL:requestTokenUrl
                                                                               consumer:consumer
                                                                                  token:nil
                                                                                  realm:nil
                                                                      signatureProvider:nil];
    OARequestParameter* callbackParam = [[OARequestParameter alloc] initWithName:@"oauth_callback" value:callback];
    [requestTokenRequest setHTTPMethod:@"POST"];
    [requestTokenRequest setParameters:[NSArray arrayWithObject:callbackParam]];
    OADataFetcher* dataFetcher = [[OADataFetcher alloc] init];
    [dataFetcher fetchDataWithRequest:requestTokenRequest
                             delegate:self
                    didFinishSelector:@selector(didReceiveRequestToken:data:)
                      didFailSelector:@selector(didFailOAuth:error:)];
}
#pragma mark Twitter Delegate methods
- (void)didReceiveRequestToken:(OAServiceTicket*)ticket data:(NSData*)data {
    NSString* httpBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    requestToken = [[OAToken alloc] initWithHTTPResponseBody:httpBody];
    
    NSURL* authorizeUrl = [NSURL URLWithString:@"https://api.twitter.com/oauth/authorize"];
    OAMutableURLRequest* authorizeRequest = [[OAMutableURLRequest alloc] initWithURL:authorizeUrl
                                                                            consumer:nil
                                                                               token:nil
                                                                               realm:nil
                                                                   signatureProvider:nil];
    NSString* oauthToken = requestToken.key;
    OARequestParameter* oauthTokenParam = [[OARequestParameter alloc] initWithName:@"oauth_token" value:oauthToken];
    [authorizeRequest setParameters:[NSArray arrayWithObject:oauthTokenParam]];
    
  //  webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    webview.delegate=self;
    //[self.view addSubview:webview];
    [webview loadRequest:authorizeRequest];
}

- (void)didReceiveAccessToken:(OAServiceTicket*)ticket data:(NSData*)data {
    NSString* httpBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    accessToken = [[OAToken alloc] initWithHTTPResponseBody:httpBody];
    // WebServiceSocket *connection = [[WebServiceSocket alloc] init];
    //  connection.delegate = self;
    NSString *pdata = [NSString stringWithFormat:@"type=2&token=%@&secret=%@", accessToken.key, accessToken.secret];
    // [connection fetch:1 withPostdata:pdata withGetData:@"" isSilent:NO];
    NSLog(@"%@",[[[[httpBody componentsSeparatedByString:@"&"] objectAtIndex:2] componentsSeparatedByString:@"="] lastObject]);
    if([[httpBody componentsSeparatedByString:@"&"] count]==4)
    {
        NSString *strUser_id=[[[[httpBody componentsSeparatedByString:@"&"] objectAtIndex:2] componentsSeparatedByString:@"="] lastObject];
        NSString *strUsername=[[[[httpBody componentsSeparatedByString:@"&"] objectAtIndex:3] componentsSeparatedByString:@"="] lastObject];
       
       
    }
    
    if (accessToken) {
        NSURL* userdatarequestu = [NSURL URLWithString:@"https://api.twitter.com/1.1/account/verify_credentials.json"];
        OAMutableURLRequest* requestTokenRequest = [[OAMutableURLRequest alloc] initWithURL:userdatarequestu
                                                                                   consumer:consumer
                                                                                      token:accessToken
                                                                                      realm:nil
                                                                          signatureProvider:nil];
        
        [requestTokenRequest setHTTPMethod:@"GET"];
        OADataFetcher* dataFetcher = [[OADataFetcher alloc] init];
        [dataFetcher fetchDataWithRequest:requestTokenRequest
                                 delegate:self
                        didFinishSelector:@selector(didReceiveuserdata:data:)
                          didFailSelector:@selector(didFailOdatah:error:)];
    } else {
            // ERROR!
        }
    //    UIAlertView *alertView = [[UIAlertView alloc]
    //                              initWithTitle:@"Twitter Access Tooken"
    //                              message:pdata
    //                              delegate:nil
    //                              cancelButtonTitle:@"OK"
    //                              otherButtonTitles:nil];
    //   // [alertView show];
    
    
}

- (void)didFailOAuth:(OAServiceTicket*)ticket error:(NSError*)error {
    // ERROR!
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    //  [indicator startAnimating];
    NSLog(@"%@",request);
    NSString *temp = [NSString stringWithFormat:@"%@",request];
    //  BOOL result = [[temp lowercaseString] hasPrefix:@"http://codegerms.com/callback"];
    // if (result) {
    NSRange textRange = [[temp lowercaseString] rangeOfString:[@"http://starschoice.com/callback" lowercaseString]];
    
    if(textRange.location != NSNotFound){
        
        
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"oauth_verifier"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {
            NSURL* accessTokenUrl = [NSURL URLWithString:@"https://api.twitter.com/oauth/access_token"];
            OAMutableURLRequest* accessTokenRequest = [[OAMutableURLRequest alloc] initWithURL:accessTokenUrl consumer:consumer token:requestToken realm:nil signatureProvider:nil];
            OARequestParameter* verifierParam = [[OARequestParameter alloc] initWithName:@"oauth_verifier" value:verifier];
            [accessTokenRequest setHTTPMethod:@"POST"];
            [accessTokenRequest setParameters:[NSArray arrayWithObject:verifierParam]];
            OADataFetcher* dataFetcher = [[OADataFetcher alloc] init];
            [dataFetcher fetchDataWithRequest:accessTokenRequest
                                     delegate:self
                            didFinishSelector:@selector(didReceiveAccessToken:data:)
                              didFailSelector:@selector(didFailOAuth:error:)];
        } else {
            // ERROR!
        }
        
        //[self dismissViewControllerAnimated:YES completion:^{
         //   NSLog(@"dismissed view");
       // }];
        
        return NO;
    }
    
    return YES;
}

- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    // ERROR!
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // [indicator stopAnimating];
}

- (void)didReceiveuserdata:(OAServiceTicket*)ticket data:(NSData*)data {
    NSString* httpBody = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]];
    [self dismissViewControllerAnimated:YES completion:^{
        [delegate doSignUpWithTwitterUserID:dict];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
