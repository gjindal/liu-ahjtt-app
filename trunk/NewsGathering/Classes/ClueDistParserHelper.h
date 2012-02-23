//
//  ClueDistParserHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClueDistParserHelperDelegate.h"
#import "ClueDistInfo.h"
#import "UserInfo.h"
#import "DeptInfo.h"
#import "Contants.h"

@interface ClueDistParserHelper : NSObject<NSXMLParserDelegate> {
@private
    id<ClueDistParserHelperDelegate> _delegate;
    NSXMLParser                        *_xmlParser;
    NSMutableString                    *_currentValue;
    NSMutableArray                     *_userList;
    NSMutableArray                     *_distList;
    NSMutableArray                     *_deptList;
    ClueDistInfo                       *_distInfo;
    UserInfo                           *_userInfo;
    DeptInfo                           *_deptInfo;
    
    int                                 _currentFlag;
}

@property (nonatomic, assign) id<ClueDistParserHelperDelegate> delegate;

- (void)startWithXMLInfo:(NSString *)xmlInfo flag:(int)flag;

@end
