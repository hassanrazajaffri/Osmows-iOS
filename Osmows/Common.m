//
//  Common.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/22/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "Common.h"
//#import "Messages.h"
#import "AppSettings.h"
#import "AppDelegate.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "SAMKeychain.h"
#import "ListingTables.h"
#import "KitchenViewController.h"
#import "HelpViewController.h"
#import "TSAlertViewInput.h"
#import <QuartzCore/QuartzCore.h>
@implementation Common 

static UIView *activityView;
static UIActivityIndicatorView*activityIndicator;
static bool isShowing;

+ (BOOL) isIPad {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return false;
    
    return true;
}

+ (BOOL) isIPhone4 {
    
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    return (height == 480);
}

+ (BOOL) isIPadPro {
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat width = mainScreen.nativeBounds.size.width / mainScreen.nativeScale;
    CGFloat height = mainScreen.nativeBounds.size.height / mainScreen.nativeScale;
    BOOL isIpad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    BOOL hasIPadProWidth = fabs(width - 1024.f) < DBL_EPSILON;
    BOOL hasIPadProHeight = fabs(height - 1366.f) < DBL_EPSILON;
    return isIpad && hasIPadProHeight && hasIPadProWidth;
}

+ (float) iPadProScalableWidth:(float) pWidth {
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat width = mainScreen.nativeBounds.size.height / mainScreen.nativeScale;
    
    CGFloat scaleableWidth = (pWidth/1024) * width;
    return scaleableWidth;
}

+ (float) iPadProScalableHeight:(float) pHeight {

    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat height = mainScreen.nativeBounds.size.width / mainScreen.nativeScale;
    CGFloat scaleableHeight = (pHeight/768) * height;
    return scaleableHeight;

}





+ (NSString*) loadNibName:(NSString*)nibName {
    return nibName;
}


+ (CGFloat) getAsepectedFontSize:(CGFloat)pointSize {
    CGRect  screenRect = [[UIScreen mainScreen] bounds];
    CGFloat newPointSize = (screenRect.size.height/480.0)*pointSize;
    return newPointSize;
}

+ (CGPoint) getAsepectedPosition:(CGPoint)point {
    CGRect  screenRect = [[UIScreen mainScreen] bounds];
    CGFloat newPointX = (screenRect.size.height/480.0)*point.x;
    CGFloat newPointY = (screenRect.size.width/320.0)*point.y;
    return CGPointMake(newPointX,newPointY);
}

+ (CGSize) getAsepectedSize:(CGSize)size {
    CGRect  screenRect = [[UIScreen mainScreen] bounds];
    CGFloat newWidth = (screenRect.size.height/480.0)*size.width;
    CGFloat newHeight = (screenRect.size.width/320.0)*size.height;
    return CGSizeMake(newWidth,newHeight);
}

+ (id) loadNibName:(NSString*)nibName owner:(id)owner options:(NSDictionary*)options {
    id cell = [[[NSBundle mainBundle]loadNibNamed:nibName owner:owner options:options]lastObject];
    return  cell;
}

