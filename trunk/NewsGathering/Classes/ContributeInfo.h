//
//  ContributeInfo.h
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultInfo.h"

@interface ContributeInfo : ResultInfo {
@private
    NSString *_conid;
    NSString *_level;
    NSString *_time;
    NSString *_title;
    NSString *_type;
    NSString *_flowID;
    NSString *_status;
    NSArray  *_appsList;
    NSArray  *_attitudeList;
}

@property (nonatomic, retain) NSString *conid;
@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *flowID;
@property (nonatomic, retain) NSArray *apps;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSArray *attitudeList;

+ (NSString *)getFlowID;

@end
