//
//  CenterController.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/8/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *categoriesTableList;
@property (strong, nonatomic)  NSString *subCatID;
@property(nonatomic, assign) BOOL isAllMenu;
@end
