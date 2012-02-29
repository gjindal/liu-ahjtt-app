//
//  DocChangeDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocRequest.h"
#import "DocRequestDelegate.h"
#import "ContributeInfo.h"


@interface DocChangeDetailViewController : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,DocRequestDelegate> {
	
    IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imgContentsBgd;
	IBOutlet UIImageView *imgMessageBgd;
    
	IBOutlet UITextField *fdTitle;
	IBOutlet UITextField *fdKeyword;
	IBOutlet UITextField *fdSource;
    IBOutlet UIButton *btType;
    IBOutlet UIButton *btLevel;
	IBOutlet UITextView *contents;

	IBOutlet UITableView *attachTable;
    IBOutlet UIButton *btRecorder;
	IBOutlet UIButton *btCamera;
	IBOutlet UIButton *btVideo;
	IBOutlet UILabel *lblMessage;
	IBOutlet UITextView *txtMessage;
    
    
	NSArray *attachArray;
	
	UITextField * activeField;  
	BOOL keyboardShown;
	CGFloat oldContentOffsetValue;
	BOOL isNeedSetOffset; 
    
    ContributeInfo *contributeInfo;
    DocRequest *docRequest;
    

}

@property (nonatomic) BOOL keyboardShown;
@property (nonatomic,retain)	UITextField *activeField;
@property (nonatomic,retain)	NSArray *attachArray;

@property (nonatomic,retain)	ContributeInfo *contributeInfo;
@property (nonatomic,retain)	DocRequest *docRequest;

@property (nonatomic,retain)	IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain)	IBOutlet UIImageView *imgContentsBgd;
@property (nonatomic,retain)	IBOutlet UIImageView *imgMessageBgd;

@property (nonatomic,retain)	IBOutlet UITextField *fdTitle;
@property (nonatomic,retain)	IBOutlet UITextField *fdKeyword;
@property (nonatomic,retain)	IBOutlet UITextField *fdSource;
@property (nonatomic,retain)	IBOutlet UIButton *btType;
@property (nonatomic,retain)	IBOutlet UIButton *btLevel;
@property (nonatomic,retain)	IBOutlet UITextView *contents;

@property (nonatomic,retain)	IBOutlet UITableView *attachTable;
@property (nonatomic,retain)	IBOutlet UIButton *btRecorder;
@property (nonatomic,retain)	IBOutlet UIButton *btCamera;
@property (nonatomic,retain)	IBOutlet UIButton *btVideo;
@property (nonatomic,retain)	IBOutlet UILabel *lblMessage;
@property (nonatomic,retain)	IBOutlet UITextView *txtMessage;


-(IBAction) getPhoto;
-(IBAction) getRecord;
-(IBAction) getVideo;

-(void) initForm;


@end
