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
#import "CategoriesLisrViewCustomCell.h"
#import <objc/runtime.h>
#import "DishesViewController.h"
#import "SubCategoriesRequest.h"
@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *list;
     NSMutableArray *menuItems;
 
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation MenuViewController
@synthesize subCatID,isAllMenu;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    list = nil;
    
    NSArray *array = [self.navigationController viewControllers];
    if ([array count]>1) {
        bar.backBtn.hidden=NO;
        bar.menuBtn.hidden=YES;
    }
    else{
        bar.backBtn.hidden=YES;
        bar.menuBtn.hidden=NO;
    }
    
    [self refreshData];
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
    
    
    [self.navigationController.view showActivityViewWithLabel:@"Loading"];
   
    if (isAllMenu) {
        HTTPRequest *request = [HTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"category/navcategories"]] requestDictonary:nil delegate:self didFinished:@selector(AllMenuCategoriesrequestRecieved:) didFailed:@selector(requestFailedWithError:) userInfo:nil Method:@"GET"] ;
        [request startAsynchronous];
    }
    else{
    HTTPRequest *request = [HTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"category/sub?category_id=%@",self.subCatID]] requestDictonary:nil delegate:self didFinished:@selector(SubCategoriesrequestRecieved:) didFailed:@selector(requestFailedWithError:) userInfo:nil Method:@"GET"] ;
    [request startAsynchronous];
    }
//    NSMutableDictionary *param=[[NSMutableDictionary alloc] init];
//    [param setObject:@"2" forKey:@"payment_id"];
//    NSMutableArray *ordersArray=[[NSMutableArray alloc] init];
//    NSMutableDictionary *order=[[NSMutableDictionary alloc] init];
//    [order setObject:@"5" forKey:@"dish_id"];
//    [order setObject:@"2" forKey:@"quantity"];
//    [order setObject:@"High" forKey:@"spice_level"];
//    [ordersArray addObject:order];
//    [param setObject:ordersArray forKey:@"order_detail"];
//    HTTPRequest *request = [HTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"order/place"]] requestDictonary:param delegate:self didFinished:@selector(requestSuccefullDone:) didFailed:@selector(requestFailedWithError:) userInfo:nil] ;
//    [request startAsynchronous];
    
//    SubCategoriesRequest *request=[[SubCategoriesRequest alloc] init];
//    request.categoryID=self.subCatID;
//    
//    [request makeRequest:self finishSel:@selector(SubCategoriesrequestRecieved:withResponse:) failSel:@selector(SubCategoriesrequestFailed:withResponse:)];

    

  
}
//- (void) requestSuccefullDone:(HTTPRequest*)request {
//    NSError *error = nil;
//    [self.navigationController.view hideActivityViewWithAfterDelay:0];
//
//    NSDictionary *jsonResponse = [request reponseDictonary];
//}

- (void)AllMenuCategoriesrequestRecieved:(HTTPRequest*)request {
    //   NSError *error = nil;
    [self.navigationController.view hideActivityViewWithAfterDelay:0];
    
    NSDictionary *jsonResponse = [request reponseDictonary];
    if ([[jsonResponse objectForKey:@"status"] intValue]==1) {
        
        NSMutableArray *arrayCategories=[[NSMutableArray alloc] initWithArray:[jsonResponse objectForKey:@"data"]];
        
        
        if(arrayCategories.count>0)
        {
            [[DataManager sharedInstance] deleteAll:nil withTable:@"ALLCategories"];
        }
        
        for (int i = 0; i < [arrayCategories count]; i++) {
            NSDictionary *dictionary = [arrayCategories objectAtIndex:i];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"ALLCategories" inManagedObjectContext:[[DataManager sharedInstance] managedObjectContext]];
            
            Categories *categories = [[Categories alloc] initWithEntity:entity insertIntoManagedObjectContext:[[DataManager sharedInstance] managedObjectContext]];
            
            
            [categories setParaentID:[NSNumber numberWithInt:[[dictionary objectForKeyNotNull:@"parent_category_id"] intValue]]];
            [categories setCategoryID:[NSNumber numberWithInt:[[dictionary objectForKeyNotNull:@"category_id"] intValue]]];
            [categories setCategoryNameEN:[dictionary objectForKeyNotNull:@"title"]];
            [categories setCategoryThumbImage:[dictionary objectForKeyNotNull:@"image"]];
            [categories setSortID:[NSNumber numberWithInt:[[dictionary objectForKeyNotNull:@"category_id"] intValue]]];
            
        }
        
        [[DataManager sharedInstance] save];
        menuItems = [[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getAllMenuCategory]];
       // if ([menuItems count]>0) {
            [_categoriesTableList reloadData];
       // }
        
    }
    else
    {
        menuItems = [[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getAllMenuCategory]];
        // if ([menuItems count]>0) {
        [_categoriesTableList reloadData];
        // }
  
    }
}


