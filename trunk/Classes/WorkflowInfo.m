//
//  WorkflowInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WorkflowInfo.h"

@implementation WorkflowInfo

@synthesize endStatus = _endStatus;
@synthesize flowid = _flowid;
@synthesize level = _level;
@synthesize opttype = _opttype;
@synthesize remark = _remark;
@synthesize roleid = _roleid;
@synthesize begStatus = _begStatus;

- (void)dealloc {

    [_endStatus release];
    [_flowid release];
    [_level release];
    [_opttype release];
    [_remark release];
    [_roleid release];
    [_begStatus release];
    
    _endStatus = nil;
    _flowid = nil;
    _level = nil;
    _opttype = nil;
    _remark = nil;
    _roleid = nil;
    _begStatus = nil;
    
    [super dealloc];
}

@end
