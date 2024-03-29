//
//  ContributeInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContributeInfo.h"

@implementation AttLsInfo

@synthesize fileName = _fileName;
@synthesize attLsID = _attLsID;

- (void)dealloc {

    [_fileName release];
    [_attLsID release];
    
    _fileName = nil;
    _attLsID = nil;
    
    [super dealloc];
}

@end

@implementation WorkLog

@synthesize logID = _logID;
@synthesize recuseuserID = _recuseuserID;
@synthesize status = _status;
@synthesize userID = _userID;

- (void)dealloc {
    
    [_logID release];
    [_recuseuserID release];
    [_status release];
    [_userID release];
    
    _logID = nil;
    _recuseuserID = nil;
    _status = nil;
    _userID = nil;
    
    [super dealloc];
}

@end

@implementation ContributeInfo

@synthesize conid = _conid;
@synthesize level = _level;
@synthesize time = _time;
@synthesize title = _title;
@synthesize type = _type;
@synthesize flowID = _flowID;
@synthesize apps = _appsList;
@synthesize attitudeList = _attitudeList;
@synthesize status = _status;
@synthesize note = _note;
@synthesize statusNm = _statusNm;
@synthesize keyword = _keyword;
@synthesize source = _source;
@synthesize attLsList = _attLsList;
@synthesize workLogList = _workLogList;
@synthesize auditor = _auditor;

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
    [_attitudeList release];
    [_status release];
    [_note release];
    [_statusNm release];
    [_keyword release];
    [_source release];
    [_attLsList release];
    [_workLogList release];
    [_auditor release];
     
    _auditor = nil;
    _keyword = nil;
    _conid = nil;
    _level = nil;
    _time = nil;
    _title = nil;
    _type = nil;
    _flowID = nil;
    _appsList = nil;
    _attitudeList = nil;
    _status = nil;
    _note = nil;
    _statusNm = nil;
    _source = nil;
    _attLsList = nil;
    _workLogList = nil;
    
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
