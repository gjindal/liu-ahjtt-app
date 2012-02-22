//
//  NewsClueInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsClueInfo.h"

@implementation NewsClueInfo

@synthesize title = _title;
@synthesize keyid = _keyID;
@synthesize status = _status;
@synthesize begtimeshow = _begTimeShow;
@synthesize keword = _keyword;
@synthesize note = _note;

- (void)dealloc {

    [_title release];
    [_keyID release];
    [_status release];
    [_begTimeShow release];
    
    _title = nil;
    _keyID = nil;
    _status = nil;
    _begTimeShow = nil;
    
    [super dealloc];
}

@end
