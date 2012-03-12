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
    
        _loginSuccessInfo = [[LoginSuccessInfo alloc] init];
        _loginSuccessInfo.isLoginSuccess = YES;
        _dictList = [[NSMutableArray alloc] initWithCapacity:0];
        _menuList = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"dictList"]) {
        
        _dictInfo = [[DirtInfo alloc] init];
    }else if([elementName isEqualToString:@"menuList"]) {
        
        _menuInfo = [[MenuInfo alloc] init];
    }else if([elementName isEqualToString:@"funcs"]) {
        
        _funcationInfo = [[FuncationInfo alloc] init];
    }else if([elementName isEqualToString:@"ftp"]){
        _ftpInfo = [[FTPInfo alloc] init];
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
    }else if([elementName isEqualToString:@"dic_desc"]) {
        _dictInfo.dic_desc = _currentValue;
    }else if([elementName isEqualToString:@"dic_key"]) {
        _dictInfo.dic_key = _currentValue;
    }else if([elementName isEqualToString:@"dic_type"]) {
        _dictInfo.dic_type = _currentValue;
    }else if([elementName isEqualToString:@"dic_value"]) {
        _dictInfo.dic_value = _currentValue;
    }else if([elementName isEqualToString:@"dictList"]) {
        [_dictList addObject:_dictInfo];
        [_dictInfo release];
        _dictInfo = nil;
    }else if([elementName isEqualToString:@"linkURL"]) {
        _menuInfo.linkURL = _currentValue;
    }else if([elementName isEqualToString:@"nodeCode"]) {
        _menuInfo.nodeCode = _currentValue;
    }else if([elementName isEqualToString:@"nodeName"]) {
        _menuInfo.nodeName = _currentValue;
    }else if([elementName isEqualToString:@"viewSec"]) {
        _menuInfo.viewSec = _currentValue;
    }else if([elementName isEqualToString:@"functionCode"]) {
        _funcationInfo.funcationCode = _currentValue;
    }else if([elementName isEqualToString:@"functionName"]) {
        _funcationInfo.funcationName = _currentValue;
    }else if([elementName isEqualToString:@"id"]) {
        if(_funcationInfo != nil) {
        
            [_funcationInfo setId:_currentValue];
        }else {
        
            [_loginSuccessInfo setId:_currentValue];
        }
    }else if([elementName isEqualToString:@"funcs"]) {
        [_menuInfo.funcs addObject:_funcationInfo];
        [_funcationInfo release];
        _funcationInfo = nil;
    }else if([elementName isEqualToString:@"menuList"]) {
        [_menuList addObject:_menuInfo];
        [_menuInfo release];
        _menuInfo = nil;
    }else if([elementName isEqualToString:@"roleName"]) {
        _loginSuccessInfo.roleName = _currentValue;
    }else if([elementName isEqualToString:@"sex"]) {
        _loginSuccessInfo.sex = _currentValue;
    }else if([elementName isEqualToString:@"ftppassword"]) {
        _ftpInfo.ftpPassword = _currentValue;
    }else if([elementName isEqualToString:@"ftpuser"]) {
        _ftpInfo.ftpUsername = _currentValue;
    }else if([elementName isEqualToString:@"ftpurl"]) {
        _ftpInfo.ftpURL = _currentValue;
    }else if([elementName isEqualToString:@"ftp"]) {
        [_loginSuccessInfo setFtpInfo:_ftpInfo];
        [_ftpInfo release];
        _ftpInfo = nil;
    }
    else if([elementName isEqualToString:@"userName"]) {
        _loginSuccessInfo.userName = _currentValue;
    }else if([elementName isEqualToString:@"error"]) {
    
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDidFinished:)]) {
            
            [_delegate parserDidFinished:_loginResultInfo];
        }
    }else if([elementName isEqualToString:@"user"]) {
    
        _loginSuccessInfo.dictList = _dictList;
        _loginSuccessInfo.menuList = _menuList;
        
        [_dictList release];
        [_menuList release];
        _dictList = nil;
        _menuList = nil;
        
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDidFinished:)]) {
            
            [_delegate parserDidFinished:_loginSuccessInfo];
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
