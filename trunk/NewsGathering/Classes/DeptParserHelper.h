//
//  DeptParserHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeptParserHelperDelegate.h"
#import "DeptInfo.h"

@interface DeptParserHelper : NSObject<NSXMLParserDelegate> {
@private
    NSXMLParser                     *_xmlParser;
    NSString                        *_currentValue;
    DeptInfo                        *_deptInfo;
    NSMutableArray                  *_deptArray;
    id<DeptParserHelperDelegate>    _delegate;
}

@property (nonatomic, assign) id<DeptParserHelperDelegate> delegate;

- (void)startWithXMLInfo:(NSString *)xmlInfo;

@end
