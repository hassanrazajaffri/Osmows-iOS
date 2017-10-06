//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//


#import "DishesViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import <SOAPEngine64/SOAPEngine.h>
#import "CategoriesLisrViewCustomCell.h"
#import <objc/runtime.h>
#import "VisualServiceApiCall.h"
#import "DishListViewCustomCell.h"
#import "CategoriesMenuScrollView.h"
@interface DishesViewController ()<UITableViewDelegate,UITableViewDataSource,SOAPEngineDelegate,Wsdl2CodeProxyDelegate,CategoriesMenuScrollViewDelegate>
{
    NSMutableArray *list;
    VisualServiceApiCall *serviceRequest;
     NSMutableArray *menuItems;
 
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, strong) CategoriesMenuScrollView *menuView;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation DishesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    list = nil;
    serviceRequest=[[VisualServiceApiCall alloc] initWithUrl:@"http://64.20.37.90/VTWebServiceTest/VisualService.svc" AndDelegate:self];
   // [serviceRequest AuthorizeUser:@"Hassan" :@"123123" :@"testHostName" :@"123123" :@"8QIxBSN6Np7Jx1lzIgoEXQ=="];
    
    NSDictionary *home=[[NSDictionary alloc] initWithObjectsAndKeys:@"Sandwitches/Wrapes",@"Name", @"thumb1.png",@"Image",@"1",@"Index",@"20",@"Price",nil];
    NSDictionary *login=[[NSDictionary alloc] initWithObjectsAndKeys:@"Appitizer",@"Name", @"thumb2.png",@"Image",@"2",@"Index",@"10",@"Price",nil];
    NSDictionary *menu=[[NSDictionary alloc] initWithObjectsAndKeys:@"Salads",@"Name", @"thumb3.png",@"Image",@"3",@"Index",@"14",@"Price",nil];
  
    
    menuItems = [[NSMutableArray alloc] initWithObjects:home,login,menu,home,login,menu,home,login,menu, nil];
    _menuView = [[CategoriesMenuScrollView alloc]initWithFrame:CGRectMake(16, 101, self.view.frame.size.width-32, 40)];
    _menuView.backgroundColor = [UIColor clearColor];
    _menuView.delegate = self;
    _menuView.viewbackgroudColor = [UIColor whiteColor];
    _menuView.itemfont = [UIFont systemFontOfSize:14];
    _menuView.itemTitleColor = [UIColor blackColor];
    _menuView.itemIndicatorColor = [UIColor redColor];
    _menuView.scrollView.scrollsToTop = NO;
    [_menuView setItemTitleArray:menuItems];
    [self.view addSubview:_menuView];
    [_menuView setShadowView];

    
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
    
    DishListViewCustomCell *cell = (DishListViewCustomCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [DishListViewCustomCell createCell];
    }
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dishTitle.font = [UIFont systemFontOfSize:16.0f];
    //cell.backgroundColor = [UIColor clearColor];
    //cell.cartItemName.textColor = [HexColor colorWithHexString:@"DDE0E0"];
    NSDictionary *item=[menuItems objectAtIndex:indexPath.row];
    cell.dishTitle.text=[item objectForKey:@"Name"];
    cell.dishImage.image=[UIImage imageNamed:[item objectForKey:@"Image"]];
    cell.priceLbl.text=[NSString stringWithFormat:@"$ %@",[item objectForKey:@"Price"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 107;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


#pragma mark -- YSLScrollMenuView Delegate

- (void)scrollMenuViewSelectedIndex:(NSInteger)index
{
   // [_contentScrollView setContentOffset:CGPointMake(index * _contentScrollView.frame.size.width, 0.) animated:YES];
    
    // item color
    [_menuView setItemTextColor:[UIColor blackColor]
           seletedItemTextColor:[UIColor blackColor]
                   currentIndex:index];
    
    
   
    
   
    
    CGFloat nextItemOffsetX = 1.0f;
    CGFloat currentItemOffsetX = 1.0f;
    
    nextItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * index / (_menuView.itemViewArray.count - 1);
    currentItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * index/ (_menuView.itemViewArray.count - 1);
    
    if (index >= 0) {
        // MenuView Move
        CGFloat indicatorUpdateRatio = 0.0;
        if (YES) {
            
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = (nextItemOffsetX - currentItemOffsetX) * 0.5 + currentItemOffsetX;
            [_menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * 1;
            [_menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:YES toIndex:index];
        } else {
            
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = currentItemOffsetX - (nextItemOffsetX - currentItemOffsetX) * 0.5;
            [_menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio * -1;
            [_menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:YES toIndex:index];
        }
    }

  
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
