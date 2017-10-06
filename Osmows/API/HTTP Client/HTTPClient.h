//
//  HttpClient.h
//  Advansoft
//
//  Created by Faizan Ali on 6/30/13.
//  Copyright (c) 2013 Faizan Ali. All rights reserved.
//

#import "AFHTTPClient.h"

@interface HTTPClient : AFHTTPClient {
    BOOL networkConnected;
}

@property (nonatomic,assign) BOOL networkConnected;

+ (id)sharedHTTPClient;

-(NSMutableURLRequest*)requestWithMethod:(NSString *)method
                                    path:(NSString *)path
                              parameters:(NSDictionary *)parameters
                                    data:(NSData*)data;
@end

