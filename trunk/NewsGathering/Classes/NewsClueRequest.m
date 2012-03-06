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
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&title=%@&keyword=%@&note=%@&status=%@&begtime=%@&endtime=%@&type=%@",
        [UserHelper userName],[UserHelper password],title,keyword,note,status,begtime,endtime,type];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_List withRequestString:post];
    if(returnData != nil) {
        _currentFlag = kFlag_NewsClue_List;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)getNewsClueDetailWithKeyID:(NSString *)keyID {

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@",
                      [UserHelper userName],[UserHelper password],keyID];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_Detail withRequestString:post];
    if(returnData != nil) {
        
        _currentFlag = kFlag_NewsClue_Detail;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)addNewsClueWithTitle:(NSString *)title Keyword:(NSString *)keyword
                                                       Note:(NSString *)note 
                                                    Begtime:(NSString *)begtime 
                                                    Endtime:(NSString *)endtime 
                                                        Type:(NSString *) type{
    assert((title != nil) && ([title length]>0 ));
    assert((type != nil) && ([type length]>0));
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&type=%@&begtime=%@&endtime=%@&title=%@&keyword=%@&note=%@",
                      [UserHelper userName],[UserHelper password],type,begtime,endtime,title,keyword,note];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_Add withRequestString:post];
    if(returnData != nil) {
        
        _currentFlag = kFlag_NewsClue_Add;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)updateNewsClueWithTitle:(NSString *)title Keyid:(NSString *)keyid 
                                                Keyword:(NSString *)keyword
                                                    Note:(NSString *)note 
                                                Begtime:(NSString *)begtime 
                                                Endtime:(NSString *)endtime 
                                                 Type:(NSString *) type{
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@&title=%@&keyword=%@&note=%@&begtime=%@&endtime=%@&type=%@",[UserHelper userName],[UserHelper password],keyid,title,keyword,note,begtime,endtime,type];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_Update withRequestString:post];
    if(returnData != nil) {
        
        _currentFlag = kFlag_NewsClue_Update;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)deleteNewsClueWithKeyID:(NSString *)keyID {

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      keyID,
                      nil];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_Delete withRequestString:post];
    if(returnData != nil) {
        
        _currentFlag = kFlag_NewsClue_Delete;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)submitNewsClueWithKeyID:(NSString *)keyID {
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&keyid=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      keyID,
                      nil];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_Submit withRequestString:post];
    if(returnData != nil) {
        
        _currentFlag = kFlag_NewsClue_Submit;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

#pragma -
#pragma NewsClueParserHelperDelegate Support.

- (void)parserDidFinished:(NSArray *)newsCLueInfoArray {

    if(_delegate != nil && [_delegate respondsToSelector:@selector(dataDidResponsed:flag:)]) {
    
        [_delegate dataDidResponsed:newsCLueInfoArray flag:_currentFlag];
    }
}

@end
