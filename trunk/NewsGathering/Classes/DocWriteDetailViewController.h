//
//  DocWriteDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DOCTYPE_DRAFT,    // shows glow when pressed
    DOCTYPE_DELETED,
} DOCTYPE;

@interface DocWriteDetailViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

	IBOutlet UITextField *fdTitle;
	IBOutlet UITextField *fdDocType;
	IBOutlet UITextField *fdKeyword;
	IBOutlet UITextField *fdDocSource;
	IBOutlet UITextView *contents;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imgContentsBgd;
	IBOutlet UITableView *attachTable;
	NSMutableArray *attachArray;
    
	
	UITextField * activeField;  
	BOOL keyboardShown;
	CGFloat oldContentOffsetValue;
	BOOL isNeedSetOffset; 
	bool isTextView;
    UITextView *activeView;
    
	IBOutlet UIButton *btRecorder;
	IBOutlet UIButton *btCamera;
	IBOutlet UIButton *btVideo;
    
    DOCTYPE docType;
}

@property (nonatomic) DOCTYPE docType;
@property (nonatomic) BOOL keyboardShown;
@property (nonatomic,retain)	UITextField *activeField;

@property (nonatomic,retain)	IBOutlet UITableView *attachTable;
@property (nonatomic,retain)	NSArray *attachArray;
@property (nonatomic,retain)	IBOutlet UIImageView *imgContentsBgd;
@property (nonatomic,retain)	IBOutlet UITextField *fdTitle;
@property (nonatomic,retain)	IBOutlet UITextField *fdDocType;
@property (nonatomic,retain)	IBOutlet UITextField *fdKeyword;
@property (nonatomic,retain)	IBOutlet UITextField *fdDocSource;
@property (nonatomic,retain)	IBOutlet UITextView *contents;
@property (nonatomic,retain)	IBOutlet UIScrollView *scrollView;

@property (nonatomic,retain)	IBOutlet UIButton *btRecorder;
@property (nonatomic,retain)	IBOutlet UIButton *btCamera;
@property (nonatomic,retain)	IBOutlet UIButton *btVideo;

-(IBAction) getPhoto;
-(IBAction) getRecord;
-(IBAction) getVideo;

@end
