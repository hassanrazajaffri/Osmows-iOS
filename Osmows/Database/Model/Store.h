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
@end


