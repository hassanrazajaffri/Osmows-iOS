//
//  DCCIRequest.h
//  DubaiChamber
//
//  Created by Faizan Ali on 10/8/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"

@protocol DPRequestDelegate <NSObject>
@end

#define dpAppVersion @"iOS-1.1"

@interface BaseRequest : NSObject  {
    
    SEL didFinish;
    SEL didFail;
    __weak id<DPRequestDelegate> delegate;
    HTTPRequest *httRequest;
    NSString *requestName;
    NSDictionary *requestParams;
    NSDictionary *userInfo;
    BOOL isFirstTime;
    BOOL responseSuccess;
//    NSString *responseMessage;
//    NSString *responseStatusCode;
    NSArray *keys;
    BOOL isShown;
   
}


@property(nonatomic,assign) int responseCode;
@property(nonatomic,strong) NSString *responseTitle;
@property(nonatomic,strong) NSString *responseDescription;

@property (nonatomic,assign) SEL didFinish;
@property (nonatomic,assign) SEL didFail;
@property (nonatomic,weak) id<DPRequestDelegate> delegate;
@property (nonatomic,strong) NSString *requestName;
@property (nonatomic,strong) NSString *requestService;
@property (nonatomic,strong) NSDictionary *requestParams;
@property (nonatomic,strong) NSDictionary *userInfo;
@property (nonatomic,readonly) BOOL responseSuccess;
@property (nonatomic,readonly) NSString *responseMessage;
@property (nonatomic,readonly) NSString *responseStatusCode;


- (void) cancelRequest;
- (void) makeRequest:(id)delegate finishSel:(SEL)didFinish failSel:(SEL)didFail;
- (void) makeRequest_takeAway:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail ;
- (void) makeRequestWithOrderId:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail withOrderID: (NSString *)orderID  tableId: (NSString *)tableID;
- (void) didReceiveResponse:(id)response parsedResult:(id)object;
- (void) didReceiveFailed:(NSError*)error;
- (void) makeRequestWithOrderId:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail withOrderID: (NSString *)orderID  tableId: (NSString *)tableID  withTime:(NSString *) WaitTime ;

@end
