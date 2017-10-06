//
//  FriendRequestTableViewCell.h
//  Restaurant
//
//  Created by Nadeem Ali on 2/1/15.
//
//

#import <UIKit/UIKit.h>




@interface CategoriesLisrViewCustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *categoryTitle;

@property (strong, nonatomic) IBOutlet UIImageView *categoryImage;

+(CategoriesLisrViewCustomCell*) createCell;
@end
