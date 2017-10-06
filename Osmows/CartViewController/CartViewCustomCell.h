//
//  FriendRequestTableViewCell.h
//  Restaurant
//
//  Created by Nadeem Ali on 2/1/15.
//
//

#import <UIKit/UIKit.h>




@interface LeftMenuCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *menuTitleName;
@property (weak, nonatomic) IBOutlet UIImageView *menuImage;
+(LeftMenuCustomCell*) createCell;
@end
