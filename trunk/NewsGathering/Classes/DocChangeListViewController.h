//
//  DocChangeListViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocRequestDelegate.h"
#import "DocRequest.h"
#import "DocDetail.h"
#import "DocSearchViewController.h"


@interface DocChangeListViewController : UITableViewController<DocRequestDelegate> {
@private
    
	NSArray *dataArray;
    
    DocDetail *docDetail;
    DocRequest *docRequest;
    
    DocSearchViewController *docSearchVtrl;
}

@property(nonatomic,retain) DocDetail *docDetail;
@property(nonatomic,retain) DocRequest *docRequest;

-(void)searchDocs;

@end
