//
//  NewsAllocListViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsAllocListViewController : UITableViewController {
@private
    NSArray *dataArray;
}

-(void)searchNews;
- (void)back:(id)sender;
@end
