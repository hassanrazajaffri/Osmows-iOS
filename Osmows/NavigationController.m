//
//  NavigationController.m
//  iMenu
//
//  Created by Mosib on 1/14/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController
static NavigationController *navViewController = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NavigationController *)sharedInstance
{
    static dispatch_once_t pred;
    static NavigationController *sharedInstance = nil;
    dispatch_once(&pred, ^{
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    });
    return(sharedInstance);
}

+ (NavigationController*) navController  {
    
    return navViewController;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
