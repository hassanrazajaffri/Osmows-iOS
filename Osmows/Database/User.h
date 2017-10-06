//
//  User.h
//  iMenu
//
//  Created by Mosib on 1/12/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

+ (User *)sharedInstance;

@property(nonatomic,retain) NSString *tableID;
@property(nonatomic,retain) NSString *userID;
@property(nonatomic,retain) NSString *resturantID;
@property(nonatomic,retain) NSString *loginKey;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *restaurantNameEN;
@property(nonatomic,retain) NSString *restaurantNameAR;
@property(nonatomic,retain) NSString *restaurantDetailsEN;
@property(nonatomic,retain) NSString *restaurantDetailsAR;
@property(nonatomic,retain) NSString *barHexCode;
@property(nonatomic,assign) BOOL isTableNew;
@property(nonatomic,retain) NSString *restaurantBackgroundImage;
@property(nonatomic,retain) NSString *restaurantLogo;
@property(nonatomic,retain) NSString *textureImageLogo;
@property(nonatomic,retain) NSArray *featureList;
@property(nonatomic,retain) NSArray *ProductFeature;

@end
