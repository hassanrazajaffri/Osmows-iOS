//
//  HTTPRequest.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "HTTPRequest.h"
#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"
#import "HttpCommon.h"
#import "Reachability.h"
#import "RestaurantAppDelegate.h"

//#import "NSString+AESCrypt.h"
//#import "Base64.h"

//#define kRequestPrivateKey @"iPwvD6XtJsZ1pTyA"

//#define kStringEndTerminator @"[END]"
//#define kStringStartTerminator @"[START]"

@interface HTTPRequest()

- (void) reportFail;
- (void) reportSuccess;

@end

@implementation HTTPRequest
@synthesize requestDelegate;
@synthesize didFinish;
@synthesize didFail;
@synthesize requestName;

+ (id) requestWithURL:(NSURL *)newURL requestDictonary:(NSDictionary*)dic delegate:(id)delegate didFinished:(SEL)finish didFailed:(SEL)failed userInfo:(NSDictionary*)userInfo {

    //NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
   // [mDic setObject:[Common getDeviceName] forKey:@"device"];
    //[mDic setObject:[NSNumber numberWithInt:AppLanguage] forKey:@"language_id"];
    //[mDic setObject:@"false" forKey:@"encryption"];
    
    
    HTTPRequest *request =  [[self alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[HttpCommon getBaseUrl],[newURL absoluteString]]]] ;
    request.requestName = [newURL absoluteString];
    
    
    
    CJSONSerializer *jsonSerializer = [CJSONSerializer serializer];
    NSError *error;
    NSData *data = [jsonSerializer serializeObject:dic error:&error];
    //NSString* stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
   // stringData  = [NSString stringWithFormat:@"%@%@%@",kStringStartTerminator,stringData,kStringEndTerminator]; //For Seperating the text with out start and end tags
   // NSString* encryptedString = [stringData AES128EncryptWithKey:kRequestPrivateKey];
   // encryptedString = [encryptedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

//    NSString* jsonString = [NSString stringWithFormat:@"%@",stringData];
//    data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if([request.requestName isEqualToString:GETBUSINESSES])
    {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@%d",GETBUSINESSES,[[RestaurantGlobals getDefaultValue:kSelectedBusinessType] intValue]]]){
            
            [request addRequestHeader:@"SyncTime" value:[[NSUserDefaults standardUserDefaults] valueForKey: [NSString stringWithFormat:@"%@%d",GETBUSINESSES,[[RestaurantGlobals getDefaultValue:kSelectedBusinessType] intValue]]]];
        }
        else{
            [request addRequestHeader:@"SyncTime"  value:@"2000-01-01"];
        }
    }
    else{
    if (request.requestName) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:request.requestName] length]>0) {
            [request addRequestHeader:@"SyncTime" value: [[NSUserDefaults standardUserDefaults] valueForKey:request.requestName] ];
        }
        else{
            [request addRequestHeader:@"SyncTime"  value:@"2000-01-01"];
        }
    }
    }
    
     [request addRequestHeader:@"Accept" value:@"application/json"];
     [request addRequestHeader:@"Content-Type" value:@"application/json"];
     [request addRequestHeader:@"AuthenticationToken" value:@"67VAWUAQ53O79MEYOQWQ7CD3LRLI245P"];
     [request addRequestHeader:@"BusinessTypeID" value:[AppSettings getStringForKey:kSelectedBusinessType]];
    
    if([RestaurantGlobals checkLoggedIn])
    {
        [request addRequestHeader:@"LoginKey" value:[RestaurantGlobals getDefaultValue:@"LoginKey"]];
        NSLog(@"%@",[RestaurantGlobals getDefaultValue:@"LoginKey"]);
        [request addRequestHeader:@"UserID" value:[NSString stringWithFormat:@"%@",[RestaurantGlobals getDefaultValue:@"login"]]];
    }
    [request setPostBody:(NSMutableData *)data];
 //   [request appendPostData:data];
    [request setRequestMethod:@"POST"];
//    [request setUserAgent:@"Restaurant"];
//    [request setUserInfo:userInfo];
    [request setTimeOutSeconds:60];

    [request setDidFail:failed];
    [request setDidFinish:finish];
    [request setRequestDelegate:delegate];

    [request setValidatesSecureCertificate:NO];

    return request;
}

- (void) dealloc {
   // [requestName release];
    requestName=nil;
   // [super dealloc];
}

#pragma mark -
#pragma mark OverRide Methods



- (void) requestFinished {
    [super requestFinished];
    [self performSelectorOnMainThread:@selector(reportSuccess) withObject:nil waitUntilDone:NO];
}


- (void) failWithError:(NSError *)theError{
    [super failWithError:theError];
    [self performSelectorOnMainThread:@selector(reportFail) withObject:nil waitUntilDone:NO];

}



- (void)clearDelegatesAndCancel {
    [super clearDelegatesAndCancel];
    [self setRequestDelegate:nil];
    [self setDidFail:nil];
    [self setDidFinish:nil];
}

#pragma mark -
#pragma mark Private Methods

- (void) reportFail {
    if ([requestDelegate respondsToSelector:didFail]) {
       // GMCadallicAppDelegate *gmDelegate = (GMCadallicAppDelegate*) [[UIApplication sharedApplication]delegate];
       // [gmDelegate checkConnection];
        NSLog(@"%@",[self getReqName]);
        [requestDelegate performSelector:didFail withObject:self];
       // [[[TSAlertView alloc] initWithTitle:@"" message:@"Due to an unforseen error \n your request cannot be processed at this time. \n Please try again later." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil]  show];
    }
}

- (void) reportSuccess {
//    NSLog(@"%@",[self getReqName]);.a
    if(requestDelegate!=nil)
    if ([requestDelegate respondsToSelector:didFinish]) {
        [requestDelegate performSelector:didFinish withObject:self];
    }
}

#pragma mark -
#pragma mark Public Methods

- (NSDictionary*) reponseDictonary {
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    NSError *e;
    NSString *responseString = [[NSString alloc]initWithData:[self responseData] encoding:NSUTF8StringEncoding] ;
   responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

   // NSLog(@"%@",responseString);
  //  NSString *decryptString = [responseString AES128DecryptWithKey:kRequestPrivateKey];
   // NSLog(@"%@",decryptString);
    NSDictionary *dic = [deserializer deserializeAsDictionary:[responseString dataUsingEncoding:NSUTF8StringEncoding] error:&e];

    if (error) {
        NSLog(@"%@",[NSString stringWithFormat:@"HTTPS Error = %@",e.description]);
        return nil;
    }
    return dic;

}

- (NSString*) getReqName {
    return requestName;
}

@end
