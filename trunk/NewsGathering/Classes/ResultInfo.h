//
//  ResultInfo.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultInfo : NSObject{
    NSString *flag;
    NSString *message;
}

@property(nonatomic,retain)     NSString *flag;
@property(nonatomic,retain)     NSString *message;

@end
