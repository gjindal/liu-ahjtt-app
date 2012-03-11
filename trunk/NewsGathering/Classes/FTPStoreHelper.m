//
//  FTPStoreHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FTPStoreHelper.h"

#import "DocFTPInfo.h"

@implementation FTPStoreHelper

#define kFTPFile [_baseDirectory stringByAppendingPathComponent:@"FTPFile"]

- (id)init {

    self = [super init];
    
    if(self != nil) {
    
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        _baseDirectory = [[NSString stringWithFormat:@"%@/StoreMedia", [paths objectAtIndex:0]] retain];
        
        // Check if the directory already exists
        if (![[NSFileManager defaultManager] fileExistsAtPath:_baseDirectory]) {
            // Directory does not exist so create it
            [[NSFileManager defaultManager] createDirectoryAtPath:_baseDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        _DocList = [NSKeyedUnarchiver unarchiveObjectWithFile:kFTPFile];
        if(_DocList == nil) {
            _DocList = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    
    return self;
}

- (void)dealloc {

    [_DocList release];
    [_baseDirectory release];
    
    _DocList = nil;
    _baseDirectory = nil;
    
    [super dealloc];
}

#pragma -
#pragma Public Methods.

- (DocFTPInfo *)getDocFTPWithFlowID:(NSString *)flowID {

    assert(flowID != nil);
    
    DocFTPInfo *temp = nil;
    for (DocFTPInfo *docFTPInfo in _DocList) {
        if([flowID isEqualToString:docFTPInfo.flowID])
            temp = docFTPInfo;
    }
    
    return temp;
}

- (BOOL)Insert:(DocFTPInfo *)ftpInfo {
    
    assert(ftpInfo != nil);
    assert(_DocList != nil);
    
    [_DocList addObject:ftpInfo];
    BOOL result = [NSKeyedArchiver archiveRootObject:_DocList toFile:kFTPFile];
    return  result;
}

- (BOOL)Delete:(NSString *)flowID {

    assert(flowID != nil);
    assert(_DocList != nil);
    
    BOOL result = NO;
    DocFTPInfo *temp = nil;
    for (DocFTPInfo *ftpInfo in _DocList) {
        if([flowID isEqualToString:ftpInfo.flowID])
            temp = ftpInfo;
    }
    
    if(temp != nil) {
    
        [_DocList removeObject:temp];
        result = [NSKeyedArchiver archiveRootObject:_DocList toFile:kFTPFile];
    }
    return result;
}


@end
