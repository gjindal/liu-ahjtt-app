
//
//  NewsClueDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClueDistInfo.h"
#import "ClueDistRequest.h"
#import "ClueDistRequestDelegate.h"
#import "UIViewPassValueDelegate.h"

@interface NewsAllocDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ClueDistRequestDelegate,UIViewPassValueDelegate> {
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *clueTitle;
    IBOutlet UILabel *clueType;
    IBOutlet UITextView *contents;
    IBOutlet UILabel *btStartTime;
    IBOutlet UILabel *btEndTime;
    IBOutlet UILabel *clueKeyword;
    IBOutlet UILabel *sendUserName;
    NSString *clueKeyid;
    
    UITableView *dispatchedTableView;
    NSMutableArray *dispatchedArray;
    
    IBOutlet UIImageView *imgContentsBgd;
    
    ClueDistInfo *cluedistInfo;
    ClueDistRequest *cluedistRequest;
    
    BOOL bEnableDispatch;
    NSMutableArray *array;
    NSString *dispatchedUsersName;
    NSString *dispatchedUsersID;
    
    

}

@property(nonatomic,retain) UITableView *dispatchedTableView;
@property(nonatomic,retain) NSMutableArray *dispatchedArray;
@property(nonatomic,retain) NSString *dispatchedUsersName;
@property(nonatomic,retain) NSString *dispatchedUsersID;
@property(nonatomic,retain) IBOutlet UILabel *sendUserName;
@property(nonatomic,retain) IBOutlet UILabel *clueTitle;
@property(nonatomic,retain) IBOutlet UILabel *clueType;
@property(nonatomic,retain) IBOutlet UITextView *contents;
@property(nonatomic,retain) IBOutlet UILabel *btStartTime;
@property(nonatomic,retain) IBOutlet UILabel *btEndTime;
@property(nonatomic,retain) IBOutlet UILabel *clueKeyword;
@property(nonatomic,retain) NSString *clueKeyid;

@property(nonatomic,retain) IBOutlet UIImageView *imgContentsBgd;

@property(nonatomic,retain) ClueDistInfo *cluedistInfo;
@property(nonatomic,retain) ClueDistRequest *cluedistRequest;


-(void)dispatchCLue;                     //派送

-(void) getCLueInfo;

- (void)alertInfo:(NSString *)info withTitle:(NSString *)title;
@end
