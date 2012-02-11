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
            
            UILabel *subLabel = (UILabel *)[subView viewWithTag:101];
            if([subLabel.text isEqualToString:@"开始"]) {
                
                [subView setBackgroundColor:[UIColor redColor]];
                subLabel.text = @"停止";
            }else {
                
                [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
            }
//            if([[subView performSelector:@selector(title)] isEqualToString:@"开始"]) {
//                
//                [subView setBackgroundColor:[UIColor redColor]];
//                if([subView respondsToSelector:@selector(setTitle:)]) {
//                    [subView performSelector:@selector(setTitle:) withObject:@"结束"];
//                    
//                    for (UIView *sub in [subView subviews]) {
//                        if([[[sub class] description] isEqualToString:@"UIButtonLabel"]) {
//                            if([sub respondsToSelector:@selector(setText:)]) {
//                                NSLog(@"----");
//                                [sub performSelector:@selector(setText:) withObject:@"结束"];
//                            }
//                        }
//                    }
//                }
//
//                
//            } else {
//            
//                [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
//            }
        }
        
    }else {
    
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
    
}

@end
