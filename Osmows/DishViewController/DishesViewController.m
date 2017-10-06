//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//


#import "MenuViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import <SOAPEngine64/SOAPEngine.h>
#import "CategoriesLisrViewCustomCell.h"
#import <objc/runtime.h>
#import "VisualServiceApiCall.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource,SOAPEngineDelegate,Wsdl2CodeProxyDelegate>
{
    NSMutableArray *list;
    VisualServiceApiCall *serviceRequest;
     NSMutableArray *menuItems;
 
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation MenuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    list = nil;
    serviceRequest=[[VisualServiceApiCall alloc] initWithUrl:@"http://64.20.37.90/VTWebServiceTest/VisualService.svc" AndDelegate:self];
   // [serviceRequest AuthorizeUser:@"Hassan" :@"123123" :@"testHostName" :@"123123" :@"8QIxBSN6Np7Jx1lzIgoEXQ=="];
    
    NSDictionary *home=[[NSDictionary alloc] initWithObjectsAndKeys:@"Sandwitches/Wrapes",@"Name", @"image1.png",@"Image",@"1",@"Index",@"20",@"Price",nil];
    NSDictionary *login=[[NSDictionary alloc] initWithObjectsAndKeys:@"Appitizer",@"Name", @"image2.png",@"Image",@"2",@"Index",@"10",@"Price",nil];
    NSDictionary *menu=[[NSDictionary alloc] initWithObjectsAndKeys:@"Salads",@"Name", @"image2.png",@"Image",@"3",@"Index",@"14",@"Price",nil];
  
    
    menuItems = [[NSMutableArray alloc] initWithObjects:home,login,menu,home,login,menu,home,login,menu, nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    bar.logo.hidden=YES;
    bar.titleLbl.hidden=NO;
     bar.titleLbl.text=@"Menu";
    self.navigationController.navigationBarHidden=YES;
    
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CategoriesLisrViewCustomCell";
    
    CategoriesLisrViewCustomCell *cell = (CategoriesLisrViewCustomCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [CategoriesLisrViewCustomCell createCell];
    }
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.categoryTitle.font = [UIFont systemFontOfSize:16.0f];
    //cell.backgroundColor = [UIColor clearColor];
    //cell.cartItemName.textColor = [HexColor colorWithHexString:@"DDE0E0"];
    NSDictionary *item=[menuItems objectAtIndex:indexPath.row];
    cell.categoryTitle.text=[item objectForKey:@"Name"];
    cell.categoryImage.image=[UIImage imageNamed:[item objectForKey:@"Image"]];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 195;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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

@end
