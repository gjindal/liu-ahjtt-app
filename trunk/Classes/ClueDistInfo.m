//
//  ClueDistInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClueDistInfo.h"

@implementation ClueDistInfo

@synthesize begtimeshow = _begtimeshow;
@synthesize endtimeshow = _endtimeshow;
@synthesize keyid = _keyid;
@synthesize keyword = _keyword;
@synthesize note = _note;
@synthesize sendUserName = _sendUserName;
@synthesize status = _status;
@synthesize title = _title;
@synthesize type = _type;

- (void)dealloc {

    [_begtimeshow release];
    [_endtimeshow release];
    [_keyid release];
    [_keyword release];
    [_note release];
    [_sendUserName release];
    [_status release];
    [_title release];
    [_type release];
    
    _begtimeshow = nil;
    _endtimeshow = nil;
    _keyid = nil;
    _keyword = nil;
    _note = nil;
    _sendUserName = nil;
    _status = nil;
    _title = nil;
    _type = nil;
    
    [super dealloc];
}

@end
