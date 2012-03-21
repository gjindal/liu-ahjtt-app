//
//  NetRequest.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomAlertView.h"

#define SERVER_URL @"http://hfhuadi.vicp.cc:8080/editmobile/mobile"

@protocol NetRequestDelegate <NSObject>
@optional
-(void) didFinishedRequest:(NSData*)result;
@end

static NSData *returnData=nil;
static CustomAlertView *netBussyAlertView = nil;
@interface NetRequest : NSObject<NSURLConnectionDelegate>{

    id<NetRequestDelegate> delegate;
    NSMutableData *resultData;
    BOOL bFlag;
    NSString *strRequestType;
}

@property (nonatomic,retain) id<NetRequestDelegate> delegate;
@property (nonatomic,retain) NSMutableData *resultData;
@property (nonatomic,retain) NSString *strRequestType;

-(void)startPost:(NSMutableURLRequest *)request;

+(void)cancelURLConnection:(NSTimer *)timer;
-(NSData*) PostData:(NSString*) serverURL withRequestString:(NSString *) strPost;

+ (void)netWaiting;
+ (void)threadMain:(id)arg;
@end
