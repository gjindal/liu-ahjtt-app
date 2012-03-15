//
//  DocWriteListViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DocDetailHelper.h"
#import "DocDetail.h"

@interface DocWriteListViewController : UITableViewController {
@private 
    NSArray             *dataArray;
    DocDetailHelper     *_docHelper;
}

-(void)writeNewsDoc;
- (void)back:(id)sender;

@end
