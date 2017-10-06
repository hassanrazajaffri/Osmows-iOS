//
//  CartItems.m
//  iMenu
//
//  Created by Mosib on 12/20/15.
//  Copyright © 2015 Nadeem Ali. All rights reserved.
//

#import "CartItems.h"

@implementation CartItems

-(id)initWithCoder:(NSCoder *)aDecoder{
    [CartItems sharedInstance]._itemsDictionary = [aDecoder decodeObjectForKey:@"data"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[CartItems sharedInstance]._itemsDictionary forKey:@"data"];
}

+ (CartItems *)sharedInstance
{
    static dispatch_once_t pred;
    static CartItems *sharedInstance = nil;
    dispatch_once(&pred, ^{
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
        sharedInstance._items = [NSMutableArray array];
        
        sharedInstance._itemsDictionary = [[NSMutableDictionary alloc] init];
    });
    return(sharedInstance);
}

-(void) resetCartDictionary:(NSDictionary*) pDictionary{
    [[CartItems sharedInstance]._itemsDictionary removeAllObjects];
    [CartItems sharedInstance]._itemsDictionary  = [[NSMutableDictionary alloc] initWithDictionary:pDictionary];
}

-(void) setCartItem:(CartObject*) obj{
    NSMutableArray *array = [self._itemsDictionary objectForKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
    if (!array) {
        array = [[NSMutableArray alloc] init];
    }
    
    [self insertObjectInCart:array andObject:obj withUpdateBool:NO withSound:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_CART_NOTIFICATION
                                                        object:self
                                                      userInfo:nil];
}

-(void) removeCartItem:(CartObject*) obj withUpdateBool:(BOOL) isRemovable{

    NSMutableArray* array = [self._itemsDictionary objectForKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
//    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:[self._itemsDictionary objectForKey:[NSString stringWithFormat:@"%d",obj.catSortID]], nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.itemID == %d", obj.itemID];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    CartObject *object = [[CartObject alloc] init];
    
    if (isRemovable) {

        if (obj.itemQuantity -  1< obj.prevItemCount) {
            return;
        }
    }
    [self playRemovalSound];
    
    if ([filteredArray count] > 0) {
        object = (CartObject*)[filteredArray objectAtIndex:0];
        float cost = object.itemCost/object.itemQuantity;
        object.itemCost = object.itemCost - cost;
        [array removeObject:object];
    }
    else{
        object = (CartObject*)obj;
    }
    object.itemQuantity = object.itemQuantity - 1;
    if (!isRemovable) {
        object.prevItemCount = object.prevItemCount - 1;
    }

    if (object.itemQuantity > 0) {
        [array addObject:object];
    }
    if(array.count>0)
    {
        [self._itemsDictionary setObject:array forKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
    }
    else{
        [self._itemsDictionary removeObjectForKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
    }
    
//    [self sendMyMessage];
}

-(void) insertObjectInCart:(NSMutableArray*) array andObject:(CartObject*) obj withUpdateBool:(BOOL) isUpdateMode withSound:(BOOL)pIsPlaySound{
    if (pIsPlaySound) {
        [self playAddSound];        
    }

    if (!self._itemsDictionary || self._itemsDictionary == nil) {
        self._itemsDictionary = [[NSMutableDictionary alloc] init];
    }
    if (!array) {
        array = [self._itemsDictionary objectForKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.itemID == %d", obj.itemID];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    CartObject *object = [[CartObject alloc] init];
    if ([filteredArray count] > 0) {
        object = (CartObject*)[filteredArray objectAtIndex:0];

        float cost = object.itemCost/object.itemQuantity;
        object.itemCost = object.itemCost + cost;
        [array removeObject:object];
    }
    else{ 
        object = (CartObject*)obj;
        
        object.prevItemCount = 0;
    }
    object.itemQuantity = object.itemQuantity + 1;
    object.itemID = obj.itemID;
    NSLog(@"%d, %d",object.itemID,obj.itemID);
    if(![[CartMode sharedInstance] isUpdateModeCart]){
        object.prevItemCount = object.prevItemCount + 1;
    }
    [array addObject:object];
    [self._itemsDictionary setObject:array forKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
}
-(void) UpdateObjectInCart:(CartObject*) obj{
    NSMutableArray* array = [self._itemsDictionary objectForKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.itemID == %d", obj.itemID];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    CartObject *object = [[CartObject alloc] init];
    if ([filteredArray count] > 0) {
        object = (CartObject*)[filteredArray objectAtIndex:0];
        [array removeObject:object];
    }
    else{
        object = (CartObject*)obj;
    }
    if (object.prevItemCount > 0) {
        object.prevItemCount = object.itemQuantity;
    }
    if (array) {
        [array addObject:object];
        [self._itemsDictionary setObject:array forKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
    }    
//        [self sendMyMessage];
}

-(void) playAddSound{
    NSString *path = [NSString stringWithFormat:@"%@/beep.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayer play];
    
}

-(void) playRemovalSound{
    NSString *path = [NSString stringWithFormat:@"%@/beepRemove.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayer play];
    
}
#pragma mark - Table Resumtion 
-(void) tableResumptioninsertObjectInCart:(NSMutableArray*) array andObject:(CartObject*) obj withUpdateBool:(BOOL) isUpdateMode withSound:(BOOL)pIsPlaySound{
    if (!self._itemsDictionary || self._itemsDictionary == nil) {
        self._itemsDictionary = [[NSMutableDictionary alloc] init];
    }
    if (!array) {
        array = [self._itemsDictionary objectForKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
        if (!array) {
            array = [[NSMutableArray alloc] init];
        }
    }
    [array addObject:obj];
    [self._itemsDictionary setObject:array forKey:[NSString stringWithFormat:@"%d",obj.catSortID]];
}

//-(void)sendMyMessage{
//    
//    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:[[CartItems sharedInstance] _itemsDictionary]];
//    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
//    NSError *error;
//    
//    [_appDelegate.mcManager.session sendData:dataToSend
//                                     toPeers:allPeers
//                                    withMode:MCSessionSendDataReliable
//                                       error:&error];
//    
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
//}
//
//-(void)sendMyMessage{
//    NSDictionary *dictionary = [[NSDictionary alloc] initWithDictionary:self._itemsDictionary];
//    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
//    
//    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
//    NSError *error;
//    
//    [_appDelegate.mcManager.session sendData:dataToSend
//                                     toPeers:allPeers
//                                    withMode:MCSessionSendDataReliable
//                                       error:&error];
//    
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
//}

@end
