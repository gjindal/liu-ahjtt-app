//
//  NewClueParserHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsClueParserHelper.h"

@implementation NewsClueParserHelper

@synthesize delegate = _delegate;

- (void)dealloc {

    [_xmlParser release];
    [_currentValue release];
    [_info release];
    [_array release];
    
    _xmlParser = nil;
    _currentValue = nil;
    _info = nil;
    _array = nil;
    
    [super dealloc];
}

#pragma -
#pragma Public Methods.

- (void)startWithXMLInfo:(NSString *)xmlInfo {

    if(xmlInfo == nil || [xmlInfo length] < 1) {
        
        return;
    }
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[xmlInfo dataUsingEncoding:NSUTF8StringEncoding]];
    _xmlParser.delegate = self;
    [_xmlParser parse];
}

#pragma -
#pragma NSXMLParserDelegate Support.

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
                                        namespaceURI:(NSString *)namespaceURI 
                                       qualifiedName:(NSString *)qName 
                                          attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"keylist"]) {
    
        _array = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"key"]) {
    
        _info = [[NewsClueInfo alloc] init];
    }
    
    _currentValue = [[NSMutableString alloc] initWithCapacity:0];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    [_currentValue appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
                                      namespaceURI:(NSString *)namespaceURI 
                                     qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"begtimeshow"]) {
    
        _info.begtimeshow = _currentValue;
    }else if([elementName isEqualToString:@"keyid"]) {
    
        _info.keyid = _currentValue;
    }else if([elementName isEqualToString:@"status"]) {
    
        _info.status = _currentValue;
    }else if([elementName isEqualToString:@"title"]) {
    
        _info.title = _currentValue;
    }else if([elementName isEqualToString:@"key"]) {
    
        [_array addObject:_info];
        [_info release];
        _info = nil;
    }else if([elementName isEqualToString:@"keylist"]) {
    
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDidFinished:)]) {
        
            [_delegate parserDidFinished:_array];
        }
    }
    
    [_currentValue release];
    _currentValue = nil;
    
}

@end
