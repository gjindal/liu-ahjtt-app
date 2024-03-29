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

-(void) didFinishedRequest:(NSData *)result{

    returnData = result;
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_List]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_List];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Detail]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Detail];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Add]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Add];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Add_Approve]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Add_Approve];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Update]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Update];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Delete]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Delete];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Submit]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Submit];
            [returnString release];
        }
    }    
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Resume]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Resume];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Remove]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Remove];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_AppList]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_AppList];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Approve]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Approve];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Get_App_Workflow ]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Get_App_Workflow];
            [returnString release];
        }   
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Get_Workflow] ) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:KFlag_Contri_Get_Workflow];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Download] ) {

    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Get_Cycle_List] ) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Get_Cycle_List];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Get_Edit_List] ) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Get_Edit_List];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Send_Weibo] ) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Send_Weibo];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Approve_Status ]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Approve_Status];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:KInterface_Contri_Delete_Attach] ) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog(@"-----%@",returnString);
            [_parser startWithXMLInfo:returnString flag:KFlag_Contri_Delete_Attach];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:KInterface_Contri_Get_Complet_List] ) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_Get_Complet_List];
            [returnString release];
        }
    }
    if ([netRequest.strRequestType isEqualToString:kInterface_Contri_Upload]) {
        if(returnData != nil) {
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString flag:kFlag_Contri_UploadFile];
            [returnString release];
        }
    }
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
    
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_List withRequestString:post];

}

- (void)getDocDetailWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    NSLog(@"%@===========%@",kInterface_Contri_Detail,post);
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Detail withRequestString:post];

}

- (void)addDocWithTitle:(NSString *)title Keyword:(NSString *)keyword
                   Note:(NSString *)note Source:(NSString *)source
                   Type:(NSString *)type Level:(NSString *)level
                 FlowID:(NSString *)flowID
                 Status:(NSString *)status
                  ConID:(NSString *)conid{
    
    assert((status != nil)&&([status length]>0));
    assert((title != nil)&&([title length]>0));
    assert((level != nil)&&([level length]>0));

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&source=%@&type=%@&level=%@&flowid=%@&status=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, note, source, type, level, flowID,status,conid];
    
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Add withRequestString:post];

}

- (void)addDocForApproveWithTitle:(NSString *)title Keyword:(NSString *)keyword
                             Note:(NSString *)note Source:(NSString *)source
                             Type:(NSString *)type Level:(NSString *)level
                           FlowID:(NSString *)flowID Receptuserid:(NSString *)receptuserid
                           Status:(NSString *)status 
                            ConID:(NSString *)conid{
    
    assert((flowID != nil) && ([flowID length]>0));
    assert((status != nil)&&([status length]>0));
    assert((title != nil)&&([title length]>0));
    assert((level != nil)&&([level length]>0));
                                
                                
    NSString *post = [NSString stringWithFormat:
                      @"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&source=%@&type=%@&level=%@&flowid=%@&receptuserid=%@&status=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, note, source, type, level, flowID, receptuserid,status,conid];
    
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    
    NSData *returnData = [netRequest PostData:kInterface_Contri_Add_Approve withRequestString:post];

}

- (void)updateDocWithTitle:(NSString *)title Keyword:(NSString *)keyword
                      Note:(NSString *)note Source:(NSString *)source
                      Type:(NSString *)type Level:(NSString *)level
                     Conid:(NSString *)conid {
    
    assert((conid != nil)&&([conid length]>0));
    assert((title != nil)&&([title length]>0));
    assert((level != nil)&&([level length]>0));
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&source=%@&type=%@&level=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, note, source, type, level, conid];
    
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Update withRequestString:post];

}

- (void)deleteDocWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Delete withRequestString:post];

}

- (void)submitDocWithConid:(NSString *)conid Receptuserid:(NSString *)receptuserid
                    Status:(NSString *)status {

    assert((conid != nil)&&([conid length]>0));
    assert((status != nil)&&([status length]>0));

    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@&receptuserid=%@&status=%@",
                      [UserHelper userName], [UserHelper password], conid, receptuserid, status];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Submit withRequestString:post];

}

- (void)resumeDocWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Resume withRequestString:post];

}

- (void)removeDocWithConid:(NSString *)conid {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@",
                      [UserHelper userName], [UserHelper password], conid];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Remove withRequestString:post];

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
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_AppList withRequestString:post];

}

- (void)approveWithConid:(NSString *)conid Attitude:(NSString *)attitude Status:(NSString *)status LogID:(NSString *)logid{

    
    assert((logid != nil) && ([logid length]>0));
    assert((status != nil)&&([status length]>0));
    assert((conid != nil)&&([conid length]>0));
    
    if(attitude == nil) {
        attitude = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&conid=%@&attitude=%@&status=%@&logid=%@",
                      [UserHelper userName], [UserHelper password], conid, attitude, status,logid];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Approve withRequestString:post];

}

