//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//


#import "ForgotPasswordViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import <objc/runtime.h>
#import "ForgotPasswordRequest.h"
#import "GMDCircleLoader.h"
@interface ForgotPasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *list;
   


}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation ForgotPasswordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    list = nil;
     //  [serviceRequest AuthorizeUser:@"Hassan" :@"123123" :@"testHostName" :@"123123" :@"8QIxBSN6Np7Jx1lzIgoEXQ=="];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    
    bar.backBtn.hidden=NO;
    bar.menuBtn.hidden=YES;
    
    bar.logo.hidden=YES;
    bar.titleLbl.hidden=NO;
     bar.titleLbl.text=@"Forgot Password";
    self.navigationController.navigationBarHidden=YES;
    
//    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
//    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    
  
}
-(void)proxyRecievedError:(NSException*)ex InMethod:(NSString*)method
{
    
};
//proxy finished, (id)data is the object of the relevant method service
-(void)proxydidFinishLoadingData:(id)data InMethod:(NSString*)method
{
    
};
                                             
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
#pragma mark - Action
-(void) actionMenu{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)actionCart
{
    //    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil]];
    //    centerNav.navigationBarHidden=YES;
    //    [self.mm_drawerController setCenterViewController:centerNav withCloseAnimation:NO completion:nil];
    //    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
    //
    //    }];
    [self.navigationController pushViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil] animated:YES];
    
}
- (IBAction)SubmitBtnPressed:(id)sender {
    
     if([_userName.text length]==0 || ![self isValidEmail:_userName.text])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil  message:@"Please enter valid email." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            NSLog(@"OK");
            
            //[self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated: YES completion: nil];
        
        
    }
    else
    {
    [self.navigationController.view showActivityViewWithLabel:@"Loading"];
     ForgotPasswordRequest *request=[[ForgotPasswordRequest alloc] init];
    request.email = _userName.text;
    [request makeRequest:self finishSel:@selector(requestRecieved:withResponse:) failSel:@selector(requestFailed:withResponse:)];
    }
   }
- (void)requestRecieved:(BaseRequest *)request withResponse:(id)response {
    [self.navigationController.view hideActivityViewWithAfterDelay:0];
    
    if([[response objectForKey:@"status_code"] intValue]==200)
    {
         // [Common showAlertWithTitle:nil message:[response objectForKey:@"message"] delegate:nil withTag:2 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"A link has been sent via email to rest the password."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self.navigationController popViewControllerAnimated:YES];
            //do something when click button
        }];
        [alert addAction:okAction];
        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [vc presentViewController:alert animated:YES completion:nil];

        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:[response objectForKey:@"message"]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            //do something when click button
        }];
        [alert addAction:okAction];
        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [vc presentViewController:alert animated:YES completion:nil];

       // [Common showAlertWithTitle:nil message:[response objectForKey:@"message"] delegate:nil withTag:2 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    }
    //[self.navigationController popViewControllerAnimated:YES];
}
- (void)requestFailed:(BaseRequest *)request withResponse:(id)response {
    [self.navigationController.view hideActivityViewWithAfterDelay:0];

    if(response!=nil)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:[response objectForKey:@"message"]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            //do something when click button
        }];
        [alert addAction:okAction];
        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [vc presentViewController:alert animated:YES completion:nil];

    }
    }

-(BOOL)isValidEmail:(NSString *)email
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
