//
//  NetRequest.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_URL @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/"

@interface NetRequest : NSObject{

    NSString *strPost;
    NSString *serverURL;

}

@property (nonatomic,retain) NSString *strPost;
@property (nonatomic,retain) NSString *serverURL;
+(NSData*) PostData:(NSString*) serverURL withRequestString:(NSString *) strPost;
@end
