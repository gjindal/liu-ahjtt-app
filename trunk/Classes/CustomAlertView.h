//
//  CustomAlertView.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView{

    UIAlertView* uploadAlertView;
}

@property (nonatomic,retain) UIAlertView *uploadAlertView;

-(void)showWaitingWithTitle:(NSString *)title andMessage:(NSString *)message;
-(void)hideWaiting;
-(void)alertInfo:(NSString *)info withTitle:(NSString *)title;
-(void)transFileAlertWithInfo:(NSString *)info andTitle:(NSString *) title;
+(void)NetStart;
+(void)NetEnd;

@end