- (void)SubCategoriesrequestRecieved:(HTTPRequest*)request {
 //   NSError *error = nil;
    [self.navigationController.view hideActivityViewWithAfterDelay:0];

    NSDictionary *jsonResponse = [request reponseDictonary];
    if ([[jsonResponse objectForKey:@"status"] intValue]==1) {
        
        NSMutableArray *arrayCategories=[[NSMutableArray alloc] initWithArray:[jsonResponse objectForKey:@"data"]];
        
        
          if(arrayCategories.count>0)
        {
        [[DataManager sharedInstance] deleteAll:nil withTable:@"Categories"];
         }
        
        for (int i = 0; i < [arrayCategories count]; i++) {
            NSDictionary *dictionary = [arrayCategories objectAtIndex:i];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories" inManagedObjectContext:[[DataManager sharedInstance] managedObjectContext]];
            
            Categories *categories = [[Categories alloc] initWithEntity:entity insertIntoManagedObjectContext:[[DataManager sharedInstance] managedObjectContext]];
            
            
            [categories setParaentID:[NSNumber numberWithInt:[[dictionary objectForKeyNotNull:@"parent_category_id"] intValue]]];
            [categories setCategoryID:[NSNumber numberWithInt:[[dictionary objectForKeyNotNull:@"category_id"] intValue]]];
            [categories setCategoryNameEN:[dictionary objectForKeyNotNull:@"title"]];
            [categories setCategoryThumbImage:[dictionary objectForKeyNotNull:@"image"]];
            [categories setSortID:[NSNumber numberWithInt:[[dictionary objectForKeyNotNull:@"category_id"] intValue]]];
            
        }
        
        [[DataManager sharedInstance] save];
        [self refreshData];
    }
}

- (void) requestFailedWithError:(HTTPRequest *)request {
    [self.navigationController.view hideActivityViewWithAfterDelay:0];

}
- (void)refreshData {
    
    if (isAllMenu) {
          menuItems = [[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getAllMenuCategory]];
    }
    else{
         menuItems = [[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getCategoryWithID:subCatID]];
    }
    
        if ([menuItems count]>0) {
            [_categoriesTableList reloadData];
        }
        
    
}

- (void)SubCategoriesrequestFailed:(BaseRequest *)request withResponse:(id)response {
    [self.navigationController.view hideActivityViewWithAfterDelay:0];
    if(response!=nil)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
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
     Categories *categories =( Categories *)[menuItems objectAtIndex:indexPath.row];
    cell.categoryTitle.text=categories.categoryNameEN;
   // cell.categoryImage.image=[UIImage imageNamed:[item objectForKey:@"Image"]];
   [cell.categoryImage sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",categories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"missing_menu_main_full.png"] options:SDWebImageContinueInBackground];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 195;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  DishesViewController *dishes=(DishesViewController *) [[DishesViewController alloc] initWithNibName:@"DishesViewController" bundle:nil];
    dishes.menuItems=[[NSMutableArray alloc] initWithArray:menuItems];
    dishes.seleted=(int)indexPath.row;
     [self.navigationController pushViewController:dishes animated:YES];
//    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:[[DishesViewController alloc] initWithNibName:@"DishesViewController" bundle:nil]];
//    centerNav.navigationBarHidden=YES;
//    [self.mm_drawerController setCenterViewController:centerNav withCloseAnimation:NO completion:nil];
//    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
//        
//    }];
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
    //    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil]];
    //    centerNav.navigationBarHidden=YES;
    //    [self.mm_drawerController setCenterViewController:centerNav withCloseAnimation:NO completion:nil];
    //    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
    //
    //    }];
    [self.navigationController pushViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil] animated:YES];
    
}
@end
