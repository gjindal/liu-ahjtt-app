//
//  DocRequest.m
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DocRequest.h"

#import "UserHelper.h"

@implementation DocRequest

@synthesize delegate = _delegate;

- (id)init {

    self = [super init];
    if(self != nil) {
    
        _parser = [[DocParserHelper alloc] init];
        _parser.delegate = self;
    }
    return self;
}

- (void)dealloc {

    [_parser release];
    
    _parser = nil;
    
    [super dealloc];
}

#pragma -
#pragma Public Methods.

- (void)getDocListWithTitle:(NSString *)title Keyword:(NSString *)keyword 
                       Type:(NSString *)type Begtime:(NSString *)begtime
                    Endtime:(NSString *)endtime {

    if(title == nil) {
        title = @"";
    }
    
    if(keyword == nil) {
        keyword = @"";
    }
    
    if(type == nil) {
        type = @"";
    }
    
    if(begtime == nil) {
        begtime = @"";
    }
    
    if(endtime == nil) {
        endtime = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&type=%@&begtime=%@&endtime=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, type, begtime, endtime];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_List withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_List];
        [returnString release];
    }
}

- (void)getDocDetailWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Detail withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Detail];
        [returnString release];
    }
}

- (void)addDocWithTitle:(NSString *)title Keyword:(NSString *)keyword
                   Note:(NSString *)note Source:(NSString *)source
                   Type:(NSString *)type Level:(NSString *)level
                 FlowID:(NSString *)flowID {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&source=%@&type=%@&level=%@&flowid=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, note, source, type, level, flowID];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Add withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Add];
        [returnString release];
    }
}

- (void)updateDocWithTitle:(NSString *)title Keyword:(NSString *)keyword
                      Note:(NSString *)note Source:(NSString *)source
                      Type:(NSString *)type Level:(NSString *)level
                     Conid:(NSString *)conid {
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&source=%@&type=%@&level=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, note, source, type, level, conid];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Update withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Update];
        [returnString release];
    }
}

- (void)deleteDocWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Delete withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Delete];
        [returnString release];
    }
}

- (void)submitDocWithConid:(NSString *)conid Receptuserid:(NSString *)receptuserid
                    Status:(NSString *)status {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@&receptuserid=%@&status=%@",
                      [UserHelper userName], [UserHelper password], conid, receptuserid, status];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Submit withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Submit];
        [returnString release];
    }
}

- (void)resumeDocWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Resume withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Resume];
        [returnString release];
    }
}

- (void)removeDocWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Remove withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Remove];
        [returnString release];
    }
}

- (void)getAppListWithTitle:(NSString *)title Keyword:(NSString *)keyword
                       Type:(NSString *)type Begtime:(NSString *)begtime
                    Endtime:(NSString *)endtime {

    if(title == nil) {
        title = @"";
    }
    
    if(keyword == nil) {
        keyword = @"";
    }
    
    if(type == nil) {
        type = @"";
    }
    
    if(begtime == nil) {
        begtime = @"";
    }
    
    if(endtime == nil) {
        endtime = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&type=%@&begtime=%@&endtime=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, type, begtime, endtime];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_AppList withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_AppList];
        [returnString release];
    }
}

- (void)approveWithConid:(NSString *)conid Apps:(NSString *)apps {

    if(apps == nil) {
        apps = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@&apps=%@",
                      [UserHelper userName], [UserHelper password], conid, apps];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Remove withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Remove];
        [returnString release];
    }
}

- (void)uploadFileWithFlowID:(NSString *)flowID Apps:(NSString *)apps FileName:(NSString *)fileName {

    
}

#pragma -
#pragma DocParserHelperDelegate Support.

- (void)getDocListDidFinished:(NSArray *)docList {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(getDocListDidFinished:)]) {
        [_delegate getDocListDidFinished:docList];
    }
}

- (void)getDocDetailDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(getDocDetailDidFinished:)]) {
        [_delegate getDocDetailDidFinished:contributeInfo];
    }
}

- (void)addDocDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(addDocDidFinished:)]) {
        [_delegate addDocDidFinished:contributeInfo];
    }
}

- (void)updateDocDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(updateDocDidFinished:)]) {
        [_delegate updateDocDidFinished:contributeInfo];
    }
}

- (void)deleteDocDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(deleteDocDidFinished:)]) {
        [_delegate deleteDocDidFinished:contributeInfo];
    }
}

- (void)submitDocDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(submitDocDidFinished:)]) {
        [_delegate submitDocDidFinished:contributeInfo];
    }
}

- (void)resumeDocDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(resumeDocDidFinished:)]) {
        [_delegate resumeDocDidFinished:contributeInfo];
    }
}

- (void)removeDocDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(removeDocDidFinished:)]) {
        [_delegate removeDocDidFinished:contributeInfo];
    }
}

- (void)getAppListDidFinished:(NSArray *)docList {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(getAppListDidFinished:)]) {
        [_delegate getAppListDidFinished:docList];
    }
}

- (void)approveDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(approveDidFinished:)]) {
        [_delegate approveDidFinished:contributeInfo];
    }
}

@end
