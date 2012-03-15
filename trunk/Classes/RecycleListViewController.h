//
//  RecycleListViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DocRequest.h"
#import "DocRequestDelegate.h"

@interface RecycleListViewController : UITableViewController<DocRequestDelegate, UIActionSheetDelegate> {
@private
    NSMutableArray      *_dataArray;
    DocRequest          *_docRequest;
}

-(void)deleteAll;
- (void)back:(id)sender;
@end
