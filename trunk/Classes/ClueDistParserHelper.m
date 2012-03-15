//
//  ClueDistParserHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClueDistParserHelper.h"

@implementation ClueDistParserHelper

@synthesize delegate = _delegate;

- (void)dealloc {

    [_xmlParser release];
    [_currentValue release];
    [_userList release];
    [_distList release];
    [_deptList release];
    [_resultInfo release];
    
    _xmlParser = nil;
    _currentValue = nil;
    _userList = nil;
    _distList = nil;
    _deptList = nil;
    _resultInfo = nil;
    
    [super dealloc];
}

#pragma -
#pragma Public Methods.

- (void)startWithXMLInfo:(NSString *)xmlInfo flag:(int)flag {

    if(xmlInfo == nil || [xmlInfo length] < 1) {
        
        return;
    }
    
    _userList = nil;
    _distList = nil;
    _deptList = nil;
    _userInfo = nil;
    _distInfo = nil;
    _deptInfo = nil;
    
    _currentFlag = flag;
    
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
    
        _distList = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"key"]) {
    
        _distInfo = [[ClueDistInfo alloc] init];
    }else if([elementName isEqualToString:@"deptlist"]) {
    
        _deptList = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"dept"]) {
    
        _deptInfo = [[DeptInfo alloc] init];
    }else if([elementName isEqualToString:@"userlist"]) {
    
        _userList = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"user"]) {
    
        _userInfo = [[UserInfo alloc] init];
    }else if([elementName isEqualToString:@"error"]){
        _resultInfo = [[ResultInfo alloc]init];
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
        _distInfo.begtimeshow = _currentValue;
    }if([elementName isEqualToString:@"endtimeshow"]) {
        _distInfo.endtimeshow = _currentValue;
    }if([elementName isEqualToString:@"keyid"]) {
        _distInfo.keyid = _currentValue;
    }if([elementName isEqualToString:@"keyword"]) {
        _distInfo.keyword = _currentValue;
    }if([elementName isEqualToString:@"note"]) {
        _distInfo.note = _currentValue;
    }if([elementName isEqualToString:@"sendUserName"]) {
        _distInfo.sendUserName = _currentValue;
    }if([elementName isEqualToString:@"status"]) {
        _distInfo.status = _currentValue;
    }if([elementName isEqualToString:@"title"]) {
        _distInfo.title = _currentValue;
    }if([elementName isEqualToString:@"type"]) {
        _distInfo.type = _currentValue;
    }if([elementName isEqualToString:@"key"]) {
        
        if(_currentFlag == kFlag_ClueDist_List) {
        
            [_distList addObject:_distInfo];
            [_distInfo release];
            _distInfo = nil;
        }else if(_currentFlag == kFlag_ClueDist_Detail) {
        
            if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDetailDidFinished:)]) {
            
                [_delegate parserDetailDidFinished:[_distInfo autorelease]];
            }
        }
        
    }if([elementName isEqualToString:@"keylist"]) {
        
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserListDidFinished:)]) {
            
            [_delegate parserListDidFinished:[_distList autorelease]];
        }
    }if([elementName isEqualToString:@"deptID"]) {
        _deptInfo.deptID = _currentValue;
    }if([elementName isEqualToString:@"deptName"]) {
        _deptInfo.deptName = _currentValue;
    }if([elementName isEqualToString:@"parentID"]) {
        _deptInfo.parentID = _currentValue;
    }if([elementName isEqualToString:@"dept"]) {
        [_deptList addObject:_deptInfo];
        [_deptInfo release];
        _deptInfo = nil;
    }if([elementName isEqualToString:@"deptlist"]) {
        
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDeptDidFinished:)]) {
        
            [_delegate parserDeptDidFinished:[_deptList autorelease]];
        }
    }if([elementName isEqualToString:@"id"]) {
        _userInfo.userID = _currentValue;
    }if([elementName isEqualToString:@"userName"]) {
        _userInfo.userName = _currentValue;
        NSLog(@"+++++++++++%@",_userInfo.userName);
    }if([elementName isEqualToString:@"user"]) {
        [_userList addObject:_userInfo];
        [_userInfo release];
        _userInfo = nil;
    }if([elementName isEqualToString:@"userlist"]) {
        
        if(_delegate != nil && [_delegate respondsToSelector:@selector(parserUserDidFinished:)]) {
        
            [_delegate parserUserDidFinished:[_userList autorelease]];
        }
    }if ([elementName isEqualToString:@"flag"]) {
        _resultInfo.flag = _currentValue;
    }if ([elementName isEqualToString:@"message"]) {
        _resultInfo.message = _currentValue;
    }if ([elementName isEqualToString:@"error"]) {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(parserSubmitDidFinished:)]) {
            [_delegate parserSubmitDidFinished:[_resultInfo autorelease]];
        }
    }
    
    [_currentValue release];
    _currentValue = nil;
    
}

@end
