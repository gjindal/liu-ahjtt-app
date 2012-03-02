//
//  DocRequestDelegate.h
//  NewsGathering
//
//  Created by XiguaZerg on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class ContributeInfo;

@protocol DocRequestDelegate <NSObject>
@optional

- (void)getDocListDidFinished:(NSArray *)docList;
- (void)getDocDetailDidFinished:(ContributeInfo *)contributeInfo;
- (void)addDocDidFinished:(ContributeInfo *)contributeInfo;
- (void)addDocForApproveDidFinished:(ContributeInfo *)contributeInfo;
- (void)updateDocDidFinished:(ContributeInfo *)contributeInfo;
- (void)deleteDocDidFinished:(ContributeInfo *)contributeInfo;
- (void)submitDocDidFinished:(ContributeInfo *)contributeInfo;
- (void)resumeDocDidFinished:(ContributeInfo *)contributeInfo;
- (void)removeDocDidFinished:(ContributeInfo *)contributeInfo;
- (void)getAppListDidFinished:(NSArray *)docList;
- (void)approveDidFinished:(ContributeInfo *)contributeInfo;
- (void)getWorkflowDidFinished:(NSArray *)workflowArray;
- (void)getCycleListDidFinished:(NSArray *)docList;
- (void)downloadDidFinished:(BOOL)isSuccess;
- (void)getEditListDidFinished:(NSArray *)workflowArray;

@end
