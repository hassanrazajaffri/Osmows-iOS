//
//  PhotoCollectionViewCell.h
//  Restaurant
//
//  Created by Nadeem Ali on 12/8/14.
//
//

#import <UIKit/UIKit.h>

@interface SelectPhotoGalleryCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imagePhoto;
@property (nonatomic, weak) IBOutlet UILabel  *lbllikeCount;
@property (nonatomic, weak) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageIcon;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIndicator;
@end
