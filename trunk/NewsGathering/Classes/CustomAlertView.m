//
//  CustomAlertView.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(void)NetStart{
    UIAlertView* uploadAlertView1= [[UIAlertView alloc] initWithTitle:@"数据加载中" message:@"请等待..." 
                                               delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
	
    UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 27.0f, 27.0f);
    [uploadAlertView1 addSubview:activityView];
    [activityView startAnimating];
    [activityView release];
    [uploadAlertView1 show];
}
+(void)NetEnd{
    
}

-(void)showWaitingWithTitle:(NSString *)title andMessage:(NSString *)message{
    uploadAlertView= [[UIAlertView alloc] initWithTitle:title message:message 
                                               delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
	
    UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 27.0f, 27.0f);
    [uploadAlertView addSubview:activityView];
    [activityView startAnimating];
    [activityView release];
    [uploadAlertView show];
}

//消除滚动轮指示器
-(void)hideWaiting
{
    [uploadAlertView dismissWithClickedButtonIndex:0 animated:YES]; 
}

-(void)alertInfo:(NSString *)info withTitle:(NSString *)title{
    
    uploadAlertView = [[UIAlertView alloc] initWithTitle:title message:info
                                                       delegate:nil 
                                              cancelButtonTitle:@"关闭" 
                                              otherButtonTitles:nil];
    [uploadAlertView show];
    [uploadAlertView release];
}

@end
