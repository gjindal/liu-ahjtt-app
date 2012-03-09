//
//  NewsClueRequest.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetRequest.h"
#import "NewsClueInfo.h"
#import "NewsClueParserHelper.h"
#import "Contants.h"
#import "UserHelper.h"
#import "NewsClueRequestDelegate.h"

@interface NewsClueRequest : NetRequest<NewsClueParserHelperDelegate> {
@private
    id<NewsClueRequestDelegate>  _delegate;
    NewsClueParserHelper        *_parser;
    int                          _currentFlag;
}

@property (nonatomic, assign) id<NewsClueRequestDelegate> delegate;

// 查询线索列表接口.
- (void)getNewsClueListWithTitle:(NSString *)title Keyword:(NSString *)keyword
                                                   Note:(NSString *)note 
                                                 Status:(NSString *)status
                                                Begtime:(NSString *)begtime 
                                                Endtime:(NSString *)endtime
                                                Type:(NSString *)type;
// 查询线索详情接口.
- (void)getNewsClueDetailWithKeyID:(NSString *)keyID;
// 增加线索接口.
- (void)addNewsClueWithTitle:(NSString *)title Keyword:(NSString *)keyword
                                                       Note:(NSString *)note 
                                                    Begtime:(NSString *)begtime 
                                                    Endtime:(NSString *)endtime
                                                    Type:(NSString *) type
                                                    IsSubmit:(NSString *)issubmit;
// 修改线索接口.
- (void)updateNewsClueWithTitle:(NSString *)title  Keyid:(NSString *)keyid 
                                                    Keyword:(NSString *)keyword
                                                       Note:(NSString *)note 
                                                    Begtime:(NSString *)begtime 
                                                    Endtime:(NSString *)endtime
                                                        Type:(NSString *) type
                                                    IsSubmit:(NSString *)issubmit;
// 删除线索接口.
- (void)deleteNewsClueWithKeyID:(NSString *)keyID;
// 提交线索接口.
- (void)submitNewsClueWithKeyID:(NSString *)keyID;
@end
