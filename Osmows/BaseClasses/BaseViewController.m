//
//  BaseViewController.m
//  GMG App
//
//  Created by Mosib on 4/19/15.
//  Copyright (c) 2015 Advansoft. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"
@implementation BaseViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    [self createNavigationBar];
    
}

-(void) createNavigationBar{
    NSString* count = [[NavigationBar sharedInstance] cartValue];
    if (!count || [count isEqual:[NSNull null]] || [count isEqualToString:@"0"]) {
        count = @"";
    }
    
 //   [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"texture.png"]];
    
    bar = [NavigationBar createView];
    bar.labelCartCount.text = [NSString stringWithFormat:@"%@",count];
    if (![[NavigationBar sharedInstance] cartActive]) {
        [self disableCart];
    }
   // bar.backgroundColor=[HexColor colorWithHexString:[[User sharedInstance] barHexCode]];
    [bar.buttonBack addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    [bar.buttonHome addTarget:self action:@selector(actionHome) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionHome)];
    [bar.HomeImage addGestureRecognizer:tapgesture];
    
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
    bar.buttonHome.userInteractionEnabled=NO;
}
-(IBAction)changeLanguage:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_CART_LANG_NOTIFICATION object:nil];
    [bar.buttonHome setTitle:[NSString stringWithFormat:@"%@",AppLanguage==ENGLISH?[[User sharedInstance] restaurantNameEN] : [[User sharedInstance] restaurantNameAR] ] forState:UIControlStateNormal];

}
#pragma mark - Action
-(void) actionBack{
   if([self.navigationController popViewControllerAnimated:YES]==nil)
   {
       [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];

       
   }
}
-(void)actionHome
{
   // [[[UIApplication sharedApplication].keyWindow viewWithTag:100] removeFromSuperview];
    [[[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view] setHidden:YES];
    self.splitViewController.maximumPrimaryColumnWidth=0;
   
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) showNavigationBar{
    bar.hidden = NO;
}

-(void) hideNavigationBar{
    bar.hidden = YES;
}

-(void) enableBackButton{
    bar.buttonBack.hidden = NO;
}

-(void) disableBackButton{
    bar.buttonBack.hidden = YES;
}
-(void) enableHomeButton
{
    bar.buttonHome.userInteractionEnabled=YES;
}
-(void)disableHomeButton
{
    bar.buttonHome.userInteractionEnabled=NO;
}
-(void) enableCart{
    bar.viewCart.hidden = NO;
//    bar.labelCartCount.backgroundColor = [UIColor redColor];
    [[NavigationBar sharedInstance] setCartActive:YES];
}

-(void) disableCart{
    bar.viewCart.hidden = YES;
    bar.labelCartCount.backgroundColor = [UIColor clearColor];
    [[NavigationBar sharedInstance] setCartActive:NO];
}

-(void) setCartCount:(int) count{
    bar.labelCartCount.text = [NSString stringWithFormat:@"%d",count];

}

-(void) incrementCartCount{
    int count = [[[NavigationBar sharedInstance] cartValue] intValue];
    count++;
    [[NavigationBar sharedInstance] setCartValue:[NSString stringWithFormat:@"%d",count]];

    bar.labelCartCount.text = [NSString stringWithFormat:@"%d",count];
}

-(void) decrementCartCount:(int) pDecrementValue{
    int count = [[[NavigationBar sharedInstance] cartValue] intValue];
    count = count - pDecrementValue;
    [[NavigationBar sharedInstance] setCartValue:[NSString stringWithFormat:@"%d",count]];
    bar.labelCartCount.text = [NSString stringWithFormat:@"%d",count];
}

-(void) clearCartCount{
    bar.labelCartCount.backgroundColor = [UIColor clearColor];
    [[NavigationBar sharedInstance] setCartValue:[NSString stringWithFormat:@"0"]];
}

-(void) showHelpViewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HelpViewController *helpController= (HelpViewController*) [storyboard instantiateViewControllerWithIdentifier:@"HelpViewController"];
    
    helpController.modalPresentationStyle = UIModalPresentationFullScreen;
   
    [self presentViewController:helpController animated:NO
                     completion:nil];
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - AlertView Delegate{
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag == 255) {
//        AppDelegate *delegate  = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//        [delegate loadStoryBoard];
//    }
//
//}
@end
