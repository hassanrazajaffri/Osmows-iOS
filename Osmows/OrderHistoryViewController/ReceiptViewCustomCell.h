//
//  FriendRequestTableViewCell.h
//  Restaurant
//
//  Created by Nadeem Ali on 2/1/15.
//
//

#import <UIKit/UIKit.h>




@interface OrderHistoryViewCustomCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *orderDate;
@property (weak, nonatomic) IBOutlet UIButton *reorderButton;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *OrderFirstDishName;
@property (weak, nonatomic) IBOutlet UIButton *viewReciptBtn;

@property (weak, nonatomic) IBOutlet UILabel *orderPricwe;
+(OrderHistoryViewCustomCell*) createCell;
@end
