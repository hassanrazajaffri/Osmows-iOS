//
//  NavigationBar.m
//  GMG App
//
//  Created by Mosib on 4/26/15.
//  Copyright (c) 2015 Advansoft. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (NavigationBar*)sharedInstance {
    static dispatch_once_t pred;
    static NavigationBar *sharedModel = nil;
    
    dispatch_once(&pred, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}


+ (id) createView{
    
    NavigationBar *view = [Common loadNibName:@"NavigationBar" owner:self options:nil];
//    view.labelCartCount.backgroundColor = [UIColor redColor];
//    [[view.labelCartCount layer] setCornerRadius:7.0f];
    //[[view.labelCartCount layer] setMasksToBounds:YES];
    //[view.buttonHome setTitle:[NSString stringWithFormat:@"%@",AppLanguage==ENGLISH?[[User sharedInstance] restaurantNameEN] : [[User sharedInstance] restaurantNameAR] ] forState:UIControlStateNormal];
  //  [view.HomeImage setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantLogo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]  cache:YES];\
    
    NSLog(@"Color code is :: %@",[[User sharedInstance] barHexCode]);
    
    view.backgroundColor=[HexColor colorWithHexString:[[User sharedInstance] barHexCode]];
    
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[User sharedInstance] textureImageLogo]]];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:urlString]])];
    UIImage *image = [UIImage imageWithData:imageData];
    //view.backgroundColor=[[UIColor alloc] initWithPatternImage:image];
    
    
    CGRect originalFrame = [[UIScreen mainScreen] bounds];
    view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y, originalFrame.size.width, view.frame.size.height);
    
    
    
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                       NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSString *urlLogo =[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantLogo];
                       NSString *filenameLogo = [[urlLogo lastPathComponent] stringByDeletingPathExtension];
                       
                       UIImage * imageFromWebLogo = [Common loadImage:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filenameLogo] ofType:@"png" inDirectory:documentsDirectoryPath];
                       if (!imageFromWebLogo) {
                           
                           UIImage * imageFromURLlogo = [Common getImageFromURL:[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantLogo]];
                           [Common saveImage:imageFromURLlogo withFileName:[NSString stringWithFormat:@"%@%@%@",[User sharedInstance].userName,[User sharedInstance].resturantID,filenameLogo] ofType:@"png" inDirectory:documentsDirectoryPath];
                           
                       }

                       dispatch_sync(dispatch_get_main_queue(), ^{
                           
                           
                           if (imageFromWebLogo) {
                               [view.HomeImage setImage:imageFromWebLogo];
                               
                           }
                           else{
                              
                               
                              [view.HomeImage sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantLogo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil options:nil];
                               
                               
                           }
                           
                       });
                   });

    
    
    
    
    
    if([Common isIPadPro]){
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 104);
        
    }
    
    
//    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // Add code here to do background processing
//        //
//         NSData *imagedata=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",[HTTPCommon getBaseUrl],[User sharedInstance].restaurantLogo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ];
//
//        dispatch_async( dispatch_get_main_queue(), ^{
//            // Add code here to update the UI/send notifications based on the
//            // results of the background processing
//            [view.buttonHome setImage:[UIImage imageWithData:imagedata] forState:UIControlStateNormal];
//
//        });
//    });
    
//   //
    
    view.languageBtn.layer.shadowColor = [UIColor blackColor].CGColor;
     view.languageBtn.layer.shadowOpacity = 1;
     view.languageBtn.layer.shadowRadius = 3;
     view.languageBtn.layer.shadowOffset = CGSizeMake(1, 1);
    view.helpBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    view.helpBtn.layer.shadowOpacity = 1;
    view.helpBtn.layer.shadowRadius = 3;
    view.helpBtn.layer.shadowOffset = CGSizeMake(1, 1);
    return view;
}



@end
