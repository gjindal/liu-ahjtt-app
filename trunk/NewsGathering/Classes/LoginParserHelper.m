//
//  LoginParserHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginParserHelper.h"
#import "LoginResultInfo.h"

@implementation LoginParserHelper

@synthesize delegate = _delegate;

#pragma -
#pragma Public Methods.

- (void)startWithString:(NSString *)xmlInfo {

    if(xmlInfo == nil || [xmlInfo length] < 1) {
    
        return;
    }
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[xmlInfo dataUsingEncoding:NSUTF8StringEncoding]];
    _xmlParser.delegate = self;
    [_xmlParser parse];
}

#pragma -
#pragma NSXMLParserDelegate Methods.

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSLog(@"Error: %@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
                                        namespaceURI:(NSString *)namespaceURI 
                                       qualifiedName:(NSString *)qName 
                                          attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"error"]) {
    
        _loginResultInfo = [[LoginResultInfo alloc] init];
        _loginResultInfo.isLoginSuccess = NO;
    }else if([elementName isEqualToString:@"user"]) {
    
        _loginResultInfo = [[LoginResultInfo alloc] init];
        _loginResultInfo.isLoginSuccess = YES;
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
    if([elementName isEqualToString:@"flag"]) {
    
        _loginResultInfo.flag = [_currentValue intValue];
    }else if([elementName isEqualToString:@"message"]) {
    
        _loginResultInfo.message = _currentValue;
    }else if([elementName isEqualToString:@"error"] || [elementName isEqualToString:@"user"]) {
    
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDidFinished:)]) {
            
            [_delegate parserDidFinished:_loginResultInfo];
        }
    }
}

- (void)dealloc {

    [_xmlParser release];
    [_currentValue release];
    [_loginResultInfo release];
    [_currentValue release];
    
    _xmlParser = nil;
    _currentValue = nil;
    _loginResultInfo = nil;
    _currentValue = nil;
    
    [super dealloc];
}

@end
