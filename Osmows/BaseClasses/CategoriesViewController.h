//
//  ViewController.h
//  iMenu
//
//  Created by Nadeem Ali on 11/29/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUpView.h"
@interface CategoriesViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    float photocellX;
    float COLLECTIONVIEW_WIDTH;
     PopUpView *myPopUP;
}

@property (weak, nonatomic) IBOutlet UIButton *aboutUsBtn;
- (IBAction)AboutUsBtnPressed:(id)sender;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIButton *btnlanguage;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *previousDishBtn;
- (IBAction)previousDishBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextDishBtn;
- (IBAction)nextDishBtnPressed:(id)sender;

- (IBAction)showHelpViewController:(id)sender;
-(void)updateCollectionViewandButton;
@end

