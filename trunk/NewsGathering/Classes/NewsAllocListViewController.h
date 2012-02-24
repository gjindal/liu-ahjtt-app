//
//  NewsAllocListViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClueDistRequest.h"
#import "ClueDistInfo.h"

@interface NewsAllocListViewController : UITableViewController<ClueDistRequestDelegate> {
@private
    NSArray *dataArray;
    
    ClueDistRequest *cluedistRequest;
    ClueDistInfo *schCluedistInfo;
}

@property(nonatomic,retain) ClueDistRequest *cluedistRequest;
@property(nonatomic,retain) ClueDistInfo *schCluedistInfo;

-(void)searchNews;
- (void)back:(id)sender;
@end
