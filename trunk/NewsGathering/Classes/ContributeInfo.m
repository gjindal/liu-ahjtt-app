//
//  ContributeInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContributeInfo.h"

@implementation ContributeInfo

@synthesize conid = _conid;
@synthesize level = _level;
@synthesize time = _time;
@synthesize title = _title;
@synthesize type = _type;

- (void)dealloc {

    [_conid release];
    [_level release];
    [_time release];
    [_title release];
    [_type release];
    
    _conid = nil;
    _level = nil;
    _time = nil;
    _title = nil;
    _type = nil;
    
    [super dealloc];
}

@end