+ (BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL) isValidatePhoneNumber:(NSString *)number {
    if (number == nil || ([number length] < 2 ) )
        return NO;
    
    return YES;
    
    //:TODO Not Working Algorithm correct number below to 7 digits
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    NSArray *matches = [detector matchesInString:number options:0 range:NSMakeRange(0, [number length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            NSString *phoneNumber = [match phoneNumber];
            if ([number isEqualToString:phoneNumber]) {
                return YES;
            }
        }
    }
    
    return NO;
}

+ (BOOL) isValidMobileNumer:(NSString*)number {
    NSString *regex = @"05[0-9]{8}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL val = [predicate evaluateWithObject:number];
    
    return val;
}

+(BOOL) isNumber:(NSString*) str
{
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"] invertedSet];
    if ([str rangeOfCharacterFromSet:set].location != NSNotFound) {
        return NO;
    }
    return YES;
    
//    NSString *strMatchstring=@"\\b([0-9%_.+\\-]+)\\b"; 
//    NSPredicate *textpredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", strMatchstring];
//    
//    if(![textpredicate evaluateWithObject:str])
//    {
//        return FALSE;
//    }
//    return TRUE;
}

+ (id)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...  {
    
    message = [message stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
   // UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
   // alert.tag = tag;
    
    TSAlertView *alert = [[TSAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    alert.tag=tag;

    if (otherButtonTitles) {
        va_list _arguments;
        va_start(_arguments, otherButtonTitles);
        
        for (NSString *_currentArgument = otherButtonTitles; _currentArgument != nil; _currentArgument = va_arg(_arguments, NSString*)) {
            [alert addButtonWithTitle:_currentArgument];
        }
        va_end(_arguments);
        
    }
    

    [alert show];
    
    return alert;
    
}
+ (id)showAlertWithinputPassword:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...  {
    
    message = [message stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    // UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    // alert.tag = tag;
    
    TSAlertViewInput *alert = [[TSAlertViewInput alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
    alert.style=TSAlertViewStyleInput;
    alert.tag=tag;
    
    if (otherButtonTitles) {
        va_list _arguments;
        va_start(_arguments, otherButtonTitles);
        
        for (NSString *_currentArgument = otherButtonTitles; _currentArgument != nil; _currentArgument = va_arg(_arguments, NSString*)) {
            [alert addButtonWithTitle:_currentArgument];
        }
        va_end(_arguments);
        
    }
    
    
    [alert show];
    
    return alert;
    
}



+ (NSString*) getImagesDocumentPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
//    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",kImages]];
    return path;
}


+ (void) showLoader {
    
    [CustomLoader showLoader];
    return;

    if (isShowing) {
        return;
    }
    isShowing = YES;
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    activityView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    activityView.backgroundColor = [UIColor blackColor];
    activityView.userInteractionEnabled = YES;
    activityView.alpha = 0.3;
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = activityView.center;
    [activityIndicator hidesWhenStopped];
    [activityIndicator startAnimating];
    [delegate.window addSubview:activityIndicator];
    
    [delegate.window addSubview:activityView];
}

+ (void) hideLoader {
    [CustomLoader hideLoader];
    return;

    if (!isShowing) {
        return;
    }
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    [activityView removeFromSuperview];
    activityIndicator=nil;
    activityView=nil;
    isShowing = NO;
    
}

+ (BOOL) showAlertIfNotInternetNotAvailable {
    BOOL isConnected = true;//= [appDelegate checkConnection]; // : TODO
    if (!isConnected) {
         //[Common showAlertWithTitle:kNetWorkErrorTitle message:kNetWorkErrorMessage delegate:nil cancelButtonTitle:kOk otherButtonTitles: nil];
    }
    return isConnected;
}

+ (NSString*) getDeviceName {
    if ([Common isIPad]) {
        return @"iPad";
    }
    return @"iPhone";

}

+ (BOOL) openWebURL:(NSString*)url {

   
    
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (BOOL)canMakeCall {
    /*
     
     Returns YES if the device can place a phone call
     
     */
    
    // Check if the device can place a phone call
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        // Device supports phone calls, lets confirm it can place one right now
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [netInfo subscriberCellularProvider];
        NSString *mnc = [carrier mobileNetworkCode];
        if (([mnc length] == 0) || ([mnc isEqualToString:@"65535"])) {
            // Device cannot place a call at this time.  SIM might be removed.
            return NO;
        } else {
            // Device can place a phone call
            return YES;
        }
    } else {
        // Device does not support phone calls
        return  NO;
    }
}


+ (void) sendSMS:(NSString*)body withRecipients:(NSArray*)recipients withDelegate:(id)delegate {
    
    
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {        
        controller.body = body;
        controller.recipients = recipients;
        controller.messageComposeDelegate = delegate;
        [delegate presentModalViewController:controller animated:YES];
    }
}


+ (NSString *)createUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

//    static SERVER_MODE mode = STAGING; // Update in url.h

//TEST ENVIRONMENT FOR UAT => YES
//TEST ENVIRONMENT FOR PRODUCTION => NO
+(BOOL) isTestEnvironment{
    return YES;
}

+(UIImage*) getImage:(NSString*) base64String{
    NSData* data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    UIImage* image = [UIImage imageWithData:data];
    return image;
}


+(NSString*) getStringFromImage:(UIImage*) image{
    NSData *dataImage = [[NSData alloc] init];
    dataImage = UIImagePNGRepresentation(image);
    NSString *stringImage = [dataImage base64EncodedStringWithOptions:0];
    return stringImage;
}

+ (NSString*)encodeURLString:(NSString*)string
{
    NSString *encodedString = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return encodedString;
}
+ (void)showGuestSelection
{
    ListingTables *requestL=[[ListingTables alloc] init];
    [requestL makeRequest:self finishSel:@selector(requestRecievedListing:withResponse:) failSel:@selector(requestFailedListing:withResponse:)];
}
+ (void)requestRecievedListing:(BaseRequest *)request withResponse:(id)response {
    
    [Common hideLoader];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([Common isIPadPro])
    {
        TableSelectionViewController *objTable= (TableSelectionViewController*) [storyboard instantiateViewControllerWithIdentifier:@"TableSelectionViewControllerPro"];
        if(![[appdelegate.window.rootViewController presentedViewController] isKindOfClass:[UIAlertController class]])
        {
           // [[[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view] setHidden:YES];
        //self.splitViewController.maximumPrimaryColumnWidth=0;
            if ([appdelegate.window.rootViewController isKindOfClass:[KitchenViewController class]]) {
                CATransition* transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.type = kCATransitionReveal;
                transition.delegate = self;
                transition.subtype = kCATransitionFromBottom;
                [ appdelegate.window.layer addAnimation:transition
                                                 forKey:kCATransition];
            }
    
        
      //  [self.navigationController popToRootViewControllerAnimated:NO];

            appdelegate.window.rootViewController=objTable;

        }
    }
    else{
//        CATransition* transition = [CATransition animation];
//        transition.duration = 1.0f;
//        transition.type = kCATransitionReveal;
//        //  transition.delegate = self;
//        transition.subtype = kCATransitionFromBottom;
//        [ appdelegate.window.layer addAnimation:transition
//                                         forKey:kCATransition];

        TableSelectionViewController *objTable= (TableSelectionViewController*) [storyboard instantiateViewControllerWithIdentifier:@"TableSelectionViewController"];
        if(![[appdelegate.window.rootViewController presentedViewController] isKindOfClass:[UIAlertController class]])
            if ([appdelegate.window.rootViewController isKindOfClass:[KitchenViewController class]]) {
                CATransition* transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.type = kCATransitionReveal;
                transition.delegate = self;
                transition.subtype = kCATransitionFromBottom;
                [ appdelegate.window.layer addAnimation:transition
                                                 forKey:kCATransition];
            }

            appdelegate.window.rootViewController=objTable;
 
    
    }
   
}
+ (void)requestFailedListing:(BaseRequest *)request withResponse:(id)response {
        [Common showAlertWithTitle:nil message:response delegate:nil withTag:2 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [Common hideLoader];
}

+(void) showLoginViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    LoginViewController *objTable= (LoginViewController*) [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appdelegate.window.rootViewController=objTable;
}

+(void) showHelpViewController{
    
    UISplitViewController *splitViewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"SplitViewController"];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HelpViewController *helpController= (HelpViewController*) [storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
    [splitViewController presentViewController:helpController animated:NO completion:NULL];

}

+(void) playAddSound{
    NSString *path = [NSString stringWithFormat:@"%@/beep.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    AVAudioPlayer* _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayer play];
    
}

+(void) playRemovalSound{
    NSString *path = [NSString stringWithFormat:@"%@/beepRemove.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    AVAudioPlayer* _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayer play];
    
}
+(UIButton*)addGradientToButton:(UIButton*) customButton
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = customButton.layer.bounds;
    
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[UIColor colorWithWhite:1.0f alpha:1.0f].CGColor,
                            (id)[UIColor colorWithWhite:0.4f alpha:1.0f].CGColor,
                            nil];
    
    gradientLayer.locations = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0f],
                               [NSNumber numberWithFloat:1.0f],
                               nil];
    
    gradientLayer.cornerRadius = customButton.layer.cornerRadius;
    [customButton.layer addSublayer:gradientLayer];
    return customButton;
}

+(void)saveUserInfo:(User*)objUser
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:objUser];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUsersInfo];
}
+(void)saveWaiterInfo:(Waiter*)objUser
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:objUser];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaiterInfo];
}
+(User*)getUserInfo
{
    NSData *notesData = [[NSUserDefaults standardUserDefaults] objectForKey:kUsersInfo];
    User *objuser = [NSKeyedUnarchiver unarchiveObjectWithData:notesData];
    if(objuser)
    {
        [[User sharedInstance] setResturantID:objuser.resturantID];
        [[User sharedInstance] setLoginKey:objuser.loginKey];
        [[User sharedInstance] setUserID:objuser.userID];
        [[User sharedInstance] setUserName:objuser.userName];
        [[User sharedInstance] setRestaurantNameEN:objuser.restaurantNameEN];
        [[User sharedInstance] setRestaurantNameAR:objuser.restaurantNameAR];
        
        [[User sharedInstance] setRestaurantDetailsEN:objuser.restaurantDetailsEN];
        [[User sharedInstance] setRestaurantDetailsAR:objuser.restaurantDetailsAR];

        
        [[User sharedInstance] setRestaurantBackgroundImage:objuser.restaurantBackgroundImage];
        [[User sharedInstance] setRestaurantLogo:objuser.restaurantLogo];
        [[User sharedInstance] setTextureImageLogo:objuser.textureImageLogo];
        [[User sharedInstance] setProductFeature:objuser.ProductFeature];
        [[User sharedInstance] setFeatureList:objuser.featureList];



    }
    else
    {
        [[User sharedInstance] setResturantID:nil];
        [[User sharedInstance] setLoginKey:nil];
        [[User sharedInstance] setUserID:nil];
        [[User sharedInstance] setUserName:nil];
        [[User sharedInstance] setRestaurantNameEN:nil];
        [[User sharedInstance] setRestaurantNameAR:nil];
        [[User sharedInstance] setRestaurantDetailsEN:nil];
        [[User sharedInstance] setRestaurantDetailsAR:nil];
        [[User sharedInstance] setRestaurantBackgroundImage:nil];
        [[User sharedInstance] setRestaurantLogo:nil];
        [[User sharedInstance] setTextureImageLogo:nil];
        [[User sharedInstance] setProductFeature:nil];
        [[User sharedInstance] setFeatureList:nil];
    }
    return objuser;
}
+(Waiter*)getWaiterInfo
{
    NSData *notesData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaiterInfo];
    Waiter *objuser = [NSKeyedUnarchiver unarchiveObjectWithData:notesData];
    if(objuser)
    {
        [[Waiter sharedInstance] setResturantID:objuser.resturantID];
        [[Waiter sharedInstance] setLoginKey:objuser.loginKey];
        [[Waiter sharedInstance] setUserID:objuser.userID];
        [[Waiter sharedInstance] setUserName:objuser.userName];
        [[Waiter sharedInstance] setRestaurantNameEN:objuser.restaurantNameEN];
        [[Waiter sharedInstance] setRestaurantNameAR:objuser.restaurantNameAR];
        [[Waiter sharedInstance] setRestaurantBackgroundImage:objuser.restaurantBackgroundImage];
        [[Waiter sharedInstance] setRestaurantLogo:objuser.restaurantLogo];
        [[Waiter sharedInstance] setTextureImageLogo:objuser.textureImageLogo];
        [[Waiter sharedInstance] setProductFeature:objuser.ProductFeature];
        [[Waiter sharedInstance] setFeatureList:objuser.featureList];
        
        
        
    }
    else
    {
        [[Waiter sharedInstance] setResturantID:nil];
        [[Waiter sharedInstance] setLoginKey:nil];
        [[Waiter sharedInstance] setUserID:nil];
        [[Waiter sharedInstance] setUserName:nil];
        [[Waiter sharedInstance] setRestaurantNameEN:nil];
        [[Waiter sharedInstance] setRestaurantNameAR:nil];
        [[Waiter sharedInstance] setRestaurantBackgroundImage:nil];
        [[Waiter sharedInstance] setRestaurantLogo:nil];
        [[Waiter sharedInstance] setTextureImageLogo:nil];
        [[Waiter sharedInstance] setProductFeature:nil];
        [[Waiter sharedInstance] setFeatureList:nil];
    }

    return objuser;
}

