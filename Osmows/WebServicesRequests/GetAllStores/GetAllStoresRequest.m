//
//  HomeCategoriesMenu

//
//  Created by Mosib on 1/10/16.
//  Copyright © 2016 Nadeem Ali. All rights reserved.
//

#import "HomeCategoriesMenu.h"
#import "LoginUser.h"
@implementation HomeCategoriesMenu

- (id)init {
    self = [super init];
    if (self) {
        self.requestName = @"/category/navcategories";
        self.requestService = @"";
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
       NSLog(@"%@",[Common getDeviceId]);
      [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    if (response != [NSNull null]) {

        
        NSMutableArray *arrayCategories=[[NSMutableArray alloc] initWithArray:[response objectForKey:@"data"]];
        
        
        if(arrayCategories.count>0)
        {
            [[DataManager sharedInstance] deleteAll:nil withTable:@"AllMenu"];
        }
        
        for (int i = 0; i < [arrayCategories count]; i++) {
            NSDictionary *dictionary = [arrayCategories objectAtIndex:i];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"AllMenu" inManagedObjectContext:[[DataManager sharedInstance] managedObjectContext]];
            
            Categories *categories = [[Categories alloc] initWithEntity:entity insertIntoManagedObjectContext:[[DataManager sharedInstance] managedObjectContext]];
            [categories setCategoryID:[dictionary objectForKeyNotNull:@"category_id"]];
            [categories setCategoryNameEN:[dictionary objectForKeyNotNull:@"title"]];
            [categories setCategoryThumbImage:[dictionary objectForKeyNotNull:@"image"]];
            [categories setSortID:[dictionary objectForKeyNotNull:@"category_id"]];
            
        }
        
        [[DataManager sharedInstance] save];
        [super didReceiveResponse:response parsedResult:object];
    }
    


    }


- (void) didReceiveFailed:(NSError*)error {
    if ([delegate respondsToSelector:didFail]) {
        NSLog(@"Error: %@ " , [error description]);
        NSDictionary *LoginUserInfoDic = [error userInfo];
        NSString *errorString = [LoginUserInfoDic objectForKey:@"NSLocalizedDescription"];
        if (!errorString || [errorString isEqualToString:@""]) {
            //errorString = EMPTY_ERROR_MESSAGE;
        }
        
        [delegate performSelector:didFail withObject:self withObject:errorString];
    }
}

@end
