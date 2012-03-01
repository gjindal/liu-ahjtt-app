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

typedef enum{
    NEXTPAGE_SEARCH,
    NEXTPAGE_DETAIL,
    NEXTPAGE_OTHERS
}NEXTPAGE;

@interface DocChangeListViewController : UITableViewController<DocRequestDelegate> {
@private
    
	NSMutableArray *dataArray;
    
    DocDetail *docDetail;
    DocRequest *docRequest;
    
    DocSearchViewController *docSearchVtrl;
    
    NEXTPAGE nextPage;//标记返回页，如果是搜索返回就要显示结果
    
}

@property(nonatomic,retain) DocDetail *docDetail;
@property(nonatomic,retain) DocRequest *docRequest;

-(void)searchDocs;

@end
