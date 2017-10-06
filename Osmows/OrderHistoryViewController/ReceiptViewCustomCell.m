//
//  FriendRequestTableViewCell.m
//  Restaurant
//
//  Created by Nadeem Ali on 2/1/15.
//
//

#import "OrderHistoryViewCustomCell.h"

@implementation OrderHistoryViewCustomCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(OrderHistoryViewCustomCell*) createCell {
    OrderHistoryViewCustomCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderHistoryViewCustomCell" owner:self options:nil]lastObject];
    //    UIImageView *imgview = [[[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"TableCellBG.png"]]  autorelease];
    //    imgview.opaque = NO;
    //    imgview.clearsContextBeforeDrawing = YES;
    //    [imgview setBackgroundColor:[UIColor clearColor]];
    // cell.backgroundView = imgview;
    //  UIImageView *imgvieselected = [[[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"TableCellSelectedBG.png"]]autorelease];
    // cell.selectedBackgroundView = imgvieselected;
//    cell.imgProfile.layer.cornerRadius=cell.imgProfile.frame.size.width/2;
//    cell.imgProfile.layer.masksToBounds=YES;
//    cell.btnAccept.layer.borderColor=[HexColor colorWithHexString:@"014CA7"].CGColor;
//    cell.btnAccept.layer.borderWidth=1.0;
//    cell.btnAccept.layer.cornerRadius=5.0;
//    cell.btnAccept.layer.masksToBounds=YES;
   
    return cell;
}

@end
