//
//  ViewController.m
//  iMenu
//
//  Created by Nadeem Ali on 11/29/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import "CategoriesViewController.h"
#import "HomeCollectionCell.h"
#import "SBJson.h"
#import "GetCategoriesRequest.h"
#import "DishViewController.h"
#import "Categories.h"
#import "AboutUsViewController.h"
#import "TableSelectionViewController.h"
#import "TipsViewController.h";
#define CELL_WIDTH_PRO 260
#define CELL_SPACING 10
#define CELL_WIDTH 190

@interface CategoriesViewController () 
{
    NSMutableArray *arrayCategories,*arrayDish;
    TipsViewController *objtips;
    BOOL isScrolling;
   
}


@end



@implementation CategoriesViewController
@synthesize collectionView,btnlanguage,backgroundImage;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    if ([Common isIPadPro]) {
        objtips=[[TipsViewController alloc] initWithNibName:@"TipsViewController_Pro" bundle:nil];
    }
    else{
      objtips=[[TipsViewController alloc] initWithNibName:@"TipsViewController" bundle:nil];
    }
    isScrolling=NO;
    photocellX = 10.0f;
    UIView *blueHeaderSplitViewSeparatorMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 88)];
    [blueHeaderSplitViewSeparatorMask setBounds:CGRectMake(320, 0, 2, 88)];
    [blueHeaderSplitViewSeparatorMask setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:96.0f/255.0f blue:182.0f/255.0f alpha:1.0f]];
    [self.view.superview addSubview:blueHeaderSplitViewSeparatorMask];
//    if ([Common isIPadPro]) {
//         bar.HomeImage.frame = CGRectMake(683-bar.HomeImage.frame.size.width/2, bar.HomeImage.frame.origin.y, bar.HomeImage.frame.size.width, bar.HomeImage.frame.size.height);
//    }
//    else{
//         bar.HomeImage.frame = CGRectMake(512-bar.HomeImage.frame.size.width/2, bar.HomeImage.frame.origin.y, bar.HomeImage.frame.size.width, bar.HomeImage.frame.size.height);
//    }
    bar.languageBtn.hidden=NO;
    bar.helpBtn.hidden=NO;
    [bar.languageBtn addTarget:self action:@selector(changeLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [bar.helpBtn addTarget:self action:@selector(showHelpViewController:) forControlEvents:UIControlEventTouchUpInside];
    

    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTableSelection)];
    tapgesture.numberOfTapsRequired=3;
    [bar.HomeImage addGestureRecognizer:tapgesture];

    // Do any additional setup after loading the view, typically from a nib.
    NSString *name;
    if ([Common isIPadPro]) {
        name = @"HomeCollectionCell_Pro";
    }
    else{
        name = @"HomeCollectionCell";
    }
    
    
    if(AppLanguage==ENGLISH)
    {
        [_aboutUsBtn setTitle:[NSString stringWithFormat:@"About %@",[User sharedInstance].restaurantNameEN] forState:UIControlStateNormal];
    }
    else{
       [_aboutUsBtn setTitle:[NSString stringWithFormat:@"About %@",[User sharedInstance].restaurantNameAR] forState:UIControlStateNormal];
    }
    
    
    [collectionView registerNib:[UINib nibWithNibName:name bundle:nil] forCellWithReuseIdentifier:@"Cell"];
//    collectionView.backgroundColor = [UIColor]
    arrayCategories = [[NSMutableArray alloc] init];
    arrayDish= [[NSMutableArray alloc] init];
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                       
                       NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       //Get Image From URL
                      
                       NSString *url =[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage];
                       NSString *filename = [[url lastPathComponent] stringByDeletingPathExtension];
                       
                       UIImage * imageFromWeb = [Common loadImage:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
                       
                       if (!imageFromWeb) {
                           
                           UIImage * imageFromURL = [Common getImageFromURL:[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage]];
                           [Common saveImage:imageFromURL withFileName:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];

                       }
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           
                           if (imageFromWeb) {
                               [backgroundImage setImage:imageFromWeb];
                               [Common setBlurImageFullSceen:backgroundImage];
                           }
                           else{
                                UIImage * imageFromURL = [Common getImageFromURL:[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage]];
                               [Common saveImage:imageFromURL withFileName:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
                               
                               [backgroundImage sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"background.png"] options: SDWebImageHighPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   [Common setBlurImageFullSceen:backgroundImage];
                               }];
                               
                           }
                       });
                   });
    
    
    
    
