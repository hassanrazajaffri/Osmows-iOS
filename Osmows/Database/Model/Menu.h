//
//  Dishes.h
//  iMenu
//
//  Created by Nadeem Ali on 12/13/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface Menu : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nullable, nonatomic, retain) NSNumber *menuID;
@property (nullable, nonatomic, retain) NSString *createdBy;
@property (nullable, nonatomic, retain) NSString *createdOn;
@property (nullable, nonatomic, retain) NSString *endTime;
@property (nullable, nonatomic, retain) NSString *startTime;
@property (nullable, nonatomic, retain) NSString *menuTitleAR;
@property (nullable, nonatomic, retain) NSString *menuTitleEN;
@property (nullable, nonatomic, retain) NSString *modifiedBy;
@property (nullable, nonatomic, retain) NSString *modifiedOn;
@property (nullable, nonatomic, retain) NSNumber *restaurantID;
@property (assign) BOOL isActive;
@property (assign) BOOL isDelete;

@end

