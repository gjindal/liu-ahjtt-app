//
//  NewsCLueListViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsClueRequest.h"
#import "NewsClueInfo.h"


@interface NewsCLueListViewController : UITableViewController<NewsClueRequestDelegate> {
@private
    NSMutableArray *dataArray;
    UISegmentedControl *segmentCtrl;
    
    NewsClueRequest *newsclueRequest;
    NewsClueInfo *schNewsclueInfo;
    
    int nDeleteIndex;
}

@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain) NewsClueInfo *schNewsclueInfo;

-(void)segmentAction:(id)sender;
- (void)back:(id)sender;



@end
