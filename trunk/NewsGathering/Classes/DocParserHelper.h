//
//  DocParserHelper.h
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DocParserHelperDelegate.h"
#import "ContributeInfo.h"
#import "WorkflowInfo.h"

@interface DocParserHelper : NSObject<NSXMLParserDelegate> {
@private
    id<DocParserHelperDelegate>      _delegate;
    NSXMLParser                     *_xmlParser;
    NSMutableString                 *_currentValue;
    NSMutableArray                  *_docList;
    NSMutableArray                  *_appsList;
    NSMutableArray                  *_attitudeList;
    ContributeInfo                  *_info;
    int                              _currentFlag;
    NSMutableArray                  *_workflowList;
    WorkflowInfo                    *_workflowInfo;
    AttLsInfo                       *_attLsInfo;
    NSMutableArray                  *_attLsList;
    NSMutableArray                  *_workLogList;
    WorkLog                         *_workLogInfo;
}

@property (nonatomic, assign) id<DocParserHelperDelegate> delegate;

- (void)startWithXMLInfo:(NSString *)xmlInfo flag:(int)flag;

@end
