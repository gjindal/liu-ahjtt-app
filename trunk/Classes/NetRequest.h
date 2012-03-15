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

static NSData *returnData=nil;
static CustomAlertView *netBussyAlertView = nil;
@interface NetRequest : NSObject{

    
}

+(void)cancelURLConnection:(NSTimer *)timer;
+(NSData*) PostData:(NSString*) serverURL withRequestString:(NSString *) strPost;
@end
