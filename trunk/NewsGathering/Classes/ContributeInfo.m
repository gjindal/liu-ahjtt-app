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
@synthesize flowID = _flowID;
@synthesize apps = _appsList;

- (id)init {

    self = [super init];
    if(self != nil) {
    
        _flowID = [[ContributeInfo getFlowID] retain];
    }
    return self;
}


- (void)dealloc {

    [_conid release];
    [_level release];
    [_time release];
    [_title release];
    [_type release];
    [_flowID release];
    [_appsList release];
    
    _conid = nil;
    _level = nil;
    _time = nil;
    _title = nil;
    _type = nil;
    _flowID = nil;
    _appsList = nil;
    
    [super dealloc];
}

#pragma -
#pragma Methods.

+ (NSString *)getFlowID {
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    return [(NSString *)string autorelease];
}

@end
