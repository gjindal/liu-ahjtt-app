//
//  WorkflowInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkflowInfo : NSObject {
@private
    NSString *_endStatus;
    NSString *_flowid;
    NSString *_level;
    NSString *_opttype;
    NSString *_remark;
    NSString *_roleid;
}

@property (nonatomic, retain) NSString *endStatus;
@property (nonatomic, retain) NSString *flowid;
@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *opttype;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *roleid;

@end
