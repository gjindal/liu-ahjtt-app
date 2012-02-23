//
//  NewsClueDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsClueInfo.h"
#import "NewsClueRequest.h"

@interface NewsClueDetailViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,NewsClueRequestDelegate> {

    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *clueTitle;
    IBOutlet UIButton *clueType;
    //IBOutlet UILabel *author;
    //IBOutlet UILabel *createTime;
    //IBOutlet UILabel *status;
    IBOutlet UITextView *contents;
    IBOutlet UIButton *btStartTime;
    IBOutlet UIButton *btEndTime;
    IBOutlet UITextField *clueKeyword;
    NSString *clueKeyid;
    
    IBOutlet UIImageView *imgContentsBgd;
    IBOutlet UIButton *btConfirm;
    
    BOOL bEnableChange;     //是否具有修改功能
    BOOL bEnableAudit;
    
    NSString *tmpCellString;
    NSMutableArray *array;
    NewsClueInfo *newsclueInfo;
    NewsClueRequest *newsclueRequest;
    
    //控制键盘
	UITextField * activeField;  
	BOOL keyboardShown;
	CGFloat oldContentOffsetValue;
	BOOL isNeedSetOffset; 
	bool isTextView;
    UITextView *activeView;
    
    NSIndexPath *lastIndexPath;
    
    UITableView *custTableView;
    BOOL bTimeAlertView;
    
    //是否为新增线索功能，如果不是则就是修改线索功能
    BOOL isAddNewsClue;
}

@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *clueTitle;
@property(nonatomic,retain) IBOutlet UIButton *clueType;
@property(nonatomic,retain) IBOutlet UIButton *btStartTime;
@property(nonatomic,retain) IBOutlet UIButton *btEndTime;
@property(nonatomic,retain) IBOutlet UITextField *clueKeyword;
@property(nonatomic,retain) IBOutlet UITextView *contents;
@property(nonatomic,retain) IBOutlet UIImageView *imgContentsBgd;
@property(nonatomic,retain) IBOutlet UIButton *btConfirm;

@property(nonatomic,retain) NewsClueInfo *newsclueInfo;

@property(nonatomic) BOOL isAddNewsClue;
@property(nonatomic) BOOL bEnableChange;
@property(nonatomic) BOOL bEnableAudit;

-(IBAction)setStartDateTime:(id)sender;

-(IBAction)setEndDateTime:(id)sender;

-(IBAction)setType:(id)sender;

-(void) setChangeFunction;    //开启修改功能

-(IBAction)confirmChanges:(id)sender; //提交修改的内容

-(void)passAudit;                     //审核通过

- (void)alertInfo:(NSString *)info;
@end