//    
//    
//    dispatch_async(
//                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                       
//                       NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//                       
//                       //Get Image From URL
//                       
//                       NSString *url =[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage];
//                       NSString *filename = [[url lastPathComponent] stringByDeletingPathExtension];
//                       
//                       UIImage *background = [UIImage imageWithData:[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename]] objectForKey:@"image"]];
//                       
//                       
//                       //   UIImage * imageFromWeb = [Common loadImage:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
//                       
//                       if (!background) {
//                           
//                           UIImage * imageFromURL = [Common getImageFromURL:[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage]];
//                           
//                           NSData* imageData = UIImagePNGRepresentation(imageFromURL);
//                           
//                           NSDictionary *data=[[NSDictionary alloc] initWithObjectsAndKeys:imageData,@"image", nil];
//                           [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename]];
//                           //  [Common saveImage:imageFromURL withFileName:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
//                           
//                       }
//                       dispatch_sync(dispatch_get_main_queue(), ^{
//                           
//                           if (background) {
//                               [backgroundImage setImage:background];
//                               [Common setBlurImageFullSceen:backgroundImage];
//                           }
//                           else{
//                               UIImage * imageFromURL = [Common getImageFromURL:[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage]];
//                               NSData* imageData = UIImagePNGRepresentation(imageFromURL);
//                               
//                               //    [Common saveImage:imageFromURL withFileName:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
//                               [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filename]];
//                               
//                               [backgroundImage sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantBackgroundImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"background.png"] options: SDWebImageHighPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                   [Common setBlurImageFullSceen:backgroundImage];
//                               }];
//                               
//                           }
//                       });
//                   });
//    
//
//    
//    
    
    [Common showLoader];
    GetCategoriesRequest *request=[[GetCategoriesRequest alloc] init];
    [request makeRequest:self finishSel:@selector(requestRecieved:withResponse:) failSel:@selector(requestFailed:withResponse:)];
    arrayCategories=[[DataManager sharedInstance] getAllCategories];
   /// AppLanguage = ENGLISH;
    
    if([arrayCategories count]>4)
    {
        _nextDishBtn.hidden=NO;
        _previousDishBtn.hidden=NO;
         isScrolling=YES;
    }
    else{
        _nextDishBtn.hidden=YES;
        _previousDishBtn.hidden=YES;
          isScrolling=NO;
    }
    _previousDishBtn.hidden=YES;
    
    [self.view bringSubviewToFront:collectionView];
    [self enableHomeButton];
    if(AppLanguage==ENGLISH)
    {
        
        [bar.languageBtn setTitle:@"العربية"  forState:UIControlStateNormal];
    }
    else{
         [bar.languageBtn setTitle:@"English"  forState:UIControlStateNormal];
    }
    COLLECTIONVIEW_WIDTH=collectionView.frame.size.width;
}
-(void)actionTableSelection
{
     [self animatePopUpShow];
   // [Common showGuestSelection];
}
- (IBAction)okButtonPressed:(id)sender {
    
    LoginRequest *request=[[LoginRequest alloc] init];
    request.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"WaiterName"];
    request.password = myPopUP.passwordTextField.text;
    [Common showLoader];
    [request makeRequest:self finishSel:@selector(requestRecieved:withResponse:) failSel:@selector(requestFailed:withResponse:)];
    
    
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    self.view.hidden=NO;
    bar.languageBtn.hidden=NO;
    bar.helpBtn.hidden=NO;
    bar.hidden=NO;
   // [[[UIApplication sharedApplication].keyWindow viewWithTag:100] removeFromSuperview];

   
}
- (IBAction)cancelButtonPressed:(id)sender {
    [myPopUP removeFromSuperview];
    myPopUP=nil;
}
-(void)blurBackgroundImage:(UIImage*)image
{
   // backgroundImage.image=[image blurredImageWithRadius:3.5 iterations:2 tintColor:nil];
    
//    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0 , 0, 824, 678)];
//    [blurView setDynamic:NO];
//    [blurView setIterations:10];
//    [blurView setBlurRadius:5.0];
//    [backgroundImage addSubview:blurView];
////
    // create effect
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    
//    // add effect to an effect view
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effectView.frame = self.view.frame;
//    
//    // add the effect view to the image view
//    [backgroundImage addSubview:effectView];
}

