//
//  NewsClueRequest.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsClueRequest.h"
#import "MD5EncryptProcess.h"

@implementation NewsClueRequest

@synthesize delegate = _delegate;

- (id)init {

    self = [super init];
    if(self != nil) {
    
        
        _parser = [[NewsClueParserHelper alloc] init];
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
    
    if([netRequest.strRequestType isEqualToString:kInterface_NewsClue_List]){
        if(returnData != nil) {
            _currentFlag = kFlag_NewsClue_List;
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString];
            [returnString release];
        }
        return;
    }
    
    if([netRequest.strRequestType isEqualToString:kInterface_NewsClue_Detail]){
        if(returnData != nil) {
            
            _currentFlag = kFlag_NewsClue_Detail;
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString];
            [returnString release];
        }
        return;
    }
    
    if([netRequest.strRequestType isEqualToString:kInterface_NewsClue_Update]){
        if(returnData != nil) {
            
            _currentFlag = kFlag_NewsClue_Update;
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString];
            [returnString release];
        }
        return;
    }
    
    if([netRequest.strRequestType isEqualToString:kInterface_NewsClue_Add]){
        if(returnData != nil) {
            
            _currentFlag = kFlag_NewsClue_Add;
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString];
            [returnString release];
        }
        return;
    }
    
    
    if([netRequest.strRequestType isEqualToString:kInterface_NewsClue_Delete]){
        if(returnData != nil) {
            
            _currentFlag = kFlag_NewsClue_Delete;
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString];
            [returnString release];
        }
        return;
    }
    
    if([netRequest.strRequestType isEqualToString:kInterface_NewsClue_Submit]){
        if(returnData != nil) {
            
            _currentFlag = kFlag_NewsClue_Submit;
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            [_parser startWithXMLInfo:returnString];
            [returnString release];
        }
        return;
    }
}

#pragma -
#pragma Public Methods.

- (void)getNewsClueListWithTitle:(NSString *)title Keyword:(NSString *)keyword
                                                           Note:(NSString *)note 
                                                         Status:(NSString *)status
                                                        Begtime:(NSString *)begtime 
                                                        Endtime:(NSString *)endtime
                                                        Type:(NSString *)type{
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
    if ([status length]>2) {
        status = @"";
    }
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&status=%@&begtime=%@&endtime=%@&type=%@",
        [UserHelper userName],[UserHelper password],title,keyword,note,status,begtime,endtime,type];
    
    if (netRequest != nil) {
        [netRequest release];
    }
    netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_NewsClue_List withRequestString:post];
    

}

- (void)getNewsClueDetailWithKeyID:(NSString *)keyID {

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@",
                      [UserHelper userName],[UserHelper password],keyID];
    
    if (netRequest != nil) {
        [netRequest release];
    }
    netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_NewsClue_Detail withRequestString:post];

}

- (void)addNewsClueWithTitle:(NSString *)title Keyword:(NSString *)keyword
                                                       Note:(NSString *)note 
                                                    Begtime:(NSString *)begtime 
                                                    Endtime:(NSString *)endtime 
                                                        Type:(NSString *) type
                                                    IsSubmit:(NSString *)issubmit{
    assert((title != nil) && ([title length]>0 ));
    assert((type != nil) && ([type length]>0));
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&type=%@&begtime=%@&endtime=%@&title=%@&keyword=%@&note=%@&issubmit=%@",
                      [UserHelper userName],[UserHelper password],type,begtime,endtime,title,keyword,note,issubmit];
    if (netRequest != nil) {
        [netRequest release];
    }
    netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_NewsClue_Add withRequestString:post];

}

- (void)updateNewsClueWithTitle:(NSString *)title Keyid:(NSString *)keyid 
                                                Keyword:(NSString *)keyword
                                                    Note:(NSString *)note 
                                                Begtime:(NSString *)begtime 
                                                Endtime:(NSString *)endtime 
                                                 Type:(NSString *) type
                                                IsSubmit:(NSString *)issubmit{
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@&title=%@&keyword=%@&note=%@&begtime=%@&endtime=%@&type=%@&issubmit=%@",[UserHelper userName],[UserHelper password],keyid,title,keyword,note,begtime,endtime,type,issubmit];
    if (netRequest != nil) {
        [netRequest release];
    }
    
    netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_NewsClue_Update withRequestString:post];

}

- (void)deleteNewsClueWithKeyID:(NSString *)keyID {

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      keyID,
                      nil];
    if (netRequest != nil) {
        [netRequest release];
    }
    netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_NewsClue_Delete withRequestString:post];

}

- (void)submitNewsClueWithKeyID:(NSString *)keyID {
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      keyID,
                      nil];
    if (netRequest != nil) {
        [netRequest release];
    }
    netRequest = [[NetRequest alloc] init];
    if(netRequest.resultData != nil)[netRequest.resultData release];
    netRequest.delegate = self;
    NSData *returnData = [netRequest PostData:kInterface_NewsClue_Submit withRequestString:post];

}

#pragma -
#pragma NewsClueParserHelperDelegate Support.

- (void)parserDidFinished:(NSArray *)newsCLueInfoArray {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(dataDidResponsed:flag:)]) {
    
        [_delegate dataDidResponsed:newsCLueInfoArray flag:_currentFlag];
    }
}

@end
