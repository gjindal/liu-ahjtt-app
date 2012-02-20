//
//  NetRequest.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetRequest.h"

@implementation NetRequest
@synthesize serverURL,strPost;


+(NSData*) PostData:(NSString*) serverURL withRequestString:(NSString *) strPost{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

	NSData *postData =[NSData dataWithBytes:[strPost UTF8String] length:[strPost length]];
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
	[request setURL:[NSURL URLWithString:serverURL]];  
	[request setHTTPMethod:@"POST"]; 
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];  
	[request setHTTPBody:postData];  
    
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse :nil error:nil];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	return returnData;

}
@end
