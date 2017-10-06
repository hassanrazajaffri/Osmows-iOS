//
//  CartItems.h
//  iMenu
//
//  Created by Mosib on 12/20/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartObject.h"
#import "MasterViewController.h"


@interface CartItems : NSObject
{
    AVAudioPlayer *_audioPlayer;
 
}
+ (CartItems *)sharedInstance;

-(void) removeCartItem:(CartObject*) obj withUpdateBool:(BOOL) isRemovable;
-(void) setCartItem:(CartObject*) obj;

@property(nonatomic,retain) MasterViewController *cartProtocol;
@property(nonatomic,retain) NSMutableArray* _items;
@property(nonatomic,retain) NSMutableDictionary* _itemsDictionary;

-(void) UpdateObjectInCart:(CartObject*) obj;
-(void) insertObjectInCart:(NSMutableArray*) array andObject:(CartObject*) obj withUpdateBool:(BOOL) isUpdateMode withSound:(BOOL) pIsPlaySound ;
@property(nonatomic, strong) NSString *strOrderNotes;
@property(nonatomic, strong) NSString *OrderStartTime;
@property(nonatomic, strong) NSString *sessionNumber;

@property(nonatomic, strong) NSString *OrderCloseTime;
-(void) tableResumptioninsertObjectInCart:(NSMutableArray*) array andObject:(CartObject*) obj withUpdateBool:(BOOL) isUpdateMode withSound:(BOOL)pIsPlaySound;
-(void) resetCartDictionary:(NSDictionary*) pDictionary;
@end
