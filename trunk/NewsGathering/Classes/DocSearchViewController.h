//
//  DocSearchViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocDetail.h"

@interface DocSearchViewController : UIViewController<UITextFieldDelegate, UIActionSheetDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UIButton *btStartTime;
    IBOutlet UIButton *btEndTime;
    IBOutlet UIButton *btType;
    IBOutlet UIButton *btConfirm;
    IBOutlet UITextField *fdTitle;
    IBOutlet UITextField *fdKeyword;
    IBOutlet UIScrollView *scrollView;
    
    DocDetail *docDetail;
    NSString *strStartTime;
    NSString *strEndTime;
    
    NSMutableArray *typeArray;
    
    NSString *tmpCellString;
    NSIndexPath *lastIndexPath;
    BOOL bTimeAlertView;
    float originalContentHeight;
    bool isTextView;
    bool keyboardShown;
    UITextField *activeField;
    
    UITableView *custTableView;


}

@property(nonatomic,retain) NSString *strStartTime;
@property(nonatomic,retain) NSString *strEndTime;
@property(nonatomic,retain) IBOutlet UIButton *btStartTime;
@property(nonatomic,retain) IBOutlet UIButton *btEndTime;
@property(nonatomic,retain) IBOutlet UIButton *btType;
@property(nonatomic,retain) IBOutlet UIButton *btConfirm;
@property(nonatomic,retain) IBOutlet UITextField *fdTitle;
@property(nonatomic,retain) IBOutlet UITextField *fdKeyword;

@property(nonatomic,retain) DocDetail *docDetail;
@property(nonatomic,retain) NSMutableArray *typeArray;

@property(nonatomic,retain) NSString *tmpCellString;
@property(nonatomic,retain) NSIndexPath *lastIndexPath;
@property(nonatomic) BOOL bTimeAlertView;

-(IBAction) confirm:(id)sender;

-(IBAction)setStartDateTime:(id)sender;

-(IBAction)setEndDateTime:(id)sender;

-(IBAction)setType:(id)sender;

@end
