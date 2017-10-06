//
//  NSDate+Utility.h
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/1/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utility)

+ (NSString*) stringFromDate:(NSDate*)date withFormat:(NSString*)format;
+ (NSDate*) dateFromString:(NSString*)date withFormat:(NSString*)format;

+ (NSString *)getUTCFormateDate:(NSDate*)date;
+ (NSString *)getCurrentDateTime;
@end
