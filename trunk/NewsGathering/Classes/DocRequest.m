//
//  DocRequest.m
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DocRequest.h"
#import "StorageHelper.h"

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
                 FlowID:(NSString *)flowID
                 Status:(NSString *)status
                  ConID:(NSString *)conid{

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&source=%@&type=%@&level=%@&flowid=%@&status=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, note, source, type, level, flowID,status,conid];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Add withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Add];
        [returnString release];
    }
}

- (void)addDocForApproveWithTitle:(NSString *)title Keyword:(NSString *)keyword
                             Note:(NSString *)note Source:(NSString *)source
                             Type:(NSString *)type Level:(NSString *)level
                           FlowID:(NSString *)flowID Receptuserid:(NSString *)receptuserid
                           Status:(NSString *)status 
                            ConID:(NSString *)conid
                            {
    NSString *post = [NSString stringWithFormat:
                      @"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&source=%@&type=%@&level=%@&flowid=%@&receptuserid=%@&status=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, note, source, type, level, flowID, receptuserid,status,conid];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Add_Approve withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Add_Approve];
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
    
//////////////////////////////
    
//    int gData0;
//    float gData1;
//    NSString *gData2;
    
   // StorageHelper *storeHelper = [[StorageHelper alloc] init];
    //NSData *reader = [NSData dataWithContentsOfFile:[storeHelper.baseDirectory stringByAppendingFormat:@"/%@",@"test.xml"]];
    //gData2 = [[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];
   // NSString *filePath = [storeHelper.baseDirectory stringByAppendingFormat:@"/%@",@"test.xml"];
   // NSString *textFileContents = [NSString stringWithContentsOfFile:filePath];
    /////////////////////
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&type=%@&begtime=%@&endtime=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, type, begtime, endtime];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_AppList withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_AppList];
        [returnString release];
    }
}

- (void)approveWithConid:(NSString *)conid Attitude:(NSString *)attitude Status:(NSString *)status{

    if(attitude == nil) {
        attitude = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@&attitude=%@&status=%@",
                      [UserHelper userName], [UserHelper password], conid, attitude, status];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Approve withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Approve];
        [returnString release];
    }
}

- (void)getAppWorkflowWithLevel:(NSString *)level Status:(NSString *)status {

    if(level == nil) {
        level = @"";
    }
    
    if(status == nil) {
        status = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&level=%@&status=%@",level, status];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Get_App_Workflow withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Get_App_Workflow];
        [returnString release];
    }
}

- (void)getWorkflowWithLevel:(NSString *)level {

    NSString *post = [NSString stringWithFormat:@"&level=%@", level];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Get_Workflow withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:KFlag_Contri_Get_Workflow];
        [returnString release];
    }
}


- (NSData *)dowloadAttachWithID:(NSString *)ID{
    NSString *post = [NSString stringWithFormat:@"&id=%@", ID];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Download withRequestString:post];
    return returnData;
}


- (void)getCycleListWithTitle:(NSString *)title Keyword:(NSString *)keyword 
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
    
    NSString *post = [NSString stringWithFormat:
                      @"&usercode=%@&password=%@&title=%@&keyword=%@&type=%@&begtime=%@&endtime=%@",
                      [UserHelper userName], [UserHelper password],title, keyword, type, begtime, endtime];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Get_Cycle_List withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Get_Cycle_List];
        [returnString release];
    }
}

- (void)getEditListWithLevel:(NSString *)level {

    if(level == nil) {
        level = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&level=%@",
                      [UserHelper userName], [UserHelper password], level];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Get_Edit_List withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Get_Edit_List];
        [returnString release];
    }
}

- (void)sendWeiboWithType:(NSString *)type Note:(NSString *)note FilePath:(NSString *)filePath {

    if(filePath == nil) {
        filePath = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&type=%@&note=%@&filepath=%@",
                      [UserHelper userName], [UserHelper password], type, note, filePath];
    NSData *returnData = [NetRequest PostData:kInterface_Contri_Send_Weibo withRequestString:post];
    if(returnData != nil) {
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Send_Weibo];
        [returnString release];
    }
}

#pragma mark - 
#pragma mark Download File
- (void) beginDownloadWithID:(NSString *)ID andFileName:(NSString *)fileName1 {
	NSString *string =[[NSString alloc]initWithFormat:@"%@?usercode=%@&password=%@&id=%@", kInterface_Contri_Download, [UserHelper userName], [UserHelper password], ID]; 
    fileName = [fileName1 copy];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    _urlConnection = [[NSURLConnection alloc]initWithRequest:request1 delegate:self];
    
    if(_urlConnection) {
        receivedData = [[NSMutableData data]retain];
    }
    else {
        NSLog(@"connection Faild");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    
    /*NSFileHandle *handle = [NSFileHandle      fileHandleForWritingAtPath:@"...."];
     [handle seekToEndOfFile];
     [handle writeData:data];
     [handle closeFile];
     [str release];*/
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [connection release];
    [receivedData release];
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(downloadDidFinished:)]) {
        
        [_delegate downloadDidFinished:NO];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [connection release];
    //NSFileManager *fileManager = [[NSFileManager alloc]init];
    StorageHelper *helper = [[StorageHelper alloc] init];

    BOOL result = NO;
    result = [helper createFileWithName:fileName data:receivedData];
    
    [helper release];
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(downloadDidFinished:)]) {
    
        [_delegate downloadDidFinished:result];
    }
    
    NSLog(@"connection Finished");
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

- (void)addDocForApproveDidFinished:(ContributeInfo *)contributeInfo {
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(addDocForApproveDidFinished:)]) {
        [_delegate addDocForApproveDidFinished:contributeInfo];
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

- (void)getAppWorkflowDidFinished:(NSArray *)workflowArray {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(getAppWorkflowDidFinished:)]) {
        [_delegate getAppWorkflowDidFinished:workflowArray];
    }
}

- (void)getWorkflowDidFinished:(NSArray *)workflowArray {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(getWorkflowDidFinished:)]) {
        [_delegate getWorkflowDidFinished:workflowArray];
    }
}

- (void)getCycleListDidFinished:(NSArray *)docList {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(getCycleListDidFinished:)]) {
        [_delegate getCycleListDidFinished:docList];
    }
}

- (void)getEditListDidFinished:(NSArray *)workflowArray {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(getEditListDidFinished:)]) {
        [_delegate getEditListDidFinished:workflowArray];
    }
}

- (void)sendWeiboDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(sendWeiboDidFinished:)]) {
        [_delegate sendWeiboDidFinished:contributeInfo];
    }
}

@end
