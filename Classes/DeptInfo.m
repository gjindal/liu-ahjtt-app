//
//  DeptInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeptInfo.h"

@implementation DeptInfo

@synthesize deptID = _deptID;
@synthesize deptName = _deptName;
@synthesize parentID = _parentID;

- (void)dealloc {

    [_deptID release];
    [_deptName release];
    [_parentID release];
    
    _deptID = nil;
    _deptName = nil;
    _parentID = nil;
    
    [super dealloc];
}

@end
