//
//  BaseViewController.h
//  GMG App
//
//  Created by Mosib on 4/19/15.
//  Copyright (c) 2015 Advansoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"
#import "HelpViewController.h"


@interface BaseViewController : UIViewController<CAAnimationDelegate>{
    NavigationBar *bar;
    UISplitViewController *splitViewController;
}



-(void) showNavigationBar;
-(void) hideNavigationBar;

-(void) disableBackButton;
-(void) enableBackButton;

-(BOOL) hasRight:(int) activity;
-(void) connectionLostActivity;

-(void) enableCart;
-(void) disableCart;
-(void) incrementCartCount;
-(void) setCartCount:(int) count;
-(void) decrementCartCount:(int) pDecrementValue;
-(void) enableHomeButton;
-(void) disableHomeButton;
-(IBAction)changeLanguage:(id)sender;
-(void) showHelpViewController;
@end