+(BOOL)canOrder
{
    BOOL isAllow=NO;
    NSMutableArray *productFeatures=[[NSMutableArray alloc] initWithArray:[User sharedInstance].ProductFeature];
    for (int i=0; i<[productFeatures count]; i++) {
        NSString *featureID=[productFeatures objectAtIndex:i];
        if ([featureID isEqualToString:@"2"]) {
            isAllow=YES;
        }
    }
    return isAllow;
}
+ (void) setBlurImage:(UIImageView *)imageview
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0 , 0, 1024, 688)];
    if ([Common isIPadPro]) {
        blurView.frame = CGRectMake(0 , 0, [Common iPadProScalableWidth:1366] , [Common iPadProScalableHeight:720]);

    }
    [blurView setDynamic:NO];
    
    [blurView setBlurRadius:10];
    [blurView setIterations:2];
    [imageview addSubview:blurView];
}
+ (void) setBlurImageFullSceen:(UIImageView *)imageview
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    if ([Common isIPadPro]) {
//        blurView.frame = CGRectMake(0 , 0, [Common iPadProScalableWidth:849] , [Common iPadProScalableHeight:698]);
//        
//    }
    [blurView setDynamic:NO];
    
    [blurView setBlurRadius:10];
    [blurView setIterations:2];
    [imageview addSubview:blurView];
}
+(UIImage *) getImageFromURL:(NSString *)fileURL {
    __block UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
//
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//      result = [UIImage imageWithData:data];
//    });

        result = [UIImage imageWithData:data];
    
    return result;
}
+ (NSString *)getDeviceId {
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    NSString *strApplicationUUID = [SAMKeychain passwordForService:appName account:@"DeviceKey"];
    if (strApplicationUUID == nil) {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SAMKeychain setPassword:strApplicationUUID forService:appName account:@"DeviceKey"];
    }
    return strApplicationUUID;
}
+(void) saveImageWithPath:(UIImage *)image withFilePath:(NSString *)filePath withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
 
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
   
}
+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)dirjectoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[dirjectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        
        
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[dirjectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
        
        
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}
+(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}
+(UIFont *)DubaiBoldWithSize:(int)size
{
    return [UIFont fontWithName:@"Dubai-Bold" size:size];
}
+(UIFont *)DubaiLightWithSize:(int)size
{
    return [UIFont fontWithName:@"Dubai-Light" size:size];
}
+(UIFont *)DubaiMediumWithSize:(int)size
{
    return [UIFont fontWithName:@"Dubai-Medium" size:size];
}
+(UIFont *)DubaiRegularWithSize:(int)size
{
    return [UIFont fontWithName:@"Dubai-Regular" size:size];
}
@end
