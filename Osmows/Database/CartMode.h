//
//  CartMode.h
//  iMenu
//
//  Created by Mosib on 1/14/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartMode : NSObject

+ (CartMode *)sharedInstance;
@property(nonatomic, assign) int StatusID;
@property(nonatomic, assign) BOOL isUpdateModeCart;
@property(nonatomic, assign) BOOL isPotentialUpdateMode;
@property (nonatomic, assign) BOOL isCartClosed;
@end


