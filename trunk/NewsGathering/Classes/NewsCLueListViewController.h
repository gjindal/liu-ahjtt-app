//
//  NewsCLueListViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsCLueListViewController : UITableViewController {
@private
    NSArray *dataArray;
    UISegmentedControl *segmentCtrl;
}

@property(nonatomic,retain) NSArray *dataArray;

-(void)segmentAction:(id)sender;
- (void)back:(id)sender;

@end