-(IBAction)changeLanguage:(id)sender
{
    if(AppLanguage==ENGLISH)
    {
        AppLanguage=ARABIC;
         [AppSettings setLanguage:ARABIC];
       
        [bar.languageBtn setTitle:@"English"  forState:UIControlStateNormal];
       
    }
    else{
        AppLanguage=ENGLISH;
         [AppSettings setLanguage:ENGLISH];
        [bar.languageBtn setTitle:@"العربية"  forState:UIControlStateNormal];
    }
    
//    [UIView performWithoutAnimation:^{
//         [collectionView reloadData];
//    }];
     [collectionView reloadData];
//    [self.collectionView performBatchUpdates:^{
//         [collectionView reloadData];
//    } completion:^(BOOL finished) {}];
    [super changeLanguage:sender];
        
}
- (IBAction)previousDishBtnPressed:(id)sender {
    
    

    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
     _previousDishBtn.hidden=YES;
}

- (IBAction)nextDishBtnPressed:(id)sender {
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:[arrayCategories count]-1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    _nextDishBtn.hidden=YES;
}

- (IBAction)showHelpViewController:(id)sender {
    
   // [self showHelpViewController];
 [self showTipsScreen];
}

-(void)updateCollectionViewandButton
{
    if(AppLanguage==ENGLISH)
    {
        AppLanguage=ENGLISH;
        [AppSettings setLanguage:ENGLISH];
        [btnlanguage setTitle:@"العربية"  forState:UIControlStateNormal];
       
    }
    else{
        AppLanguage=ARABIC;
        [AppSettings setLanguage:ARABIC];
        [btnlanguage setTitle:@"English"  forState:UIControlStateNormal];
        
    }
    
    [collectionView reloadData];
//    [collectionView layoutIfNeeded];
    
//    [self.collectionView performBatchUpdates:^{
//         [collectionView reloadData];
//    } completion:^(BOOL finished) {}];
//    [super changeLanguage:nil];
}
- (void)requestRecieved:(BaseRequest *)request withResponse:(id)response {
   // [Common hideLoader];
    if ( [[response objectForKeyNotNull:@"ResponseID"] integerValue]==2) {
        [myPopUP removeFromSuperview];
        myPopUP=nil;
        
       // [self closeTable];
        [[CartItems sharedInstance] setStrOrderNotes:NULL];
        [Common showGuestSelection];
    }
    else{
        [Common hideLoader];
        arrayCategories =[[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getAllCategories]];
    //arrayDish = [response objectForKeyNotNull:@"Dishes"];
        if([arrayCategories count]>4)
        {
            _nextDishBtn.hidden=NO;
            _previousDishBtn.hidden=NO;
            isScrolling=YES;
            
        }
        else{
            _nextDishBtn.hidden=YES;
            _previousDishBtn.hidden=YES;
            isScrolling=NO;
        }
    [collectionView reloadData];
    
    }
    
   
}

