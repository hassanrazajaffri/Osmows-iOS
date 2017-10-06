//
//  NavigationBar.h
//  GMG App
//
//  Created by Mosib on 4/26/15.
//  Copyright (c) 2015 Advansoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CartView.h"
@interface NavigationBar : UIView

+ (id) createView;
+ (NavigationBar*)sharedInstance;

@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UIButton *buttonHome;
@property (weak, nonatomic) IBOutlet UIImageView *HomeImage;

@property (weak, nonatomic) IBOutlet UIView *viewCart;
@property (strong, nonatomic) IBOutlet UILabel *labelCartCount;

@property(nonatomic,strong) NSString *cartValue;
@property(nonatomic,assign) BOOL cartActive;
@property (weak, nonatomic) IBOutlet UIButton *languageBtn;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;

@end
