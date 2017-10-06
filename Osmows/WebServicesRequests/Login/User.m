//
//  User.m
//  iMenu
//
//  Created by Mosib on 1/12/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)sharedInstance
{
    static dispatch_once_t pred;
    static User *sharedInstance = nil;
    dispatch_once(&pred, ^{
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    });
    return(sharedInstance);
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.tableID = [decoder decodeObjectForKey:@"tableID"];
        self.userID = [decoder decodeObjectForKey:@"userID"];
        self.resturantID = [decoder decodeObjectForKey:@"resturantID"];
        self.barHexCode= [decoder decodeObjectForKey:@"barHexCode"];
        self.loginKey = [decoder decodeObjectForKey:@"loginKey"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.restaurantNameEN = [decoder decodeObjectForKey:@"restaurantNameEN"];
        self.featureList = [decoder decodeObjectForKey:@"featureList"];
        self.restaurantNameAR = [decoder decodeObjectForKey:@"restaurantNameAR"];
         self.restaurantDetailsAR = [decoder decodeObjectForKey:@"restaurantDetailsAR"];
         self.restaurantDetailsEN= [decoder decodeObjectForKey:@"restaurantDetailsEN"];
        self.isTableNew = [[decoder decodeObjectForKey:@"isTableNew"] boolValue];
        self.restaurantBackgroundImage = [decoder decodeObjectForKey:@"restaurantBackgroundImage"];
        self.restaurantLogo = [decoder decodeObjectForKey:@"restaurantLogo"];
        self.textureImageLogo = [decoder decodeObjectForKey:@"textureImageLogo"];
        self.ProductFeature = [decoder decodeObjectForKey:@"ProductFeature"];


    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    
         [encoder encodeObject:self.ProductFeature forKey:@"ProductFeature"];
         [encoder encodeObject:self.featureList forKey:@"featureList"];
         [encoder encodeObject:self.barHexCode forKey:@"barHexCode"];
         [encoder encodeObject:self.tableID forKey:@"tableID"];
         [encoder encodeObject:self.userID forKey:@"userID"];
         [encoder encodeObject:self.resturantID forKey:@"resturantID"];
         [encoder encodeObject:self.loginKey forKey:@"loginKey"];
         [encoder encodeObject:self.userName forKey:@"userName"];
         [encoder encodeObject:self.restaurantNameEN forKey:@"restaurantNameEN"];
         [encoder encodeObject:self.restaurantNameAR forKey:@"restaurantNameAR"];
         [encoder encodeObject:self.restaurantDetailsAR forKey:@"restaurantDetailsAR"];
         [encoder encodeObject:self.restaurantDetailsEN forKey:@"restaurantDetailsEN"];

         [encoder encodeObject:[NSNumber numberWithBool:self.isTableNew] forKey:@"isTableNew"];
         [encoder encodeObject:self.restaurantBackgroundImage forKey:@"restaurantBackgroundImage"];
         [encoder encodeObject:self.restaurantLogo forKey:@"restaurantLogo"];
         [encoder encodeObject:self.textureImageLogo forKey:@"textureImageLogo"];

}


@end
