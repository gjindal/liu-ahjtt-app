//
//  ClueWriteDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClueWriteDetailViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>{

    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *clueTitle;
    IBOutlet UIButton   *clueType;
    IBOutlet UITextView *contents;
    IBOutlet UIImageView *imgContentsBgd;
    
    NSString *tmpCellString;
    NSArray *array;
    
	UITextField * activeField;  
	BOOL keyboardShown;
	CGFloat oldContentOffsetValue;
	BOOL isNeedSetOffset; 
	bool isTextView;
    UITextView *activeView;
    
    NSIndexPath *lastIndexPath;
}

@property(nonatomic,retain) NSIndexPath *lastIndexPath;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *clueTitle;
@property(nonatomic,retain) IBOutlet UIButton *clueType;
@property(nonatomic,retain) IBOutlet UITextView *contents;
@property(nonatomic,retain) IBOutlet UIImageView *imgContentsBgd;

-(IBAction)setType:(id)sender;

@end
