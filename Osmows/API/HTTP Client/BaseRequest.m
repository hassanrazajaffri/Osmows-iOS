
//
//  DCCIRequest.m
//  GMG
//
//  Created by Mosib on 10/8/13.
//  Copyright (c) 2013 GMG. All rights reserved.
//

#import "BaseRequest.h"
//#import "EnviromentInfo"

//#import "NSDate+CWAdditions.h"
#import "HTTPClient.h"
#import "HTTPRequest.h"
//#import "NSDate+Utility.h"
#import "NetworkReachability.h"
//#import "AppSettings.h"
//#import "NSData+AESCrypt.h"

#define kENTITY_NAME @"entity"
#define kDEVICE_LOCALE @"language"
#define kUPDATED_DATE @"updatedDate"
#define kSERVER_DATE @"serverDate"
#define kDEVICE_ID @"deviceId"
#define kSECURE_KEY @"iPwvD6XtJsZ1pTyA"

#define kResponseStatusCode @"ResponseStatus"
#define kResponseTrue @"1"
#define kResponseDesc @"ResponseMessage"
#define kResponse @"Response"
#define kSyncTime @"SyncTime"


 
#define kNotFirstTime @"FirstTime"

@implementation BaseRequest
@synthesize responseMessage;
@synthesize didFinish;
@synthesize didFail;
@synthesize delegate;
@synthesize requestName;
@synthesize requestParams;
@synthesize userInfo;
@synthesize responseSuccess;
@synthesize responseStatusCode,requestService;


- (id)init {
    self = [super init];
    if (self) {
        self.requestName = nil;
        self.delegate = nil;
        self.didFail  = nil;
        self.didFinish = nil;
        self.requestParams = nil;
        isFirstTime = NO;

    }
    return self;
}


- (void) cancelRequest {
    if (httRequest) {
        [httRequest clearDelegatesAndCancel];
//        [httRequest release],httRequest = nil;
    }
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    if (requestName) {
        self.delegate = _delegate;
        self.didFinish = _didFinish;
        self.didFail = _didFail;
        
        if(![ NetworkReachability isConnected]){
            
            [Common hideLoader];
            [Common showAlertWithTitle:nil message:@"NoInternet" delegate:nil withTag:0 cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //NSError * er = [[NSError alloc ] init];
            //[self requestFailed:nil error:er];
            return;
        }
    }

    
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:requestParams];
    
//    if([User sharedInstance].resturantID!=nil)
//    {
//    [mDic setObject:[User sharedInstance].resturantID forKey:@"RestaurantID"];
//    [mDic setObject:[User sharedInstance].loginKey forKey:@"LoginKey"];
//    [mDic setObject:[User sharedInstance].userID forKey:@"UserID"];
//    if([Common getWaiterInfo]){
//            [mDic setObject:[Waiter sharedInstance].userID forKey:@"WaiterID"];
//        }
 //       }
   // [self setRequestParams:mDic];
    HTTPRequest *request = [HTTPRequest requestWithURL:[NSURL URLWithString:self.requestName] requestDictonary:mDic delegate:self didFinished:@selector(requestFinished:) didFailed:@selector(requestFailed:) userInfo:nil] ;
    [request startAsynchronous];

//    httRequest = [HTTPRequest requestPOSTWithURL:requestName requestDictonary:mDic delegate:self didFinished:@selector(requestFinished:response:) didFailed:@selector(requestFailed:error:) userInfo:nil] ;
   
}

- (NSString*) responsePath {
    return @"";
}

- (void) setResponse:(NSDictionary*)dic {
    _responseCode = 1;// [[dic valueForKey:@"ResponseStatus"] intValue];
    _responseDescription = [dic valueForKey:@"ResponseDescription"];
    responseMessage = [dic valueForKey:@"ResponseDescription"];
    _responseTitle = [dic valueForKey:@"ResponseTitle"];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void) requestFinished:(HTTPRequest *)request response:(id)response {
    NSError *error = nil;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
//    if ([self.requestService isEqualToString:@"invoiceSubmit"]) {
//        [Common showAlertWithTitle:nil message:[NSString stringWithFormat:@"Error : %@",error] delegate:nil withTag:200 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [Common showAlertWithTitle:nil message:[NSString stringWithFormat:@"Json Dic : %@",jsonDic] delegate:nil withTag:200 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    
//    }
        if (jsonDic && !error) {
            [self setResponse:jsonDic];
            id jsonResponse = requestService.length==0? jsonDic : [jsonDic objectForKey:requestService]; // Should be key : kResponse
        if (jsonResponse != (id)[NSNull null] && jsonResponse != nil){
            [self didReceiveResponse:jsonResponse parsedResult:jsonDic];
        }
        else{
            if (_responseCode== 1) {
                [self didReceiveResponse:jsonResponse parsedResult:_responseDescription ];
            }
            else{
            [self didReceiveFailed:[NSError errorWithDomain:responseMessage code:_responseCode userInfo:[NSDictionary dictionaryWithObject:responseMessage forKey:kResponseDesc]]];
            }
        }
    }
    else {
        [Common hideLoader];
        
        [self didReceiveFailed:[NSError errorWithDomain:@"No Json response recieved" code:-1 userInfo:nil]];
    }
}

- (void) requestFailed:(HTTPRequest *)request error:(NSError*)error {
//    if ([self.requestService isEqualToString:@"invoiceSubmit"]) {
//        [Common showAlertWithTitle:nil message:[NSString stringWithFormat:@"Error : %@",error] delegate:nil withTag:200 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    }

    [Common hideLoader];
    [self didReceiveFailed:error];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    
    if ([delegate respondsToSelector:didFinish]) {
        [delegate performSelector:didFinish withObject:self withObject:object ];
    }
}

- (void) didReceiveFailed:(NSError*)error {
//    if ([self.requestService isEqualToString:@"invoiceSubmit"]) {
//        [Common showAlertWithTitle:nil message:[NSString stringWithFormat:@"Error : %@",error] delegate:nil withTag:200 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        
//    }
    

//        [Common showAlertWithTitle:@"" message:[error description] delegate:nil withTag:200 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//

    [Common hideLoader];
    if ([delegate respondsToSelector:didFail]) {
        NSLog(@"Error: %@ " , [error description]);
        [delegate performSelector:didFail withObject:self withObject:error];
    }
}




@end
