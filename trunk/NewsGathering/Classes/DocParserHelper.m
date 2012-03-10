//
//  DocParserHelper.m
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DocParserHelper.h"

#import "Contants.h"

@implementation DocParserHelper

@synthesize delegate = _delegate;

- (void)dealloc {

    [_xmlParser release];
    [_currentValue release];
    [_docList release];
    [_info release];
    
    _xmlParser = nil;
    _currentValue = nil;
    _docList = nil;
    _info = nil;
    
    [super dealloc];
    
}

#pragma -
#pragma Public Methods.

- (void)startWithXMLInfo:(NSString *)xmlInfo flag:(int)flag {
    
    if(xmlInfo == nil || [xmlInfo length] < 1) {
        
        return;
    }
    
    _docList = nil;
    _appsList = nil;
    _attitudeList = nil;
    _info = nil;
    _workflowList = nil;
    _workflowInfo = nil;
    _attLsInfo = nil;
    _attLsList = nil;
    
    _currentFlag = flag;
    
    if(_xmlParser != nil) {
        
        [_xmlParser release];
        _xmlParser = nil;
    }
    
    NSLog(@"%d \r %@", flag, xmlInfo);
    
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
    

    if([elementName isEqualToString:@"contris"]) {
        
//        if(_docList != nil) {
//        
//            [_docList release];
//            _docList = nil;
//        }
        _docList = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"contri"] 
             || [elementName isEqualToString:@"error"] 
             || [elementName isEqualToString:@"contribution"]) {
        
//        if(_info != nil) {
//        
//            [_info release];
//            _info = nil;
//        }
        
        _info = [[ContributeInfo alloc] init];
        _attLsList = [[NSMutableArray alloc] initWithCapacity:0];
        _workLogList = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"apps"]) {
    
//        if(_appsList != nil) {
//        
//            [_appsList release];
//            _appsList  = nil;
//        }
//        
//        _appsList = [[NSMutableArray alloc] initWithCapacity:0];
        
        _attitudeList = [[NSMutableArray alloc] initWithCapacity:0];
        
    }else if([elementName isEqualToString:@"WorkFlowList"]) {
    
        _workflowList = [[NSMutableArray alloc] initWithCapacity:0];
    }else if([elementName isEqualToString:@"wfls"]) {
    
        _workflowInfo = [[WorkflowInfo alloc] init];
    }else if([elementName isEqualToString:@"attLs"]) {
    
        _attLsInfo = [[AttLsInfo alloc] init];
    }else if([elementName isEqualToString:@"workLogs"]) {
    
        _workLogInfo = [[WorkLog alloc] init];
    }
    
    _currentValue = [[NSMutableString alloc] initWithCapacity:0];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    [_currentValue appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
                                      namespaceURI:(NSString *)namespaceURI 
                                     qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"flag"]) {
    
        _info.flag = _currentValue;
    }else if([elementName isEqualToString:@"message"]) {
    
        _info.message = _currentValue;
    }else if([elementName isEqualToString:@"error"]) {
        
        if(_currentFlag == kFlag_Contri_Get_Cycle_List) {
        
            if(_delegate != nil && [_delegate respondsToSelector:@selector(getCycleListDidFinished:)]) {
                
                [_delegate getCycleListDidFinished:[NSArray array]];
            }
            
        }
        
        if(_currentFlag == kFlag_Contri_Get_Complet_List) {
            
            if(_delegate != nil && [_delegate respondsToSelector:@selector(getCompleteListDidFinished:)]) {
                
                [_delegate getCompleteListDidFinished:[NSArray array]];
            }
            
        }        

        SEL sel = nil;
        
        if(_currentFlag == kFlag_Contri_Add) {
            
            sel = @selector(addDocDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Update) {
        
            sel = @selector(updateDocDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Delete) {
            
            sel = @selector(deleteDocDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Submit) {
            
            sel = @selector(submitDocDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Resume) {
            
            sel = @selector(resumeDocDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Remove) {
            
            sel = @selector(removeDocDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Add_Approve) {
        
            sel = @selector(addDocForApproveDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Approve) {
        
            sel = @selector(approveDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Send_Weibo) {
        
            sel = @selector(sendWeiboDidFinished:);
        }else if(_currentFlag == kFlag_Contri_Approve_Status) {
        
            sel = @selector(approveStatusDidFinished:);
        }else if(_currentFlag == KFlag_Contri_Delete_Attach) {
        
            sel = @selector(deleteAttachDidFinished:);
        }
        
        if(sel != nil) {
        
        if(_delegate != nil && [_delegate respondsToSelector:sel]) {
        
            [_delegate performSelector:sel withObject:[_info autorelease]];
        }
        }
        
    }else if([elementName isEqualToString:@"conid"]) {
        
        _info.conid = _currentValue;
    }else if([elementName isEqualToString:@"level"]) {
        if(_currentFlag == KFlag_Contri_Get_Workflow) {
        
            _workflowInfo.level = _currentValue;
        }else {
            
            _info.level = _currentValue;
        }
    }else if([elementName isEqualToString:@"keyword"]) {
        
        _info.keyword = _currentValue;
    }
    else if([elementName isEqualToString:@"time"]) {
        
        _info.time = _currentValue;
    }else if([elementName isEqualToString:@"title"]) {
        
        _info.title = _currentValue;
    }else if([elementName isEqualToString:@"status"]) {
        //
        
        if(_workLogInfo != nil) {
            _workLogInfo.status = _currentValue;
        }else {
        
        _info.status = _currentValue;
        }
    }else if([elementName isEqualToString:@"note"]) {
    
        _info.note = _currentValue;
    }else if([elementName isEqualToString:@"statusNm"]) {
    
        _info.statusNm = _currentValue;
    }else if([elementName isEqualToString:@"type"]) {
        
        _info.type = _currentValue;
    }else if([elementName isEqualToString:@"source"]){
        
        _info.source = _currentValue;
    }else if([elementName isEqualToString:@"contri"]) {
        
        [_docList addObject:_info];
        [_info release];
        _info = nil;
    }else if([elementName isEqualToString:@"contris"]) {
        
        SEL sel = nil;
        if(_currentFlag == kFlag_Contri_List) {
            
            sel = @selector(getDocListDidFinished:);
        }
        
        if(_currentFlag == kFlag_Contri_AppList) {
        
            sel = @selector(getAppListDidFinished:);
        }
        
        if(_currentFlag == kFlag_Contri_Get_Cycle_List) {
        
            sel = @selector(getCycleListDidFinished:);
        }
        
        if(_currentFlag == kFlag_Contri_Get_Complet_List) {
        
            sel = @selector(getCompleteListDidFinished:);
        }
        
        if(_delegate != nil && [_delegate respondsToSelector:sel]) {
            
            [_delegate performSelector:sel withObject:[_docList autorelease]];
        }
    }else if([elementName isEqualToString:@"contribution"]) {
        
        if(_delegate != nil && [_delegate respondsToSelector:@selector(getDocDetailDidFinished:)]) {
        
            [_delegate getDocDetailDidFinished:[_info autorelease]];
        }
    }else if([elementName isEqualToString:@"appId"]) {
    
//        [_appsList addObject:_currentValue];
    }else if([elementName isEqualToString:@"apps"]) {
    
//        _info.apps = _appsList;
//        [_appsList release];
//        _appsList = nil;
        _info.attitudeList = _attitudeList;
        [_attitudeList release];
        _attitudeList = nil;
    }else if([elementName isEqualToString:@"attitude"]) {
    
        [_attitudeList addObject:_currentValue];
    }else if([elementName isEqualToString:@"endstatus"]) {
    
        _workflowInfo.endStatus = _currentValue;
    }else if([elementName isEqualToString:@"flowid"]) {
    
        _workflowInfo.flowid = _currentValue;
    }else if([elementName isEqualToString:@"opttype"]) {
    
        _workflowInfo.opttype = _currentValue;
    }else if([elementName isEqualToString:@"remark"]) {
    
        _workflowInfo.remark = _currentValue;
    }else if([elementName isEqualToString:@"roleid"]) {
    
        _workflowInfo.roleid = _currentValue;
    }else if([elementName isEqualToString:@"begstatus"]) {
    
        _workflowInfo.begStatus = _currentValue;
    }else if([elementName isEqualToString:@"wfls"]) {
    
        [_workflowList addObject:_workflowInfo];
        [_workflowInfo release];
        _workflowInfo = nil;
    }else if([elementName isEqualToString:@"WorkFlowList"]) {
    
        SEL sel = nil;
        
        if(_currentFlag == KFlag_Contri_Get_Workflow) {
        
            sel = @selector(getWorkflowDidFinished:);
        }
        
        if(_currentFlag == kFlag_Contri_Get_Edit_List) {
        
            sel = @selector(getEditListDidFinished:);
        }
        
        if(_currentFlag == kFlag_Contri_Get_App_Workflow) {
        
            sel = @selector(getAppWorkflowDidFinished:);
        }
        
        if(_delegate != nil && [_delegate respondsToSelector:sel]) {
        
            [_delegate performSelector:sel withObject:[_workflowList autorelease]];
//            [_delegate getWorkflowDidFinished:[_workflowList autorelease]];
        }
    }else if([elementName isEqualToString:@"filename"]) {
    
        _attLsInfo.fileName = _currentValue;
    }else if([elementName isEqualToString:@"id"]) {
    
        _attLsInfo.attLsID = _currentValue;
    }else if([elementName isEqualToString:@"attLs"]) {
    
        [_attLsList addObject:_attLsInfo];
        [_attLsInfo release];
        _attLsInfo = nil;
        
        _info.attLsList = _attLsList;
    }else if([elementName isEqualToString:@"logid"]) {
    
        _workLogInfo.logID = _currentValue;
    }else if([elementName isEqualToString:@"recuseuserid"]) {
    
        _workLogInfo.recuseuserID = _currentValue;
    }else if([elementName isEqualToString:@"userid"]) {
    
        _workLogInfo.userID = _currentValue;
    }else if([elementName isEqualToString:@"workLogs"]) {
    
        [_workLogList addObject:_workLogInfo];
        [_workLogInfo release];
        _workLogInfo = nil;
        
        _info.workLogList = _workLogList;
    }
    
    [_currentValue release];
    _currentValue = nil;
}


@end
