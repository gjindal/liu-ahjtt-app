//
//  LoginResultInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginResultInfo.h"

@implementation LoginResultInfo

@synthesize isLoginSuccess = _isLoginSuccess;
@synthesize flag = _flag;
@synthesize message = _message;


- (void)dealloc {

    [_message release];
    _message = nil;
    
    [super dealloc];
}

@end
