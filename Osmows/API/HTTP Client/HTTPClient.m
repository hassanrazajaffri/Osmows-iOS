//
//  HttpClient.m
//  Advansoft
//
//  Created by Faizan Ali on 6/30/13.
//  Copyright (c) 2013 Faizan Ali. All rights reserved.
//

#import "HTTPClient.h"
#import "HTTPCommon.h"
#import "AFXMLRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "Url.h"

@implementation HTTPClient
@synthesize networkConnected;

+ (id)sharedHTTPClient
{
    static dispatch_once_t pred = 0;
    static id __httpClient = nil;
//    dispatch_once(&pred, ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@" ,[HTTPCommon getBaseUrl]]];
        __httpClient = [[self alloc] initWithBaseURL:url];
//    });
    return __httpClient;
}


- (id)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
        
    return self;
}

-(NSMutableURLRequest*)requestWithMethod:(NSString *)method
                                    path:(NSString *)path
                              parameters:(NSDictionary *)parameters
                                    data:(NSData*)data;
{
    NSMutableURLRequest* request = [super requestWithMethod:method
                                                       path:path
                                                 parameters:parameters];
    [request addValue:path forHTTPHeaderField:@"SOAPAction"];
    [request setHTTPBody:data];
    
    return request;
}



@end
