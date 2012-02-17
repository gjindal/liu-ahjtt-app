//
//  NewsClueSearchViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SEARCHTYPE_CLUE 1
#define SEARCHTYPE_ALLOC 2

@interface NewsClueSearchViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate> {

	IBOutlet UIScrollView *scrollView;
	IBOutlet UIButton *startTime;
	IBOutlet UIButton *endTime;
	IBOutlet UITextField *newsTitle;
	IBOutlet UITextField *newsType;
	IBOutlet UITextField *newsStatus;
	IBOutlet UITextView *contents;
	IBOutlet UIButton *btConfirm;
	IBOutlet UIImageView *contentsBackground;
	
	int nSearchType;
	NSString *strTimes;
	float originalContentHeight;
    
    bool isTextView;
    bool keyboardShown;
    UITextField *activeField;
    UITextView *activeView;
}

@property(nonatomic) int nSearchType;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIButton *startTime;
@property(nonatomic,retain) IBOutlet UIButton *endTime;
@property(nonatomic,retain) IBOutlet UITextField *newsTitle;
@property(nonatomic,retain) IBOutlet UITextField *newsType;
@property(nonatomic,retain) IBOutlet UITextField *newsStatus;
@property(nonatomic,retain) IBOutlet UITextView *contents;
@property(nonatomic,retain) IBOutlet UIButton *btConfirm;
@property(nonatomic,retain) IBOutlet UIImageView *contentsBackground;


-(IBAction)setStartDateTime:(id)sender;

-(IBAction)setEndDateTime:(id)sender;
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (void)scrollViewToCenterOfScreen:(UIView *)theView;
//- (void)textViewDidBeginEditing: (UITextView *) textView;
- (IBAction)confirm;


@end