- (void)getAppWorkflowWithLevel:(NSString *)level Status:(NSString *)status {
    

    assert((status != nil)&&([status length]>0));
    assert((level != nil)&&([level length]>0));

    if(level == nil) {
        level = @"";
    }
    
    if(status == nil) {
        status = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&level=%@&status=%@",level, status];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Get_App_Workflow withRequestString:post];

}

- (void)getWorkflowWithLevel:(NSString *)level {

    NSString *post = [NSString stringWithFormat:@"&level=%@", level];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Get_Workflow withRequestString:post];

}


- (NSData *)dowloadAttachWithID:(NSString *)ID{
    NSString *post = [NSString stringWithFormat:@"&id=%@", ID];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Download withRequestString:post];
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
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Get_Cycle_List withRequestString:post];

}

- (void)getEditListWithLevel:(NSString *)level {

    if(level == nil) {
        level = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&level=%@",
                      [UserHelper userName], [UserHelper password], level];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Get_Edit_List withRequestString:post];

}

- (void)sendWeiboWithType:(NSString *)type Note:(NSString *)note FilePath:(NSString *)filePath {

    assert((type != nil)&&([type length]>0));
    assert((note != nil)&&([note length]>0));
    
    if(filePath == nil) {
        filePath = @"";
    }
    
    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&type=%@&note=%@&filepath=%@",
                      [UserHelper userName], [UserHelper password], type, note, filePath];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Send_Weibo withRequestString:post];

}

- (void)ApproveStatusWithLogID:(NSString *)logID Status:(NSString *)status 
                      Attitude:(NSString *)attitude Conid:(NSString *)conid
                  RecuseuserID:(NSString *)recuseuserID {
    
    assert((conid != nil)&&([conid length]>0));
    assert((status != nil)&&([status length]>0));
    //assert((recuseuserID != nil)&&([recuseuserID length]>0));


    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&logid=%@&status=%@&attitude=%@&conid=%@&recuseuserid=%@",
                      [UserHelper userName], [UserHelper password], logID, status, attitude, conid, recuseuserID];
    NSLog(@"=============%@",post);
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Approve_Status withRequestString:post];

}
- (void)deleteAttachWithID:(NSString *)flowID {

    NSString *post = [NSString stringWithFormat:@"&usercode=%@&password=%@&id=%@",
                      [UserHelper userName], [UserHelper password], flowID];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:KInterface_Contri_Delete_Attach withRequestString:post];

}

- (void)getCompleteListWithTitle:(NSString *)title Keyword:(NSString *)keyword
                         Begtime:(NSString *)begtime Endtime:(NSString *)endtime
                            Type:(NSString *)type Page:(NSString *)page
                              rp:(NSString *)rp sortName:(NSString *)sortName {

    if(title == nil) {
        title = @"";
    }
    if(keyword == nil) {
        keyword = @"";
    }
    if(begtime == nil) {
        begtime = @"";
    }
    if(endtime == nil) {
        endtime = @"";
    }
    if(type == nil) {
        type = @"";
    }
    
    NSString *post = [NSString stringWithFormat:
                      @"&usercode=%@&password=%@&title=%@&keyword=%@&begtime=%@&endtime=%@&type=%@&page=%@&rp=%@&sortName=%@",
                      [UserHelper userName], [UserHelper password], title, keyword, begtime, endtime, type, page, rp, sortName];
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:KInterface_Contri_Get_Complet_List withRequestString:post];

}

- (void)uploadFileWithFlowID:(NSString *)flowID FileName:(NSString *)filename {

    if(flowID == nil) {
        flowID = @"";
    }
    
    if(filename == nil) {
        filename = @"";
    }
    
    NSString *post = [NSString stringWithFormat:
                      @"&usercode=%@&password=%@&flowid=%@&filename=%@",
                      [UserHelper userName], [UserHelper password], flowID, filename];
    NSLog(@"-------%@",post);
    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_Contri_Upload withRequestString:post];

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

    NSLog(@"----%d", receivedData.length);
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

- (void)uploadFileDidFinished:(ContributeInfo *)contributeInfo{
    if(_delegate != nil && [_delegate respondsToSelector:@selector(uploadFileDidFinished:)]) {
        [_delegate uploadFileDidFinished:contributeInfo];
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

- (void)approveStatusDidFinished:(ContributeInfo *)contributeInfo {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(approveStatusDidFinished:)]) {
        [_delegate approveStatusDidFinished:contributeInfo];
    }
}

- (void)deleteAttachDidFinished:(ContributeInfo *)contributeInfo {
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(deleteAttachDidFinished:)]) {
        [_delegate deleteAttachDidFinished:contributeInfo];
    }
}

- (void)getCompleteListDidFinished:(NSArray *)docList {
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(getCompleteListDidFinished:)]) {
        [_delegate getCompleteListDidFinished:docList];
    }
}

@end
