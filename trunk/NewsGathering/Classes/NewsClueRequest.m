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
                                                        Endtime:(NSString *)endtime {
    
//    NSString *post = [[NSString alloc] initWithFormat:@"usercode=%@&password=%@&title=%@&keyword=%@&note=%@&statue=%@&begtime=%@&endtime=%@",
//                      [UserHelper userName],
//                      [MD5EncryptProcess md5:[UserHelper password]],
//                      title,
//                      keyword,
//                      note,
//                      status,
//                      begtime,
//                      endtime,
//                      nil];

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      nil];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_List withRequestString:post];
    if(returnData != nil) {
    
        _currentFlag = kFlag_NewsClue_List;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)getNewsClueDetailWithKeyID:(NSString *)keyID {

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@\
                      &password=%@\
                      &keyid=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      keyID,
                      nil];
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
                                                    Endtime:(NSString *)endtime {
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@\
                      &password=%@\
                      &title=%@\
                      &keyword=%@\
                      &note=%@\
                      &begtime=%@\
                      &endtime=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      title,
                      keyword,
                      note,
                      begtime,
                      endtime,
                      nil];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_Add withRequestString:post];
    if(returnData != nil) {
        
        _currentFlag = kFlag_NewsClue_Add;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)updateNewsClueWithTitle:(NSString *)title Keyword:(NSString *)keyword
                                                          Note:(NSString *)note 
                                                       Begtime:(NSString *)begtime 
                                                       Endtime:(NSString *)endtime {
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@\
                      &password=%@\
                      &title=%@\
                      &keyword=%@\
                      &note=%@\
                      &begtime=%@\
                      &endtime=%@",
                      [UserHelper userName],
                      [UserHelper password],
                      title,
                      keyword,
                      note,
                      begtime,
                      endtime,
                      nil];
    NSData *returnData = [NetRequest PostData:kInterface_NewsClue_Update withRequestString:post];
    if(returnData != nil) {
        
        _currentFlag = kFlag_NewsClue_Update;
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [_parser startWithXMLInfo:returnString];
        [returnString release];
    }
}

- (void)deleteNewsClueWithKeyID:(NSString *)keyID {

    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@\
                      &password=%@\
                      &keyid=%@",
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
    
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@\
                      &password=%@\
                      &keyid=%@",
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
