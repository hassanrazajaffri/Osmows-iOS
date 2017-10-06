//
//  Dishes.h
//  iMenu
//
//  Created by Nadeem Ali on 12/13/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface Dishes : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nullable, nonatomic, retain) NSNumber *dishID;
@property (nullable, nonatomic, retain) NSString *dishNameEN;
@property (nullable, nonatomic, retain) NSString *dishDescriptionEN;
@property (nullable, nonatomic, retain) NSString *dishFullImage;
@property (nullable, nonatomic, retain) NSNumber *categoryID;
@property (nullable, nonatomic, retain) NSString *dishPrice;
@property (nullable, nonatomic, retain) NSString *calories;
@property (nullable, nonatomic, retain) NSNumber *sortID;

@property (nullable, nonatomic, retain) NSString *itemCode;
@property (nullable, nonatomic, retain) NSString *descriptionEN;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *qty;
@property (nullable, nonatomic, retain) NSString *categoryCode;
@property (nullable, nonatomic, retain) NSString *groupCode;
@property (nullable, nonatomic, retain) NSString *itemType;
@property (nullable, nonatomic, retain) NSString *instock;
@property (nullable, nonatomic, retain) NSString *countDown;
@property (nullable, nonatomic, retain) NSString *isDeletedItem;
@property (nullable, nonatomic, retain) NSString *useForcedModifier;
@property (nullable, nonatomic, retain) NSString *useForcedTopping;
@property (nullable, nonatomic, retain) NSString *packageType;
@property (nullable, nonatomic, retain) NSString *lastUpdatedTime;
@property (nullable, nonatomic, retain) NSString *storeNumber;
   
@end


