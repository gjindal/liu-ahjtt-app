//
//  NewsClueSearchViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsClueInfo.h"

typedef enum {
    SEARCHTYPE_CLUE,    // shows glow when pressed
    SEARCHTYPE_ALLOC,
} SEARCHTYPE;

typedef enum{
    TABLETYPE_CLUETYPE,
    TABLETYPE_CLUESTATUS
}TABLETYPE;

@interface NewsClueSearchViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource> {

	IBOutlet UIScrollView *scrollView;
	IBOutlet UIButton *startTime;
	IBOutlet UIButton *endTime;
	IBOutlet UITextField *newsTitle;
	IBOutlet UIButton *newsType;
	IBOutlet UIButton *newsStatus;
	IBOutlet UITextView *contents;
	IBOutlet UIButton *btConfirm;
	IBOutlet UIImageView *contentsBackground;
    IBOutlet UITextField *newsKeyword;
    
    NewsClueInfo *newsclueInfo;
	
	SEARCHTYPE nSearchType;
	NSString *strTimes;
	float originalContentHeight;
    
    bool isTextView;
    bool keyboardShown;
    UITextField *activeField;
    UITextView *activeView;
    
    TABLETYPE tableType;        //table是类型数据还是状态数据选择
    UITableView *custTableView;
	NSArray *typeArray;         //类型列表数据源
    NSArray *statusArray;       //状态列表数据源
    NSArray *array;
    
    NSString *tmpCellString;
    NSIndexPath *lastIndexPath;
    
    BOOL bTimeAlertView;
    
}

@property(nonatomic,retain) NewsClueInfo *newsclueInfo;
@property(nonatomic,retain) NSIndexPath *lastIndexPath;
@property(nonatomic,retain) NSArray *statusArray;
@property(nonatomic,retain) NSArray *typeArray;
@property(nonatomic) SEARCHTYPE nSearchType;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIButton *startTime;
@property(nonatomic,retain) IBOutlet UIButton *endTime;
@property(nonatomic,retain) IBOutlet UITextField *newsTitle;
@property(nonatomic,retain) IBOutlet UIButton *newsType;
@property(nonatomic,retain) IBOutlet UIButton *newsStatus;
@property(nonatomic,retain) IBOutlet UITextView *contents;
@property(nonatomic,retain) IBOutlet UIButton *btConfirm;
@property(nonatomic,retain) IBOutlet UIImageView *contentsBackground;
@property(nonatomic,retain) IBOutlet UITextField *newsKeyword;

-(IBAction)setStartDateTime:(id)sender;

-(IBAction)setEndDateTime:(id)sender;

-(IBAction)setType:(id)sender;

-(IBAction)setStatus:(id)sender;
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (void)scrollViewToCenterOfScreen:(UIView *)theView;
//- (void)textViewDidBeginEditing: (UITextView *) textView;
- (IBAction)confirm;


@end
