//
//  UserInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize userID = _userID;
@synthesize userName = _userName;

- (void)dealloc {

    [_userID release];
    [_userName release];
    
    _userID = nil;
    _userName = nil;
    
    [super dealloc];
}

@end