- (void)requestFailed:(BaseRequest *)request withResponse:(id)response {
    
    [Common showAlertWithTitle:nil message:response delegate:nil withTag:2 cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [Common hideLoader];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [arrayCategories count];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([Common isIPadPro]) {
        return CGSizeMake(275, 450);
    }
        return CGSizeMake(190, 311);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    HomeCollectionCell *photoCell = (HomeCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    

    if (photoCell == nil) {
        NSString *name;
        if ([Common isIPadPro]) {
            name = @"HomeCollectionCell_Pro";
        }
        else{
            name = @"HomeCollectionCell";
        }
        photoCell = [Common loadNibName:name owner:self options:nil];;
    }
    Categories *objCategories =(Categories*)[arrayCategories objectAtIndex:indexPath.row];
    photoCell.lblCategoryName.text = AppLanguage == ENGLISH? objCategories.categoryNameEN : objCategories.categoryNameAR;
    
    
//<<<<<<< HEAD
//    NSLog(@"%@",[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] );
//    
//    
//    dispatch_async(
//                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                    
//                      
//                       NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//                       
//                       //Get Image From URL
//                       
//                       NSString *url =[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                       NSString *filename = [[url lastPathComponent] stringByDeletingPathExtension];
//                       
//                       UIImage * imageFromWeb = [Common loadImage:[NSString stringWithFormat:@"%@%@%@%d%@",[User sharedInstance].userName,[User sharedInstance].resturantID,objCategories.categoryID,indexPath.item,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
//                      
//                       dispatch_sync(dispatch_get_main_queue(), ^{
//                 
//                           if (imageFromWeb) {
//                               [photoCell.imageCategory setImage:imageFromWeb];
//                           }
//                           else{
//                              
//                               
//                               [photoCell.imageCategory sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil options:SDWebImageContinueInBackground];
//                               
//                           }
//                       });
//                       
//                       
//                       
//                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                           
//                           if (!imageFromWeb) {
//                               UIImage * imageFromURL = [Common getImageFromURL:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                               [Common saveImage:imageFromURL withFileName:[NSString stringWithFormat:@"%@%@%@%d%@",[User sharedInstance].userName,[User sharedInstance].resturantID,objCategories.categoryID,indexPath.item,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
//                           }
//                       });
//                       
//                   });
//
//    
//    
//=======
    
     // [photoCell.imageCategory sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil options:SDWebImageContinueInBackground];
    
    
     [photoCell.imageCategory sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil options:SDWebImageContinueInBackground];
    
//    dispatch_async(
//                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                    
//                      
//                       NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//                       
//                       //Get Image From URL
//                       
//                       NSString *url =[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                       NSString *filename = [[url lastPathComponent] stringByDeletingPathExtension];
//                       
//                       UIImage * imageFromWeb = [Common loadImage:[NSString stringWithFormat:@"%@%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,objCategories.categoryID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
//                      
//                       dispatch_sync(dispatch_get_main_queue(), ^{
//                 
//                           if (imageFromWeb) {
//                               [photoCell.imageCategory setImage:imageFromWeb];
//                           }
//                           else{
//                              
//                               
//                               [photoCell.imageCategory sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil options:SDWebImageContinueInBackground];
//                               
//                           }
//                       });
//                       
//                       
//                       
//                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                           
//                           if (!imageFromWeb) {
//                               UIImage * imageFromURL = [Common getImageFromURL:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],objCategories.categoryThumbImage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                               [Common saveImage:imageFromURL withFileName:[NSString stringWithFormat:@"%@%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,objCategories.categoryID,filename] ofType:@"png" inDirectory:documentsDirectoryPath];
//                           }
//                       });
//                       
//                   });
//
//    
//    
//>>>>>>> 39987c5f9669c9f38ff98d8effabb87018a31675
    
   
    
    
    
    
    
    
    
    
    if ([Common isIPadPro]) {
//        photoCell.frame = CGRectMake(photoCell.frame.origin.x, photoCell.frame.origin.y, [Common iPadProScalableWidth:photoCell.frame.size.width] , [Common iPadProScalableHeight:photoCell.frame.size.height]);


//        photocellX = photocellX +  [Common iPadProScalableWidth:photoCell.frame.size.width] + [Common iPadProScalableWidth:10.0];
    }

    return photoCell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float scrollViewWidth = scrollView.frame.size.width;
float scrollContentSizeWidth  = scrollView.contentSize.width;
float scrollOffset = scrollView.contentOffset.x;
if(isScrolling){
    if (scrollOffset == 0)
    {
        // then we are at the top
        _previousDishBtn.hidden=YES;
        _nextDishBtn.hidden=NO;
    }
    else if (scrollOffset + scrollViewWidth +20 >= scrollContentSizeWidth)
    {
        // then we are at the end
        _previousDishBtn.hidden=NO;
        _nextDishBtn.hidden=YES;
        
    }
    else{
        _previousDishBtn.hidden=NO;
        _nextDishBtn.hidden=NO;
        
    }
}

}
-(void)scrollViewDidScroll: (UICollectionView*)scrollView
{
    float scrollViewWidth = scrollView.frame.size.width;
    float scrollContentSizeWidth  = scrollView.contentSize.width;
    float scrollOffset = scrollView.contentOffset.x;
    if(isScrolling){
        if (scrollOffset <= 10)
        {
            // then we are at the top
            _previousDishBtn.hidden=YES;
            _nextDishBtn.hidden=NO;
        }
        else if (scrollOffset + scrollViewWidth+20 >= scrollContentSizeWidth)
        {
            // then we are at the end
            _previousDishBtn.hidden=NO;
            _nextDishBtn.hidden=YES;
            
        }
        else{
            _previousDishBtn.hidden=NO;
            _nextDishBtn.hidden=NO;
            
        }
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    DishViewController *dishView= (DishViewController*) [storyboard instantiateViewControllerWithIdentifier:[Common isIPadPro]?@"DishViewController_Pro":@"DishViewController"];
   Categories *objcategory =(Categories*)[arrayCategories objectAtIndex:indexPath.row];
    dishView.strTitle = AppLanguage == ENGLISH? objcategory.categoryNameEN : objcategory.categoryNameAR;
    
    
    dishView.strCatID = objcategory.categoryID.stringValue;
    
    
//    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
////    [delegate loadDishViewController:dishView];
//    
//    UISplitViewController *splitViewController2 =
//    [[UIStoryboard storyboardWithName:@"Main"
//                               bundle:NULL] instantiateViewControllerWithIdentifier:@"SplitViewController"];
//    
//    
//    UINavigationController *navigationController = [splitViewController2.viewControllers lastObject];
   // self.view.hidden=YES;
   // [[[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view] setHidden:NO];
    MasterViewController *master =(MasterViewController *)[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0];
    
    CATransition *animation2 = [CATransition animation];
    [animation2 setDuration:0.75];
    animation2.delegate = self;
    [animation2 setType:kCATransitionPush];
    [animation2 setSubtype:kCATransitionFromRight];
    [animation2 setValue:@"Slave" forKey:@"showMasterView"];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[self.navigationController.view layer] addAnimation:animation2 forKey:@"showSlaveViewController"];
    
    
    
    
//   [[[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view] setHidden:NO];
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.50];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromLeft];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//     animation.delegate = self;
//    [animation setValue:@"Master" forKey:@"showMasterView"];
//    [[[master view]  layer] addAnimation:animation forKey:@"showMasterViewController"];
    self.splitViewController.maximumPrimaryColumnWidth=0;
    
    [self.navigationController pushViewController:dishView animated:NO];

   

    
//    [[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view].alpha=0;
//    [UIView transitionWithView:[[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view]
//                      duration:3.75
//                       options:UIViewAnimationOptionTransitionFlipFromRight
//                    animations:^{
//                        [[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view].alpha=1;
//                    }
//                    completion:nil];
   
   //[self.navigationController pushViewController:dishView animated:YES];
    
}
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSString* value = [theAnimation valueForKey:@"showMasterView"];
    if ([value isEqualToString:@"Master"])
    {
        //... Your code here ...
          [[[[[[self.splitViewController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0] view] setHidden:NO];
    }
    

    //do what you need to do when animation ends...
}
- (void) initPopUpView {
    
   
    if (!myPopUP) {
        myPopUP=[[[NSBundle mainBundle] loadNibNamed:@"PopUpView" owner:self options:nil] lastObject];
        //PopUpView *myPopUP=[[PopUpView alloc]
    }
    
    myPopUP.userNameTextField.delegate=self;
    //myPopUP.userNameTextField.text= @"master.admin";
    myPopUP.passwordTextField.text=@"";
    //  @"123123";;
    myPopUP.userNameTextField.enabled=NO;
    myPopUP.passwordTextField.delegate=self;
    [myPopUP.passwordTextField becomeFirstResponder];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    myPopUP.center=CGPointMake(screenWidth/2, screenHeight/2-myPopUP.frame.size.height);
    [myPopUP.okBtn addTarget:self
                      action:@selector(okButtonPressed:)
            forControlEvents:UIControlEventTouchUpInside];
    [myPopUP.cancelBtn addTarget:self
                          action:@selector(cancelButtonPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:myPopUP];
    
    
    //   / [self.view.superview addSubview:_popUpView];
}
- (void) animatePopUpShow {
    
    [self initPopUpView];
}
#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
   
    if ([arrayCategories count] <5) {
        NSInteger viewWidth = COLLECTIONVIEW_WIDTH;
        NSInteger totalCellWidth ;
        if ([Common isIPadPro])
        {
            totalCellWidth= CELL_WIDTH_PRO * [arrayCategories count];
        }
        else{
            totalCellWidth= CELL_WIDTH * [arrayCategories count];
        }
        NSInteger totalSpacingWidth = [(UICollectionViewFlowLayout*)collectionViewLayout minimumInteritemSpacing ]* ([arrayCategories count] -1);
        
        NSInteger leftInset = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2;
        NSInteger rightInset = leftInset;
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset);

    }
    else{
    return UIEdgeInsetsMake(0, 4, 0, 16);
    }// top, left, bottom, right
    

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return [Common iPadProScalableWidth:10.0];
}

#pragma mark - Dismiss Keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_KEYBOARD_NOTIFICATION
                                                        object:self
                                                      userInfo:nil];
    
}
-(void)showTipsScreen
{
    
    //    if([[RestaurantGlobals getDefaultValue:@"TipsDontShow"] boolValue])
    //    {
    //        [tipstimer invalidate];
    //        return;
    //    }
    //
    if(![[self.view subviews] containsObject:objtips.view])
    {
        objtips.view.frame=self.view.frame;
        objtips.view.center=self.view.center;
        objtips.currentIndex=0;
        [objtips setLandguageView];
        [self.view addSubview:objtips.view];
        
    }
    
    if(!objtips.view.alpha)
    {
        //  [objtips showNextTip:nil];
        objtips.currentIndex=0;
        [objtips setLandguageView];
        // [objtips showNextTip:nil];
        [AnimationUtility fadeIn:objtips.view withDuration:0.3];
    }
    
    // [tipstimer invalidate];
}

- (IBAction)AboutUsBtnPressed:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    AboutUsViewController *aboutUsView= (AboutUsViewController*) [storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
    
    CATransition *animation2 = [CATransition animation];
    [animation2 setDuration:0.75];
    animation2.delegate = self;
    [animation2 setType:kCATransitionPush];
    [animation2 setSubtype:kCATransitionFromRight];
    [animation2 setValue:@"Slave" forKey:@"showMasterView"];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[self.navigationController.view layer] addAnimation:animation2 forKey:@"showSlaveViewController"];
    
    self.splitViewController.maximumPrimaryColumnWidth=0;
    
    [self.navigationController pushViewController:aboutUsView animated:NO];
    

}
@end
