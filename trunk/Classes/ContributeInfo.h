//
//  ContributeInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultInfo.h"

@interface AttLsInfo : NSObject {
@private
    NSString *_fileName;
    NSString *_attLsID;
}

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *attLsID;

@end

@interface WorkLog : NSObject {
@private
    NSString *_logID;
    NSString *_recuseuserID;
    NSString *_status;
    NSString *_userID;
}

@property (nonatomic, retain) NSString *logID;
@property (nonatomic, retain) NSString *recuseuserID;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *userID;

@end

@interface ContributeInfo : ResultInfo {
@private
    NSString *_conid;
    NSString *_level;
    NSString *_note;
    NSString *_status;
    NSString *_statusNm;
    NSString *_time;
    NSString *_title;
    NSString *_type;
    NSString *_flowID;
    NSString *_keyword;
    NSString *_source;
    NSArray  *_appsList;
    NSArray  *_attitudeList;
    NSArray  *_attLsList;
    NSArray  *_workLogList;
}

@property (nonatomic, retain) NSString *conid;
@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *note;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *flowID;
@property (nonatomic, retain) NSArray  *apps;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *statusNm;
@property (nonatomic, retain) NSString *keyword;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSArray  *attitudeList;
@property (nonatomic, retain) NSArray  *attLsList;
@property (nonatomic, retain) NSArray  *workLogList;

+ (NSString *)getFlowID;

@end
