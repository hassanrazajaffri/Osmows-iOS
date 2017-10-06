//
//  NSCache+AFImageCache.h
//  Enoc
//
//  Created by Faizan Ali on 4/15/14.
//  Copyright (c) 2014 Enoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFImageCache : NSCache

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request fromDisk:(BOOL)cache;
- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request save:(BOOL) save;

@end
