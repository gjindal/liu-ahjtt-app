//
//  ClueDistRequest.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClueDistRequest.h"

#import "Contants.h"
#import "UserHelper.h"

@implementation ClueDistRequest

@synthesize delegate = _delegate;

- (id)init {

    self = [super init];
    if(self != nil) {
    
        _parser = [[ClueDistParserHelper alloc] init];
        _parser.delegate = self;
    }
    return self;
}

- (void)dealloc {

    [_parser release];
    _parser = nil;
    
    [super dealloc];
}

-(void) didFinishedRequest:(NSData *)result{

    NSData *returnData = result;
    
    if([netRequest.strRequestType isEqualToString:kInterface_ClueDist_Submit]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_ClueDist_Submit];
            [returnString release];
        }
    }else if([netRequest.strRequestType isEqualToString:kInterface_ClueDist_List]){
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_ClueDist_List];
            [returnString release];
        }
    }else if([netRequest.strRequestType isEqualToString:kInterface_ClueDist_Detail]){
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_ClueDist_Detail];
            [returnString release];
        }
    }else if([netRequest.strRequestType isEqualToString:kInterface_ClueDist_Dept]){
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_ClueDist_Dept];
            [returnString release];
        }
    }else if([netRequest.strRequestType isEqualToString:kInterface_ClueDist_User]){
    
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_ClueDist_User];
            [returnString release];
        }
    }
}

#pragma -
#pragma Public Methods.

- (void)getDispatchResult:(NSString *)keyid withUsers:(NSString *)users{
    if(keyid == nil) {
        keyid = @"";
    }
    if (users == nil) {
        users = @"";
    }
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@&userids=%@",[UserHelper userName],[UserHelper password],keyid,users,nil];
    
    
    if (netRequest != nil) {
        [netRequest release];
    }
    netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_ClueDist_Submit withRequestString:post];


}

- (void)getListWithTitle:(NSString *)title Keyword:(NSString *)keyword 
                    Note:(NSString *)note Status:(NSString *)status
                 BegTime:(NSString *)begtime EndTime:(NSString *)endtime
                    Type:(NSString *)type {

    if (title == nil) {
        title = @"";
    }
    if (keyword == nil) {
        keyword = @"";
    }
    if (note == nil) {
        note = @"";
    }
    if (status == nil) {
        status = @"";
    }
    if (begtime == nil) {
        begtime = @"";
    }
    if (endtime == nil) {
        endtime = @"";
    }
    if (type == nil) {
        type = @"";
    }
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&status=%@&begtime=%@&endtime=%@&type=%@",[UserHelper userName],[UserHelper password],title,keyword,note,status,begtime,endtime,type];
    if (netRequest != nil) {
        [netRequest release];
    }
        netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_ClueDist_List withRequestString:post];

}

- (void)getDetailWithKeyID:(NSString *)keyid {

    if(keyid == nil) {
        keyid = @"";
    }
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@",[UserHelper userName],[UserHelper password],keyid, nil];
    
    if (netRequest != nil) {
        [netRequest release];
    }
        netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_ClueDist_Detail withRequestString:post];

}

- (void)getDept {

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@", [UserHelper userName], [UserHelper password], nil];
    if (netRequest != nil) {
        [netRequest release];
    }
        netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_ClueDist_Dept withRequestString:post];

}

- (void)getUserWithDeptID:(NSString *)deptid {

    if(deptid == nil) {
        deptid = @"";
    }
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&deptid=%@", [UserHelper userName], [UserHelper password], deptid, nil];
   
    if (netRequest != nil) {
        [netRequest release];
    }
        netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_ClueDist_User withRequestString:post];

}

#pragma -
#pragma ClueDistParserHelperDelegate Support.

- (void)parserListDidFinished:(NSArray *)distList {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(parserListDidFinished:)]) {
        [_delegate parserListDidFinished:distList];
    }
}

- (void)parserDetailDidFinished:(ClueDistInfo *)clueDistInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDetailDidFinished:)]) {
        [_delegate parserDetailDidFinished:clueDistInfo];
    }
}

- (void)parserDeptDidFinished:(NSArray *)deptList {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(parserDeptDidFinished:)]) {
        [_delegate parserDeptDidFinished:deptList];
    }
}

- (void)parserUserDidFinished:(NSArray *)userList {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(parserUserDidFinished:)]) {
        [_delegate parserUserDidFinished:userList];
    }
}

- (void)parserSubmitDidFinished:(ResultInfo *)resultInfo{

    if(_delegate != nil && [_delegate respondsToSelector:@selector(parserSubmitDidFinished:)]) {
        [_delegate parserSubmitDidFinished:resultInfo];
    }
}
@end
