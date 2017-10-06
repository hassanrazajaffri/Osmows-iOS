//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//


#import "PaymentViewControllar.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import <SOAPEngine64/SOAPEngine.h>

#import <objc/runtime.h>
#import "VisualServiceApiCall.h"

@interface PaymentViewControllar ()<UITableViewDelegate,UITableViewDataSource,SOAPEngineDelegate,Wsdl2CodeProxyDelegate>
{
    NSMutableArray *list;
    VisualServiceApiCall *serviceRequest;


}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation PaymentViewControllar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    list = nil;
    serviceRequest=[[VisualServiceApiCall alloc] initWithUrl:@"http://64.20.37.90/VTWebServiceTest/VisualService.svc" AndDelegate:self];
   // [serviceRequest AuthorizeUser:@"Hassan" :@"123123" :@"testHostName" :@"123123" :@"8QIxBSN6Np7Jx1lzIgoEXQ=="];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    bar.logo.hidden=YES;
    bar.titleLbl.hidden=NO;
     bar.titleLbl.text=@"Payment";
    self.navigationController.navigationBarHidden=YES;
    
   
    
    
  
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
#pragma mark - Action Cart
-(void)actionCart
{
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil]];
    centerNav.navigationBarHidden=YES;
    [self.mm_drawerController setCenterViewController:centerNav withCloseAnimation:NO completion:nil];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
    
}

- (IBAction)CreditCardBtnPressed:(id)sender {
    [_creditCardBtn setSelected:YES];
    [_debitCardBtn setSelected:NO];
    
}
- (IBAction)DebitCardBtnPressed:(id)sender {
    [_creditCardBtn setSelected:NO];
    [_debitCardBtn setSelected:YES];
}
- (IBAction)RememberMeBtnPressed:(id)sender {
    [_rememberMeCheckBox setSelected:!_rememberMeCheckBox.selected];
}

- (IBAction)AuthorizedPressed:(id)sender {
}
@end
