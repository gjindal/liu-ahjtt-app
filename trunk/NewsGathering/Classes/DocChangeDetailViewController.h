//
//  DocChangeDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DocChangeDetailViewController : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource> {
	
	IBOutlet UITextField *fdTitle;
	IBOutlet UITextField *fdAuthor;
	IBOutlet UITextField *fdStatus;
	IBOutlet UITextView *contents;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imgContentsBgd;
	IBOutlet UIImageView *imgMessageBgd;
	IBOutlet UITableView *attachTable;
	NSArray *attachArray;
	
	UITextField * activeField;  
	BOOL keyboardShown;
	CGFloat oldContentOffsetValue;
	BOOL isNeedSetOffset; 
	
	IBOutlet UIButton *btRecorder;
	IBOutlet UIButton *btCamera;
	IBOutlet UIButton *btVideo;
	IBOutlet UILabel *lblMessage;
	IBOutlet UITextView *txtMessage;
}

@property (nonatomic) BOOL keyboardShown;
@property (nonatomic,retain)	UITextField *activeField;

@property (nonatomic,retain)	IBOutlet UILabel *lblMessage;
@property (nonatomic,retain)	IBOutlet UITextView *txtMessage;
@property (nonatomic,retain)	IBOutlet UITableView *attachTable;
@property (nonatomic,retain)	NSArray *attachArray;
@property (nonatomic,retain)	IBOutlet UIImageView *imgContentsBgd;
@property (nonatomic,retain)	IBOutlet UITextField *fdTitle;
@property (nonatomic,retain)	IBOutlet UITextField *fdAuthor;
@property (nonatomic,retain)	IBOutlet UITextField *fdStatus;
@property (nonatomic,retain)	IBOutlet UITextView *contents;
@property (nonatomic,retain)	IBOutlet UIScrollView *scrollView;

@property (nonatomic,retain)	IBOutlet UIButton *btRecorder;
@property (nonatomic,retain)	IBOutlet UIButton *btCamera;
@property (nonatomic,retain)	IBOutlet UIButton *btVideo;

-(IBAction) getPhoto;
-(IBAction) getRecord;
-(IBAction) getVideo;
@end
