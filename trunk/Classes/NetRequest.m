//
//  NetRequest.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetRequest.h"
#import "CustomAlertView.h"



@implementation NetRequest


+(void)cancelURLConnection:(NSTimer *)timer {
    if (returnData == nil) {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"网络连接错误" 
                              message:@"与服务器连接出现错误." 
                              delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

+(NSData*) PostData:(NSString*) serverURL withRequestString:(NSString *) strPost{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (netBussyAlertView == nil) {
        netBussyAlertView = [[CustomAlertView alloc] init];
    }
    [netBussyAlertView showWaitingWithTitle:@"数据加载中" andMessage:@"请等待..."];
    
    NSData *postData = [strPost dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];  
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
    [request setURL:[NSURL URLWithString:serverURL]];  
    [request setHTTPMethod:@"POST"]; 
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];  
    [request setHTTPBody:postData];  

    NSData *returnData =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [netBussyAlertView hideWaiting];
    return returnData;
}




@end
