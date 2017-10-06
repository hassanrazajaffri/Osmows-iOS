//
//  NSDate+Utility.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/1/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)


+ (NSString*) stringFromDate:(NSDate*)date withFormat:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:format];
    [formatter setLocale: usLocale];
    NSString *dt = [formatter stringFromDate:date];
    return dt;
}

+ (NSDate*) dateFromString:(NSString*)date withFormat:(NSString*)format {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale: usLocale];
    [df setDateFormat:format];
//    NSDate *enDate =[[[NSDate alloc] init]autorelease];
    NSDate *enDate = [df dateFromString:date];   
    return enDate;
}

+ (NSString *)getUTCFormateDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSComparisonResult)customCompare:(id)toDate {
    // Complex comparator contents
    return [self compare:toDate];
}

+(NSString*)getCurrentDateTime
{
    NSDate* sourceDate = [NSDate date];
    
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
//    
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    
//    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:sourceDate];
}

@end
