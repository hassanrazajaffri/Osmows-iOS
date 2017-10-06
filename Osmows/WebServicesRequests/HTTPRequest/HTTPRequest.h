//
//  HTTPRequest.h
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SCURL.h"

@class HTTPRequest;

@protocol HTTPRequestDelegate <NSObject>

@optional
- (void)requestStarted:(HTTPRequest *)request;
- (void)request:(HTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(HTTPRequest *)request willRedirectToURL:(NSURL *)newURL;
- (void)requestFinished:(HTTPRequest *)request;
- (void)requestFailed:(HTTPRequest *)request;
- (void)requestRedirected:(HTTPRequest *)request;
// When a delegate implements this method, it is expected to process all incoming data itself
// This means that responseData / responseString / downloadDestinationPath etc are ignored
// You can have the request call a different method by setting didReceiveDataSelector
- (void)request:(HTTPRequest *)request didReceiveData:(NSData *)data;

@end

@interface HTTPRequest : ASIHTTPRequest {
    NSDictionary *responseDictonary;
    NSString *requestName;
  //  id<HTTPRequestDelegate> requestDelegate;
    SEL didFinish;
    SEL didFail; 
}

@property (nonatomic,retain) NSString *requestName;
@property (nonatomic,assign) SEL didFinish;
@property (nonatomic,assign) SEL didFail;
@property (nonatomic,assign) id<HTTPRequestDelegate> requestDelegate;


+ (id) requestWithURL:(NSURL *)newURL requestDictonary:(NSDictionary*)dic delegate:(id)delegate didFinished:(SEL)finish didFailed:(SEL)failed userInfo:(NSDictionary*)userInfo;

- (NSDictionary*) reponseDictonary;
- (NSString*) getReqName;

@end
