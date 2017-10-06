//
//  ServingTable.h
//  iMenu
//
//  Created by Nadeem Ali on 1/11/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ServingTable : NSManagedObject

@property (nullable, nonatomic, retain) NSString *statusID;
@property (nullable, nonatomic, retain) NSString *tableID;
@property (nullable, nonatomic, retain) NSNumber *tableNo;
@property (nullable, nonatomic, retain) NSString *tableNameEN;
@property (nullable, nonatomic, retain) NSString *tableNameAR;
@property (nullable, nonatomic, retain) NSString *guestName;
@property (nullable, nonatomic, retain) NSString *statusName;
@property (nullable, nonatomic, retain) NSString *orderID;
@property (nullable, nonatomic, retain) NSString *orderTypeID;
@property (nullable, nonatomic, retain) NSString *amount;
@property (nullable, nonatomic, retain) NSString *tableStatusNameEN;
@property (nullable, nonatomic, retain) NSString *tableStatusAR;
@property (nullable, nonatomic, retain) NSString *tableStatusGlowColor;
@property (nullable, nonatomic, retain) NSString *tableStatusColor;
@property (nullable, nonatomic, retain) NSString *guestCapacity;
@property (nullable, nonatomic, retain) NSString *noOfGuest;
@property (assign) BOOL isOnCall;
@property (nullable, nonatomic, retain) NSString *waiterName;
@end
 