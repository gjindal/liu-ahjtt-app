//
//  FileFTPInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileFTPInfo.h"

@implementation FileFTPInfo

@synthesize ftpType = _ftpType;
@synthesize fileName = _fileName;
@synthesize completed = _Completed;

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeInt32:_ftpType forKey:@"FTPTYPE"];
    [coder encodeObject:_fileName forKey:@"FILENAME"];
    [coder encodeBool:_Completed forKey:@"COMPLETED"];
}

- (id)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    
    if(self != nil) {
        
        _ftpType = [coder decodeInt32ForKey:@"FTPTYPE"];
        _fileName = [[coder decodeObjectForKey:@"FILENAME"] retain];
        _Completed = [coder decodeBoolForKey:@"COMPLETED"];
    }
    
    return self;
}

- (void)dealloc {

    [_fileName release];
    
    _fileName = nil;
    
    [super dealloc];
}

@end
