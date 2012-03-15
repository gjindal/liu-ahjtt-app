//
//  DeptParserHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeptParserHelper.h"

@implementation DeptParserHelper

@synthesize delegate = _delegate;

- (void)dealloc {

    [_xmlParser release];
    [_deptArray release];
    [_deptInfo release];
    [_currentValue release];
    
    _xmlParser = nil;
    _deptArray = nil;
    _deptInfo = nil;
    _currentValue = nil;
    
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

    if([elementName isEqualToString:@"org"]) {
    
        _deptArray = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"dept"]) {
    
        [_deptInfo release];
        _deptInfo = nil;
        _deptInfo = [[DeptInfo alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    [_currentValue release];
    _currentValue = nil;
    _currentValue = [string retain];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
                                      namespaceURI:(NSString *)namespaceURI 
                                     qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"deptID"]) {
    
        _deptInfo.deptID = _currentValue;
    }else if([elementName isEqualToString:@"deptName"]) {
    
        _deptInfo.deptName = _currentValue;
    }else if([elementName isEqualToString:@"parentID"]) {
    
        _deptInfo.parentID = _currentValue;
    }else if([elementName isEqualToString:@"dept"]) {
    
        [_deptArray addObject:_deptInfo];
    }else if([elementName isEqualToString:@"org"]) {
    
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDidFinished:)]) {
        
            [_delegate parserDidFinished:_deptArray];
        }
    }
}

@end
