//
//  AnimationUtility.h
//
//  Created by Mosib
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define kTransitionKey @"transitionViewAnimation"
#define kFadeKey @"fadeViewAnimation"
#define kMovetKey @"moveViewAnimation"
#define kRotateKey @"rotateViewAnimation"
#define kNavigateKey @"navigateViewAnimation"
#define kCurlKey @"curlViewAnimation"
#define kFlipKey @"flipViewAnimation"

@interface AnimationUtility : NSObject {

}

+ (void)transition:(UIView*)view fromDirection:(NSString*)direction withDuration:(CFTimeInterval)duration delegateTarget:(id)target;

+ (void)transition:(UIView*)aView fromDirection:(NSString*)direction withObject:(id)object forKey:(NSString*)objectKey withDuration:(CFTimeInterval)duration delegateTarget:(id)target;

+ (void)fade:(UIView*)currentView nextView:(UIView*)nextView withDuration:(CFTimeInterval)duration;

+ (void)fadeIn:(UIView*)view withDuration:(CFTimeInterval)duration;

+ (void)fadeIn:(UIView*)view withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector;

+ (void)fadeOut:(UIView*)view withDuration:(CFTimeInterval)duration;

+ (void)fadeOut:(UIView*)view withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector;

+ (void)moveRelative:(UIView*)view fromX:(CGFloat)deltaX andY:(CGFloat)deltaY withDuration:(CFTimeInterval)duration;

+ (void)moveAbsolute:(UIView*)view toX:(CGFloat)centerX andY:(CGFloat)centerY withDuration:(CFTimeInterval)duration;

+ (void)moveAbsolute:(UIView*)view toX:(CGFloat)centerX andY:(CGFloat)centerY withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector;

+ (void)rotate:(UIView*)view fromAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration;

+ (void)rotate:(UIView*)view fromAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector withUserInfo:(NSDictionary*)userInfo;

+ (void)curl:(UIView*)view curlTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration;

+ (void)flip:(UIView*)view flipTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration;

+ (void)flip:(UIView*)view flipTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector;

+ (void)flipFromGoingController:(UIViewController*)goingContrller toIncomingController:(UIViewController*)incomingController atView:(UIView*)handlerView withDuration:(CFTimeInterval)duration flipTransition:(UIViewAnimationTransition)transition target:(id)target endSelector:(SEL)endSelector;

+ (void)view:(UIView*)view animationTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector;

+(void)moveFrame:(UIView *)view withFrame:(CGRect)frame withDuration:(CFTimeInterval)duration;

+(void)moveFrame:(UIView *)view withFrame:(CGRect)frame withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector;

+(void)resizeFrame:(UIView *)view withSize:(CGSize)_size withDuration:(CFTimeInterval)duration;

@end
