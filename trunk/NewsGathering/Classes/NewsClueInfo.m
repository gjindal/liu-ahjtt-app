//
//  NewsClueInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsClueInfo.h"

@implementation NewsClueInfo

@synthesize keyid = _keyID;
@synthesize title = _title;
@synthesize keyword = _keyword;
@synthesize status = _status;
@synthesize note = _note;
@synthesize type = _type;
@synthesize begtimeshow = _begTimeShow;
@synthesize endtimeshow = _endTimeShow;

@synthesize flag = _flag;
@synthesize message = _message;

- (void)dealloc {
    
    [_keyID release];
    [_title release];
    [_keyword release];
    [_status release];
    [_note release];
    [_type release];
    [_begTimeShow release];
    [_endTimeShow release];
    [_flag release];
    [_message release];
    
    _keyID = nil;
    _title = nil;
    _keyword = nil;
    _status = nil;
    _note = nil;
    _type = nil;
    _begTimeShow = nil;
    _endTimeShow = nil;
    
    [super dealloc];
}

@end
