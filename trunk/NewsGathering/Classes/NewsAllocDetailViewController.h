
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

@interface NewsAllocDetailViewController : UIViewController<UIScrollViewDelegate,ClueDistRequestDelegate> {
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *clueTitle;
    IBOutlet UILabel *clueType;
    IBOutlet UITextView *contents;
    IBOutlet UILabel *btStartTime;
    IBOutlet UILabel *btEndTime;
    IBOutlet UILabel *clueKeyword;
    IBOutlet UILabel *sendUserName;
    NSString *clueKeyid;
    
    IBOutlet UIImageView *imgContentsBgd;
    
    ClueDistInfo *cluedistInfo;
    ClueDistRequest *cluedistRequest;
    
    BOOL bEnableDispatch;
    NSMutableArray *array;
    NSString *dispatchedUsers;

}

@property(nonatomic,retain) NSString *dispatchedUsers;
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
