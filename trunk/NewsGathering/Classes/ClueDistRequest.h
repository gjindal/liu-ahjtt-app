//
//  ClueDistRequest.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetRequest.h"
#import "ClueDistRequestDelegate.h"
#import "ClueDistParserHelper.h"

@interface ClueDistRequest : NetRequest {
@private
    id<ClueDistRequestDelegate> _delegate;
    ClueDistParserHelper        *_parser;
}

@property (nonatomic, assign) id<ClueDistRequestDelegate> delegate;

- (void)getListWithTitle:(NSString *)title Keyword:(NSString *)keyword 
                    Note:(NSString *)note Status:(NSString *)status
                 BegTime:(NSString *)begtime EndTime:(NSString *)endtime
                    Type:(NSString *)type;
- (void)getDetailWithKeyID:(NSString *)keyid;
- (void)getDept;
- (void)getUserWithDeptID:(NSString *)deptid;

@end
