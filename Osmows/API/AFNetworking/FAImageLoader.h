//
//  FAImageLoader.h
//  Enoc
//
//  Created by Faizan Ali on 4/15/14.
//  Copyright (c) 2014 Enoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFImageRequestOperation.h"

#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <UIKit/UIKit.h>

@interface FAImageLoader : NSObject {
    
}

@property (readwrite, nonatomic, strong, setter = af_setImageRequestOperation:) AFImageRequestOperation *af_imageRequestOperation;

- (void)loadImageWithURL:(NSURL *)url
                         cache:(BOOL)cache
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

- (void)cancelImageRequestOperation;

+ (FAImageLoader *) sharedInstance;

@end

#endif
