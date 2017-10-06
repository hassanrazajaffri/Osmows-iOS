//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//


#import "HomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "CateringViewController.h"
#import "HomeMenuItemCollectionViewCell.h"
#import <objc/runtime.h>


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *listMenu;
   

}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableV;

@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
   // listMenu = nil;
   
 //   [serviceRequest AuthorizeUser:@"Hassan" :@"123123" :@"testHostName" :@"123123" :@"8QIxBSN6Np7Jx1lzIgoEXQ=="];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    bar.backBtn.hidden=YES;
    bar.menuBtn.hidden=NO;
    
    bar.titleLbl.hidden=YES;
    [self CreateMenu];
    self.navigationController.navigationBarHidden=YES;
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeMenuItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeMenuItemCollectionViewCell"];
  
    
    [self.view bringSubviewToFront:_collectionView];
  
}
-(void)CreateMenu{
    
    NSDictionary *Salads=[[NSDictionary alloc] initWithObjectsAndKeys:@"Salads & Apps",@"Name",@"hs_salads.png",@"Image",@"1",@"Index",@"1",@"catID",nil];
    NSDictionary *Sandwiches=[[NSDictionary alloc] initWithObjectsAndKeys:@"Sandwiches & Wrapes",@"Name", @"hs_sandwiches.png",@"Image",@"2",@"Index",@"2",@"catID",nil];
    NSDictionary *Main=[[NSDictionary alloc] initWithObjectsAndKeys:@"Main Dishes",@"Name", @"hs_dishes.png",@"Image",@"10",@"Index",@"10",@"catID",nil];
    NSDictionary *Specialty=[[NSDictionary alloc] initWithObjectsAndKeys:@"Specialty Dishes",@"Name", @"hs_specialty.png",@"Image",@"3",@"Index",@"3",@"catID",nil];
    
    NSDictionary *dailySpecial=[[NSDictionary alloc] initWithObjectsAndKeys:@"Daily Special",@"Name", @"hs_specials.png",@"Image",@"9",@"Index",@"9",@"catID",nil];

    NSDictionary *beverages=[[NSDictionary alloc] initWithObjectsAndKeys:@"Beverages",@"Name", @"hs_beverages.png",@"Image",@"5",@"Index",@"5",@"catID",nil];
    NSDictionary *catering=[[NSDictionary alloc] initWithObjectsAndKeys:@"Catering",@"Name", @"hs_catering.png",@"Image",@"6",@"Index",@"6",@"catID",nil];
   
    NSDictionary *feedBack=[[NSDictionary alloc] initWithObjectsAndKeys:@"Feedback",@"Name", @"hs_feedback.png",@"Image",@"8",@"Index",@"8",@"catID",nil];
    

    
    listMenu = [[NSMutableArray alloc] initWithObjects:Salads,Sandwiches,Main,Specialty,dailySpecial,beverages,catering,feedBack, nil];

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
//    
    
    [self.navigationController pushViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil] animated:YES];

    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [listMenu count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeMenuItemCollectionViewCell *cell = (HomeMenuItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMenuItemCollectionViewCell" forIndexPath:indexPath];
    
    // configuring cell
    NSDictionary *menuItem=[listMenu objectAtIndex:indexPath.item];
    cell.titleLbl.text=[menuItem objectForKey:@"Name"];
    cell.imageIcon.image=[UIImage imageNamed:[menuItem objectForKey:@"Image"]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([[[listMenu objectAtIndex:indexPath.item] objectForKey:@"catID"] intValue]==6)
    {
        CateringViewController *catering = [[CateringViewController alloc] initWithNibName:@"CateringViewController" bundle:nil];
      
        [self.navigationController pushViewController:catering animated:YES];
 
    }
   else if([[[listMenu objectAtIndex:indexPath.item] objectForKey:@"catID"] intValue]==8)
    {
        FeedbackViewController *catering = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
        
        [self.navigationController pushViewController:catering animated:YES];
        
    }
    else
    {
        MenuViewController *subCategories = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        subCategories.isAllMenu=NO;
        subCategories.subCatID=[[listMenu objectAtIndex:indexPath.item] objectForKey:@"catID"];
        [self.navigationController pushViewController:subCategories animated:YES];
   
    }
    
   //    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil]];
//    centerNav.navigationBarHidden=YES;
//    [self.mm_drawerController setCenterViewController:centerNav withCloseAnimation:NO completion:nil];
//    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
//        
//    }];
}
//Note: Above two "numberOfItemsInSection" & "cellForItemAtIndexPath" methods are required.

// this method overrides the changes you have made to inc or dec the size of cell using storyboard.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:   (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(130, 102);
}



@end
