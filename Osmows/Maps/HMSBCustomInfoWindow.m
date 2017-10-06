//
//  HMSBCustomInfoWindow.m
//  HelloMapStoryboard
//
//  Created by Lorenco Gonzaga on 04/05/14.
//  Copyright (c) 2014 Example. All rights reserved.
//

#import "HMSBCustomInfoWindow.h"

@implementation HMSBCustomInfoWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      

    }
    return self;
}
-(void) awakeFromNib
{
    [super awakeFromNib];
    self.backView.layer.borderColor=[UIColor colorWithRed:0.02 green:0.20 blue:0.63 alpha:1.0].CGColor;
    self.backView.layer.borderWidth=1.0;
    self.backView.layer.cornerRadius=5.0;
    self.backView.layer.masksToBounds=YES;
   

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
