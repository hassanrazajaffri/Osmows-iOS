//
//  Common.h
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/22/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "LoginViewController.h"
#import "User.h"
#import "Waiter.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_LESS_THAN_7    ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#ifdef __IPHONE_6_0 // iOS6 and later
#   define UITextAlignmentCenter    NSTextAlignmentCenter
#   define UITextAlignmentLeft      NSTextAlignmentLeft
#   define UITextAlignmentRight     NSTextAlignmentRight
#   define UILineBreakModeTailTruncation     NSLineBreakByTruncatingTail
#   define UILineBreakModeMiddleTruncation   NSLineBreakByTruncatingMiddle
#endif
#define kBASE_URL @"kBaseUrl"
#define kDEVICE_ID @"kDeviceId"
#define HEX_COLOR_DEFAULT @"febd19"

@interface Common : NSObject


+ (BOOL) isIPad;
+ (NSString*) loadNibName:(NSString*)nibName;
+ (CGFloat) getAsepectedFontSize:(CGFloat)pointSize;
+ (CGPoint) getAsepectedPosition:(CGPoint)point;
+ (CGSize) getAsepectedSize:(CGSize)size;
+(BOOL)canOrder;
+(void)saveWaiterInfo:(Waiter *)objUser;
+(Waiter*)getWaiterInfo;
+ (NSString *)getDeviceId ;
+(UIFont *)DubaiBoldWithSize:(int)size;
+(UIFont *)DubaiLightWithSize:(int)size;
+(UIFont *)DubaiMediumWithSize:(int)size;
+(UIFont *)DubaiRegularWithSize:(int)size;
+ (id) loadNibName:(NSString*)nibName owner:(id)owner options:(NSDictionary*)options;
+ (BOOL) isValidEmail:(NSString *)checkString;
+ (BOOL) isValidatePhoneNumber:(NSString *)number;
+ (BOOL) isValidMobileNumer:(NSString*)number;
+ (BOOL) isNumber:(NSString*) str;
+ (id)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
+ (id)showAlertWithinputPassword:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... ;
+ (void) showLoader;
+ (void) hideLoader;
+ (NSString*) getImagesDocumentPath;
+ (BOOL) showAlertIfNotInternetNotAvailable;
+ (NSString*) getDeviceName;
+ (BOOL) openWebURL:(NSString*)url;
+ (BOOL) canMakeCall;
+(void)makeCall : (NSString* )number numberName:(NSString *)numberName;
+ (void) sendSMS:(NSString*)body withRecipients:(NSArray*)recipients withDelegate:(id)delegate;
+ (NSString *)createUUID;
+(BOOL) isTestEnvironment;
+ (BOOL) isIPhone4;
+(UIImage*) getImage:(NSString*) base64String;
+(NSString*) getStringFromImage:(UIImage*) image;
+ (NSString*)encodeURLString:(NSString*)string;
+(void)showGuestSelection;
+(void) playRemovalSound;
+(void) playAddSound;
+(void) showLoginViewController;
+(void) showHelpViewController;
+(UIButton*)addGradientToButton:(UIButton*) customButton;

+(void)saveUserInfo:(User*)objUser;
+(User*) getUserInfo;
+ (void) setBlurImage:(UIImageView *)imageview;
+ (BOOL) isIPadPro;
+ (float) iPadProScalableWidth:(float) pWidth;
+ (float) iPadProScalableHeight:(float) pHeight;
+ (void) setBlurImageFullSceen:(UIImageView *)imageview;
+(UIImage *) getImageFromURL:(NSString *)fileURL;
+(void) saveImage:(UIImage *)image  withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
+(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
+(void) saveImageWithPath:(UIImage *)image withFilePath:(NSString *)filePath  withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

@end
