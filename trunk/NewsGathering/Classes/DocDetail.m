//
//  DocDetail.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DocDetail.h"

@interface DocDetail (PrivateMethods)

- (NSString *)getUUID;

@end

@implementation DocDetail

@synthesize UUID        = _UUID;
@synthesize title       = _title;
@synthesize docType     = _docType;
@synthesize key         = _key;
@synthesize source      = _source;
@synthesize content     = _content;
@synthesize attachments = _attachments;

- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_UUID forKey:@"UUID"];
    [coder encodeObject:_title forKey:@"Title"];
    [coder encodeObject:_docType forKey:@"DocType"];
    [coder encodeObject:_key forKey:@"Key"];
    [coder encodeObject:_source forKey:@"Source"];
    [coder encodeObject:_content forKey:@"Content"];
    [coder encodeObject:_attachments forKey:@"Attachments"];
}

- (id)init {

    self = [super init];
    if(self != nil) {
    
        _UUID = [[self getUUID] retain];
    }
    
    return  self;
}

- (id)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    
    if(self != nil) {
    
        [_UUID release];
        _UUID = nil;
        
        _UUID       = [[coder decodeObjectForKey:@"UUID"] retain];
        _title      = [[coder decodeObjectForKey:@"Title"] retain];
        _docType    = [[coder decodeObjectForKey:@"DocType"] retain];
        _key        = [[coder decodeObjectForKey:@"Key"] retain];
        _source     = [[coder decodeObjectForKey:@"Source"] retain];
        _content    = [[coder decodeObjectForKey:@"Content"] retain];
        _attachments= [[coder decodeObjectForKey:@"Attachments"] retain];
    }
    
    return self;
}

- (void)dealloc {

    [_UUID release];
    [_title release];
    [_docType release];
    [_key release];
    [_source release];
    [_content release];
    [_attachments release];
    
    _UUID = nil;
    _title = nil;
    _docType = nil;
    _key = nil;
    _source = nil;
    _content = nil;
    _attachments = nil;
    
    [super dealloc];
}

#pragma -
#pragma Private Methods.

- (NSString *)getUUID {
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    return [(NSString *)string autorelease];
}

@end
