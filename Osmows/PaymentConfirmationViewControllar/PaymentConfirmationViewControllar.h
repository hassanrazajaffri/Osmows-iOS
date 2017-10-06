//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewControllar : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *creditCardBtn;
- (IBAction)CreditCardBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *debitCardBtn;
- (IBAction)DebitCardBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *cardData1;
@property (strong, nonatomic) IBOutlet UITextField *cardData2;
@property (strong, nonatomic) IBOutlet UITextField *cardData3;
@property (strong, nonatomic) IBOutlet UITextField *cardData4;
@property (strong, nonatomic) IBOutlet UIImageView *cardImage;
@property (strong, nonatomic) IBOutlet UITextField *CardExpiryDate;
@property (strong, nonatomic) IBOutlet UITextField *cardCode;
@property (strong, nonatomic) IBOutlet UIButton *rememberMeCheckBox;
- (IBAction)RememberMeBtnPressed:(id)sender;
- (IBAction)AuthorizedPressed:(id)sender;

@end
