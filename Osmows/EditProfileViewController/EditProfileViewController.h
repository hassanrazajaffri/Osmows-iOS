//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
@interface SignUpViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
- (IBAction)EditImagePressed:(id)sender;
@property (strong, nonatomic) IBOutlet TextFieldValidator *firstName;
@property (strong, nonatomic) IBOutlet TextFieldValidator *lastName;
@property (strong, nonatomic) IBOutlet TextFieldValidator *mobileNumber;
@property (strong, nonatomic) IBOutlet TextFieldValidator *email;
@property (strong, nonatomic) IBOutlet TextFieldValidator *userName;
@property (strong, nonatomic) IBOutlet TextFieldValidator *password;
@property (strong, nonatomic) IBOutlet TextFieldValidator *confirmPassword;
- (IBAction)SignupBtnPressed:(id)sender;

@end
