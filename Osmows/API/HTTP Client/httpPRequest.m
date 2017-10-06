//
//  HTTPRequest.m
//  Advansoft
//
//  Created by Faizan Ali on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "HTTPRequest.h"
#import "HTTPCommon.h"
#import "HttpClient.h"
#import "NetworkReachability.h"



@implementation HTTPRequest
@synthesize client;
@synthesize requestDelegate;
@synthesize didFinish;
@synthesize didFail;
@synthesize requestName;
@synthesize responseDictonary;
@synthesize responseData;
@synthesize responseArray;
NSTimer *timer;



+ (id) requestWithURL:(NSString *)path requestDictonary:(NSDictionary*)params withRequestData:(NSData*)data  delegate:(id)delegate didFinished:(SEL)finish didFailed:(SEL)failed userInfo:(NSDictionary*)userInfo {
    HTTPRequest * request = [[self alloc]init];
    request.client  = [HTTPClient sharedHTTPClient];
   //
    NSMutableDictionary *paramData=[[NSMutableDictionary alloc] initWithDictionary:params];
    if ([Common getLoginUserInfo]) {
        
        [request.client setAuthorizationHeaderWithKey:[Common getLoginUserInfo].apiKey];
    }
    NSMutableURLRequest *re = [request.client requestWithMethod:@"GET" path:path parameters:paramData data:data];
    
    AFHTTPRequestOperation *operation = [request.client HTTPRequestOperationWithRequest:re success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        [request performSelectorOnMainThread:@selector(reportSuccess:) withObject:responseObject waitUntilDone:NO];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
        [request performSelectorOnMainThread:@selector(reportFail:) withObject:error waitUntilDone:NO];
        
    }];
    [request setRequestDelegate:delegate];
    [request setDidFail:failed];
    [request setDidFinish:finish];
    [request setRequestName:path];
    [request.client enqueueHTTPRequestOperation:operation];
    
    
    
    
    return request;
}


+ (id) requestWithURL:(NSString *)path requestDictonary:(NSDictionary*)params delegate:(id)delegate didFinished:(SEL)finish didFailed:(SEL)failed userInfo:(NSDictionary*)userInfo {


    HTTPRequest * request = [[self alloc]init];
    request.client  = [HTTPClient sharedHTTPClient];
    if ([Common getLoginUserInfo]) {
        
        [request.client setAuthorizationHeaderWithKey:[Common getLoginUserInfo].apiKey];
    }
    [request.client getPath:path
                  parameters:params
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [request performSelectorOnMainThread:@selector(reportSuccess:) withObject:responseObject waitUntilDone:NO];
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"%@",error.description);
                         [request performSelectorOnMainThread:@selector(reportFail:) withObject:error waitUntilDone:NO];
                         
                     }];
    
    [request setRequestDelegate:delegate];
    [request setDidFail:failed];
    [request setDidFinish:finish];
    [request setRequestName:path];
//    [Common showAlertWithTitle:nil message:[NSString stringWithFormat:@"Request : %@",request] delegate:nil withTag:200 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    return request;
}
+ (id) requestPOSTWithURL:(NSString *)path requestDictonary:(NSDictionary*)params delegate:(id)delegate didFinished:(SEL)finish didFailed:(SEL)failed userInfo:(NSDictionary*)userInfo {
    
    

    HTTPRequest * request = [[self alloc]init];
    request.client  = [HTTPClient sharedHTTPClient];
    if ([Common getLoginUserInfo]) {
        
        [request.client setAuthorizationHeaderWithKey:[Common getLoginUserInfo].apiKey];
    }
   // request
//    if ([Common getLoginUserInfo]) {
//      //  [paramData setObject:[Common getLoginUserInfo].apiKey forKey:@"Authorization"];
//        [request.client setValue:[Common getLoginUserInfo].apiKey forKey:@"Authorization"];
//    }
   
    [request.client postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [request performSelectorOnMainThread:@selector(reportSuccess:) withObject:responseObject waitUntilDone:NO];
        }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"%@",error.description);
                         [request performSelectorOnMainThread:@selector(reportFail:) withObject:error waitUntilDone:NO];
                         
                     }];
    
    
    [request setRequestDelegate:delegate];
    [request setDidFail:failed];
    [request setDidFinish:finish];
    [request setRequestName:path];
    //    [Common showAlertWithTitle:nil message:[NSString stringWithFormat:@"Request : %@",request] delegate:nil withTag:200 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    return request;
}

- (void)dealloc {
    [self clearDelegatesAndCancel];
    self.responseDictonary = nil;
    self.responseData = nil;
    self.responseArray = nil;
    responseObject = nil;
    self.requestName = nil;
}

#pragma mark -
#pragma mark OverRide Methods


- (void)clearDelegatesAndCancel {
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:requestName];
    [self setRequestDelegate:nil];
    [self setDidFail:nil];
    [self setDidFinish:nil];
}

#pragma mark -
#pragma mark Private Methods

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void) reportFail:(NSError*)error {
    
   // NSLog(@"Error: %@ " , [error description]);

    if ([requestDelegate respondsToSelector:didFail]) {
        [requestDelegate performSelector:didFail withObject:self withObject:error];
//        [Common showAlertWithTitle:kNetWorkErrorTitle() message:kNetWorkErrorMessage() delegate:nil cancelButtonTitle:kOk() otherButtonTitles: nil];
    }
}

- (void) reportSuccess:(id)response {
    if ([requestDelegate respondsToSelector:didFinish]) {
        [requestDelegate performSelector:didFinish withObject:self withObject:response];
    }
}

#pragma clang diagnostic pop

#pragma mark -
#pragma mark Public Methods


- (NSString*) getReqName {
    return requestName;
}

@end
