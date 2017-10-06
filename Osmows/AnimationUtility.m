//
//  AnimationUtility.m
//  Created by Mosib
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AnimationUtility.h"


@implementation AnimationUtility

+ (void)transition:(UIView*)aView fromDirection:(NSString*)direction withDuration:(CFTimeInterval)duration delegateTarget:(id)target {
	// Chose transition type and direction at random from the arrays of supported transitions and directions
	NSArray *transitions = [NSArray arrayWithObjects:kCATransitionPush, nil];
	NSString *transition = [transitions objectAtIndex:0];
	
	// Set up the animation
	CATransition *animation = [CATransition animation];
	
	if (target)
		[animation setDelegate:target];
	
	// Set the type and if appropriate direction of the transition, 
	[animation setType:transition];
	[animation setSubtype:direction];
	
	// Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
	[animation setDuration:duration];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[aView layer] addAnimation:animation forKey:kTransitionKey];
}

+ (void)transition:(UIView*)aView fromDirection:(NSString*)direction withObject:(id)object forKey:(NSString*)objectKey withDuration:(CFTimeInterval)duration delegateTarget:(id)target {
	// Chose transition type and direction at random from the arrays of supported transitions and directions
	NSArray *transitions = [NSArray arrayWithObjects:kCATransitionPush, nil];
	NSString *transition = [transitions objectAtIndex:0];
	
	// Set up the animation
	CATransition *animation = [CATransition animation];
	
	if (target)
		[animation setDelegate:target];
	
	// Set the type and if appropriate direction of the transition,
	[animation setType:transition];
	[animation setSubtype:direction];
    [animation setValue:object forKey:objectKey];
	
	// Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
	[animation setDuration:duration];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[aView layer] addAnimation:animation forKey:kTransitionKey];
}

+ (void)fade:(UIView*)currentView nextView:(UIView*)nextView withDuration:(CFTimeInterval)duration {
	[UIView beginAnimations:kFadeKey context:nil];
	[UIView setAnimationDuration:duration];
	currentView.alpha = 0.0;
	nextView.alpha = 1.0;
	[UIView commitAnimations];
}

+ (void)fadeIn:(UIView*)view withDuration:(CFTimeInterval)duration {
	[UIView beginAnimations:kFadeKey context:nil];
	[UIView setAnimationDuration:duration];
	view.alpha = 1.0;
	[UIView commitAnimations];
}

+ (void)fadeIn:(UIView*)view withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector {
	[UIView beginAnimations:kFadeKey context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:target];
	[UIView setAnimationDidStopSelector:endSelector];
	view.alpha = 1.0;
	[UIView commitAnimations];
}

+ (void)fadeOut:(UIView*)view withDuration:(CFTimeInterval)duration {
	[UIView beginAnimations:kFadeKey context:nil];
	[UIView setAnimationDuration:duration];
	view.alpha = 0.0;
	[UIView commitAnimations];
}

+ (void)fadeOut:(UIView*)view withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector {
	[UIView beginAnimations:kFadeKey context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:target];
	[UIView setAnimationDidStopSelector:endSelector];
	view.alpha = 0.0;
	[UIView commitAnimations];
}


+ (void)moveRelative:(UIView*)view fromX:(CGFloat)deltaX andY:(CGFloat)deltaY withDuration:(CFTimeInterval)duration {
	if (duration > 0) {
		[UIView beginAnimations:kMovetKey context:nil];
		[UIView setAnimationDuration:duration];
		[view setCenter:CGPointMake(view.center.x + deltaX, view.center.y + deltaY)];
		[UIView commitAnimations];
	}
	else {
		[view setCenter:CGPointMake(view.center.x + deltaX, view.center.y + deltaY)];
	}
}

+ (void)moveAbsolute:(UIView*)view toX:(CGFloat)centerX andY:(CGFloat)centerY withDuration:(CFTimeInterval)duration {
	if (duration > 0) {
		[UIView beginAnimations:kMovetKey context:nil];
		[UIView setAnimationDuration:duration];
		[view setCenter:CGPointMake(centerX, centerY)];
		[UIView commitAnimations];
	}
	else {
		[view setCenter:CGPointMake(centerX, centerY)];
	}
}

+ (void)moveAbsolute:(UIView*)view toX:(CGFloat)centerX andY:(CGFloat)centerY withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector {
	if (duration > 0) {
		[UIView beginAnimations:kMovetKey context:nil];
		[UIView setAnimationDuration:duration];
		CGRect popupFrame = CGRectMake(view.frame.origin.x,400,view.frame.size.width,522);
		view.frame = popupFrame;
		
		[UIView commitAnimations];
	}
	else {
		[view setCenter:CGPointMake(centerX, centerY)];
	}
}

