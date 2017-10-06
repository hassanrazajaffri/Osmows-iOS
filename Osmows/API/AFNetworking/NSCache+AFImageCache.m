//
//  NSCache+AFImageCache.m
//  Enoc
//
//  Created by Faizan Ali on 4/15/14.
//  Copyright (c) 2014 Enoc. All rights reserved.
//

#import "NSCache+AFImageCache.h"
#import <CommonCrypto/CommonDigest.h>
#import "ImageCommon.h"


static inline NSString * AFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

@implementation AFImageCache

- (NSString*)cacheImageName:(NSString*)key {
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request fromDisk:(BOOL)cache {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
    UIImage *image = [self objectForKey:AFImageCacheKeyFromURLRequest(request)];
    if (image == nil && cache) {
        image = [ImageCommon getImage:[request.URL absoluteString]];
        
    }
    
	return image;
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request save:(BOOL) save
{
    if (image && request) {
        if (save) {
            [ImageCommon saveImage:image withName:[request.URL absoluteString]];
            
        }
        
        [self setObject:image forKey:AFImageCacheKeyFromURLRequest(request)];
    }
}

@end

