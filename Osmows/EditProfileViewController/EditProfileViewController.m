//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//


#import "SignUpViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "VerificationCodeViewController.h"
#import "SignUpRequest.h"
#import <objc/runtime.h>
#import "TextFieldValidator.h"
#import "GMDCircleLoader.h"
#define REGEX_NAME_LIMIT @"^.{1,20}$"
#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"^((\\+)|(00))[0-9]{6,14}$"
@interface SignUpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *list;


}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation SignUpViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    list = nil;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    bar.backBtn.hidden=NO;
    bar.menuBtn.hidden=YES;

    
    [_firstName addRegx:REGEX_NAME_LIMIT withMsg:@"Name charaters limit should be come between 1-20"];
    [_lastName addRegx:REGEX_NAME_LIMIT withMsg:@"Name charaters limit should be come between 1-20"];
    
    [_userName addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    
    [_email addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [_password addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [_password addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    [_confirmPassword addConfirmValidationTo:_password withMsg:@"Confirm password didn't match."];
    
    [_mobileNumber addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
    _mobileNumber.isMandatory=NO;

    
    bar.logo.hidden=YES;
    bar.titleLbl.hidden=NO;
     bar.titleLbl.text=@"Signup";
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
- (IBAction)EditImagePressed:(id)sender {
}
- (IBAction)SignupBtnPressed:(id)sender {
    
    [self.navigationController.view showActivityViewWithLabel:@"Loading"];
    SignUpRequest *request=[[SignUpRequest alloc] init];
    request.user = self.userName.text;
    request.first_name = self.firstName.text;
    request.last_name = self.lastName.text;
    request.password = self.password.text;
    request.phone = self.mobileNumber.text;
    request.email = self.email.text;
    
  //  [Common showAlertWithTitle:nil message:@"Successfully registered, Please Verify to complete registration" delegate:nil withTag:1 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [request makeRequest:self finishSel:@selector(requestRecieved:withResponse:) failSel:@selector(requestFailed:withResponse:)];
    
   
}
- (void)requestRecieved:(BaseRequest *)request withResponse:(id)response {
 [self.navigationController.view hideActivityViewWithAfterDelay:0];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:@"Successfully registered, Please Verify to complete registration"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
         [self.navigationController pushViewController:[[VerificationCodeViewController alloc] initWithNibName:@"VerificationCodeViewController" bundle:nil] animated:YES];
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];

    
   
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

@end
