//
//  CartObject.h
//  iMenu
//
//  Created by Mosib on 12/15/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartObject : NSObject

@property (nonatomic, strong) NSString* itemCategory;
@property (nonatomic, strong) NSString* itemCategoryAR;
@property (nonatomic, assign) int categoryID;
@property (nonatomic, strong) NSString* itemName;
@property (nonatomic, strong) NSString* itemNameAR;
@property (nonatomic, assign) int itemID;
@property (nonatomic, assign) int itemQuantity;
@property (nonatomic, assign) int itemCost;
@property (nonatomic, assign) int prevItemCount;
@property (nonatomic, strong) NSString* strItemImage;
@property (nonatomic, strong) NSString* orderDetailNote;
@property (nonatomic, strong) NSString* orderNote;
@property (nonatomic, strong) NSString* StatusID;
@property (nonatomic, strong) NSString* OrderTypeID;
@property (nonatomic, assign) int catSortID;
@property (nonatomic, assign) NSString *orderID;
@property (nonatomic, assign) int orderDetailID;
@property (nonatomic, strong) NSString *servedStatus;
@property (nonatomic, strong) NSString *dishDescriptionEN;
@property (nonatomic, strong) NSString *dishDescriptionAR;

-(void) setCartObject:(CartObject*) pObj;
-(void) removeCartObject:(CartObject*) pObj;

@end
