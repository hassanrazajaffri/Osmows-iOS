//
//  CartObject.m
//  iMenu
//
//  Created by Mosib on 12/15/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import "CartObject.h"


@implementation CartObject

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self.OrderTypeID = [aDecoder decodeObjectForKey:@"OrderTypeID"];
    self.itemCategory = [aDecoder decodeObjectForKey:@"itemCategory"];
    self.itemCategoryAR = [aDecoder decodeObjectForKey:@"itemCategoryAR"];
    self.categoryID = [aDecoder decodeIntegerForKey:@"categoryID"];
    self.itemName = [aDecoder decodeObjectForKey:@"itemName"];
    self.itemNameAR = [aDecoder decodeObjectForKey:@"itemNameAR"];
    self.itemID = [aDecoder decodeIntegerForKey:@"itemID"];
    self.itemQuantity = [aDecoder decodeIntegerForKey:@"itemQuantity"];
    self.itemCost = [aDecoder decodeIntegerForKey:@"itemCost"];
    self.prevItemCount = [aDecoder decodeIntegerForKey:@"prevItemCount"];
    self.strItemImage = [aDecoder decodeObjectForKey:@"strItemImage"];
    self.orderNote = [aDecoder decodeObjectForKey:@"OrderDetailNote"];
    self.catSortID = [aDecoder decodeIntegerForKey:@"catSortID"];
    self.StatusID = [aDecoder decodeObjectForKey:@"StatusID"];
     self.dishDescriptionAR = [aDecoder decodeObjectForKey:@"dishDescriptionAR"];
    self.dishDescriptionEN = [aDecoder decodeObjectForKey:@"dishDescriptionEN"];

    [CartItems sharedInstance]._itemsDictionary = [aDecoder decodeObjectForKey:@"data"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
     [aCoder encodeObject:self.dishDescriptionEN forKey:@"dishDescriptionEN"];
    [aCoder encodeObject:self.dishDescriptionAR forKey:@"dishDescriptionAR"];
 [aCoder encodeObject:self.OrderTypeID forKey:@"OrderTypeID"];
     [aCoder encodeObject:self.StatusID forKey:@"StatusID"];
    [aCoder encodeObject:self.itemCategory forKey:@"itemCategory"];
        [aCoder encodeObject:self.itemCategoryAR forKey:@"itemCategoryAR"];
        [aCoder encodeInteger:self.categoryID forKey:@"categoryID"];
        [aCoder encodeObject:self.itemName forKey:@"itemName"];
        [aCoder encodeObject:self.itemNameAR forKey:@"itemNameAR"];
        [aCoder encodeInteger:self.itemID forKey:@"itemID"];
        [aCoder encodeInteger:self.itemQuantity forKey:@"itemQuantity"];
        [aCoder encodeInteger:self.itemCost forKey:@"itemCost"];
        [aCoder encodeInteger:self.prevItemCount forKey:@"prevItemCount"];
        [aCoder encodeObject:self.strItemImage forKey:@"strItemImage"];
        [aCoder encodeInteger:self.catSortID forKey:@"catSortID"];
        [aCoder encodeInteger:self.orderNote forKey:@"OrderDetailNote"];
    
    [aCoder encodeObject:[CartItems sharedInstance]._itemsDictionary forKey:@"data"];
}

-(void) setCartObject:(CartObject*) pObj{

    if(![[CartMode sharedInstance ] isCartClosed])
        [[CartItems sharedInstance] setCartItem:pObj];
    else
    {
        [Common showAlertWithTitle:nil message:[AppSettings getValueForKey:@"CartClosedAlert"] delegate:nil withTag:0 cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
}

-(void) removeCartObject:(CartObject*) pObj{
    if(![[CartMode sharedInstance ] isCartClosed])
        [[CartItems sharedInstance] removeCartItem:pObj withUpdateBool:NO];
    else
    {
        [Common showAlertWithTitle:nil message:[AppSettings getValueForKey:@"CartClosedAlert"] delegate:nil withTag:0 cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
}

@end
