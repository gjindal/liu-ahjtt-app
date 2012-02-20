//
//  DeptParserHelperDelegate.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DeptInfo;

@protocol DeptParserHelperDelegate <NSObject>
@optional

- (void)parserDidFinished:(NSArray *)deptArray;

@end
