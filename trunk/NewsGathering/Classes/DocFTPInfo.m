//
//  DocFTPInfo.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DocFTPInfo.h"

#import "FileFTPInfo.h"

@implementation DocFTPInfo

@synthesize flowID = _flowID;
@synthesize fileFTPList = _fileFTPList;

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_flowID forKey:@"FLOWID"];
    [coder encodeObject:_fileFTPList forKey:@"FILEFTPLIST"];
}

- (id)init {

    self = [self init];
    
    if(self != nil) {
    
        _fileFTPList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    
    if(self != nil) {
        
        _flowID = [[coder decodeObjectForKey:@"FLOWID"] retain];
        _fileFTPList = [[coder decodeObjectForKey:@"FILEFTPLIST"] retain];
    }
    
    return self;
}

- (FileFTPInfo *)getFileInfoWithFileName:(NSString *)fileName {

    assert(fileName != nil);
    assert(fileName.length > 0);
    assert(_fileFTPList != nil);
    
    FileFTPInfo *temp = nil;
    for (FileFTPInfo *ftpInfo in _fileFTPList) {
        if([fileName isEqualToString:ftpInfo.fileName])
            temp = ftpInfo;
    }
    
    return temp;
}

- (void)dealloc {

    [_flowID release];
    [_fileFTPList release];
    
    _flowID = nil;
    _fileFTPList = nil;
    
    [super dealloc];
}

@end
