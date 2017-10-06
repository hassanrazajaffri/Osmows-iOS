//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//


#import "CenterController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import <SOAPEngine64/SOAPEngine.h>

#import <objc/runtime.h>
#import "VisualServiceApiCall.h"

@interface CenterController ()<UITableViewDelegate,UITableViewDataSource,SOAPEngineDelegate,Wsdl2CodeProxyDelegate>
{
    NSMutableArray *list;
    VisualServiceApiCall *serviceRequest;
    NSMutableData       *webPortFolio;
    NSMutableString     *soapResultsPortFolio;
    NSURLConnection     *conn;
    
    //---xml parsing---
    
    NSXMLParser         *xmlParserPortFolio;
    BOOL                elementFoundPortFolio;
    NSMutableURLRequest *req;
    
    NSString            *theXMLPortFolio;
    NSString            *strSoapMsg;

}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation CenterController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    list = nil;
    serviceRequest=[[VisualServiceApiCall alloc] initWithUrl:@"http://64.20.37.90/VTWebServiceTest/VisualService.svc" AndDelegate:self];
    [serviceRequest AuthorizeUser:@"Hassan" :@"123123" :@"testHostName" :@"123123" :@"8QIxBSN6Np7Jx1lzIgoEXQ=="];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Home";
    
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    
  
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


@end
