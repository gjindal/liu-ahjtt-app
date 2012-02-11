//
//  MyAlertView.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    if(buttonIndex == 0) {
    
        UIView *subView = [self viewWithTag:1];
        if(subView != nil) {
            
            if([[subView performSelector:@selector(title)] isEqualToString:@"开始"]) {
                
                [subView setBackgroundColor:[UIColor redColor]];
                [subView performSelector:@selector(setTitle:) withObject:@"结束"];
            } else {
            
                [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
            }
        }
        
    }else {
    
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
    
}

@end
