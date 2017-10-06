//
//  Categories.h
//  iMenu
//
//  Created by Nadeem Ali on 12/13/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Categories : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@property (nullable, nonatomic, retain) NSNumber *categoryID;
@property (nullable, nonatomic, retain) NSString *categoryNameEN;
@property (nullable, nonatomic, retain) NSString *categoryNameAR;
@property (nullable, nonatomic, retain) NSString *categoryThumbImage;
@property (nullable, nonatomic, retain) NSNumber *sortID;

@end


