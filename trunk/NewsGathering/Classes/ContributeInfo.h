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
}

@property (nonatomic, retain) NSString *conid;
@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;

@end
