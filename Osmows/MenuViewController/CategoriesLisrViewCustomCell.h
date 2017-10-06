//
//  FriendRequestTableViewCell.h
//  Restaurant
//
//  Created by Nadeem Ali on 2/1/15.
//
//

#import <UIKit/UIKit.h>




@interface CartViewCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cartItemImage;
@property (weak, nonatomic) IBOutlet UILabel *cartItemName;
@property (weak, nonatomic) IBOutlet UILabel *cartItemPrice;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

+(CartViewCustomCell*) createCell;
@end
