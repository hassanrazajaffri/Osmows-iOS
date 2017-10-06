//
//  ImageCommon.h
//  Advansoft
//
//  Created by Muhammad Baqir on 5/8/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCommon : NSObject

+ (NSString*) getImagesDocumentPath;
+ (UIImage*) getImage:(NSString*)imageName;
+ (BOOL)saveImage:(UIImage*)image withName:(NSString*)imageName;
+ (BOOL)deleteImage:(NSString*)imageName;


@end