+(void)moveFrame:(UIView *)view withFrame:(CGRect)frame withDuration:(CFTimeInterval)duration {
	if (duration > 0) {
		[UIView beginAnimations:kMovetKey context:nil];
		[UIView setAnimationDuration:duration];
		view.frame = frame;
		[UIView commitAnimations];
	}
	else {
		view.frame = frame;
	}
}

+(void)moveFrame:(UIView *)view withFrame:(CGRect)frame withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector {
	if (duration > 0) {
		[UIView beginAnimations:kMovetKey context:nil];
		[UIView setAnimationDuration:duration];
		[UIView setAnimationDelegate:target];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDidStopSelector:endSelector];
		view.frame = frame;
		[UIView commitAnimations];
	}
	else {
		view.frame = frame;
	}
}

+(void)resizeFrame:(UIView *)view withSize:(CGSize)_size withDuration:(CFTimeInterval)duration {
	if (duration > 0) {
		[UIView beginAnimations:kMovetKey context:nil];
		[UIView setAnimationDuration:duration];
		view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, _size.width, _size.height);
		[UIView commitAnimations];
	}
	else {
		view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, _size.width, _size.height);;
	}
}

+ (void)rotate:(UIView*)view fromAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration {
	if (duration > 0) {
		[UIView beginAnimations:kRotateKey context:nil];
		[UIView setAnimationDuration:duration];
		[view setTransform:CGAffineTransformMakeRotation(angle)];
		[UIView commitAnimations];
	}
	else {
		[view setTransform:CGAffineTransformMakeRotation(angle)];
	}
}

+ (void)rotate:(UIView*)view fromAngle:(CGFloat)angle withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector withUserInfo:(NSDictionary*)userInfo{
	if (duration > 0) {
		[UIView beginAnimations:kRotateKey context:(__bridge void *)(userInfo)];
		[UIView setAnimationDuration:duration];
        [UIView setAnimationDelegate:target];
        [UIView setAnimationDidStopSelector:endSelector];
		[view setTransform:CGAffineTransformMakeRotation(angle)];
		[UIView commitAnimations];
	}
	else {
        [UIView setAnimationDelegate:target];
        [UIView setAnimationDidStopSelector:endSelector];
		[view setTransform:CGAffineTransformMakeRotation(angle)];
	}
}

+ (void)curl:(UIView*)view curlTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration {
	[UIView beginAnimations:kCurlKey context:nil];
	[UIView setAnimationTransition:transition forView:view cache:YES];
	[UIView setAnimationDuration:duration];
	[UIView commitAnimations];
}	

+ (void)view:(UIView*)view animationTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector {
	[UIView beginAnimations:kCurlKey context:nil];
	[UIView setAnimationTransition:transition forView:view cache:YES];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:target];
	[UIView setAnimationDidStopSelector:endSelector];
	[UIView commitAnimations];
}	

+ (void)flip:(UIView*)view flipTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration {
	[UIView beginAnimations:kFlipKey context:nil];
	[UIView setAnimationTransition:transition forView:view cache:YES];
	[UIView setAnimationDuration:duration];
	[UIView commitAnimations];
}

+ (void)flip:(UIView*)view flipTransition:(UIViewAnimationTransition)transition withDuration:(CFTimeInterval)duration withTarget:(id)target endSelector:(SEL)endSelector {
	[UIView beginAnimations:kFlipKey context:nil];
	[UIView setAnimationTransition:transition forView:view cache:YES];
	[UIView setAnimationDelegate:target];
	[UIView setAnimationDidStopSelector:endSelector];
	[UIView setAnimationDuration:duration];
	[UIView commitAnimations];
}

+ (void)flipFromGoingController:(UIViewController*)goingContrller toIncomingController:(UIViewController*)incomingController atView:(UIView*)handlerView withDuration:(CFTimeInterval)duration flipTransition:(UIViewAnimationTransition)transition target:(id)target endSelector:(SEL)endSelector {
	[UIView beginAnimations:kFlipKey context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:transition forView:handlerView cache:YES];
	[UIView setAnimationDelegate:target];
	[UIView setAnimationDidStopSelector:endSelector];
	[incomingController viewWillAppear:YES];
	[goingContrller viewWillDisappear:YES];
	[goingContrller.view removeFromSuperview];
	[handlerView addSubview:incomingController.view];
	[incomingController viewDidAppear:YES];
	[goingContrller viewDidDisappear:YES];
	[UIView commitAnimations];
}

@end
