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
@synthesize delegate;
@synthesize resultData;
@synthesize strRequestType;


+ (void)netWaiting {

    [NSThread detachNewThreadSelector:@selector(threadMain:) toTarget:self withObject:nil];
}

+ (void)threadMain:(id)arg {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (netBussyAlertView == nil) {

        netBussyAlertView = [[CustomAlertView alloc] init];
    }
    [netBussyAlertView showWaitingWithTitle:@"数据加载中" andMessage:@"请等待..."];
    
	[pool release];
	
}

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

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [netBussyAlertView hideWaiting];
    
    bFlag = YES;
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"网络连接错误" 
                          message:@"与服务器连接出现错误." 
                          delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [delegate didFinishedRequest:nil];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    bFlag = YES;
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"------%@",returnString);
    
    [resultData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [netBussyAlertView hideWaiting];
    
    NSString *returnString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    NSLog(@"------%@",returnString);
    [delegate didFinishedRequest:resultData];
}


- (NSData*) PostData:(NSString*) serverURL withRequestString:(NSString *) strPost{
    
    NSLog(@"%@------%@",serverURL,strPost);
    strRequestType = serverURL;
    
    if (resultData == nil) {
        resultData = [[NSMutableData alloc] initWithLength:0];
    }
    [NetRequest netWaiting];
    NSData *postData = [strPost dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];  
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
    [request setURL:[NSURL URLWithString:serverURL]];  
    [request setHTTPMethod:@"POST"]; 
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];  
    [request setHTTPBody:postData];  

//    NetRequest *netRequest = [[NetRequest alloc] init];
//    NSData *returnData = [[netRequest startPost:request] retain];
    //NSData *returnData =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    

//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    [netBussyAlertView hideWaiting];
    return resultData;

}

-(NSData *)startPost:(NSMutableURLRequest *)request{

    bFlag = NO;
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //[connection start];
    
    while (!bFlag) {sleep(1);}
    return resultData;
}




@end
