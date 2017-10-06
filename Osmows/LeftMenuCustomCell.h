//
//  FriendRequestTableViewCell.h
//  Restaurant
//
//  Created by Nadeem Ali on 2/1/15.
//
//

#import <UIKit/UIKit.h>


@protocol FriendRequestCellDelegate <NSObject>

-(void)AcceptFriendRequestTapped:(NSNumber*)tag;
-(void)DeclineFriendRequestTapped:(NSNumber*)tag;
@end

@interface FriendRequestTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imgProfile;
@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UILabel *lblMessage;

@property (nonatomic, weak) IBOutlet UIButton *btnAccept;
@property (nonatomic, weak) IBOutlet UIButton *btnReject;



@property (nonatomic, assign) id<FriendRequestCellDelegate> delegate;

+(FriendRequestTableViewCell*) createCell ;

-(IBAction)acceptBtnPressed:(id)sender;
-(IBAction)declineBtnPressed:(id)sender;
@end
