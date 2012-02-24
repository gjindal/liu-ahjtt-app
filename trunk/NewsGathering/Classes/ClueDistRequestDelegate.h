//
//  ClueDistRequestDelegate.h
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@class ClueDistInfo;
@class ResultInfo;

@protocol ClueDistRequestDelegate <NSObject>
@optional

- (void)parserListDidFinished:(NSArray *)distList;
- (void)parserDetailDidFinished:(ClueDistInfo *)clueDistInfo;
- (void)parserDeptDidFinished:(NSArray *)deptList;
- (void)parserUserDidFinished:(NSArray *)userList;
- (void)parserSubmitDidFinished:(ResultInfo *)resultInfo;

@end