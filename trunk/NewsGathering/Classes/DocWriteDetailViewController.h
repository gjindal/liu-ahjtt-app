//
//  DocWriteDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ASIFormDataRequest.h"
#import "DocRequest.h"
#import "DocRequestDelegate.h"
#import "DocDetail.h"
#import "WorkflowInfo.h"
#import "ContributeInfo.h"
#import "UIViewPassValueDelegate.h"
#import "CustomAlertView.h"

@class StorageHelper;

typedef enum {
    DOCTYPE_DRAFT,    // shows glow when pressed
    DOCTYPE_DELETED,
} DOCTYPE;

typedef enum {
    MENUTYPE_SUBMIT,
    MENUTYPE_MEDIALIB,
}MENUTYPE;

typedef enum {
    ALERTTABLE_DOCTYPE,
    ALERTTABLE_LEVEL,
    ALERTTABLE_OTHERS
}ALERTTABLE_TYPE;

typedef enum {
    TYPE_ADD,
    TYPE_MODIFY
}TRANSFORM_TYPE;

@interface DocWriteDetailViewController : UIViewController
                                        <UITextFieldDelegate,
                                        UIScrollViewDelegate,
                                        UITableViewDelegate, 
                                        UITableViewDataSource, 
                                        UITextViewDelegate, 
                                        UIActionSheetDelegate, 
                                        UIImagePickerControllerDelegate, 
                                        UINavigationControllerDelegate, 
                                        UIAlertViewDelegate,
                                        ASIHTTPRequestDelegate,
                                        DocRequestDelegate,UIViewPassValueDelegate> 
{

	
    IBOutlet UITextField *fdTitle;
	IBOutlet UIButton *btType;
    IBOutlet UIButton *btLevel;
    IBOutlet UIButton *btReceptor;
	IBOutlet UITextField *fdKeyword;
	IBOutlet UITextField *fdDocSource;
	IBOutlet UITextView *contents;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imgContentsBgd;
	IBOutlet UITableView *attachTable;
	NSArray *attachArray;
    
    
    NSMutableArray *typeArray;
    NSMutableArray *levelArray;
    NSString *tmpCellString;
    ALERTTABLE_TYPE alertType;
    NSIndexPath *lastTypeIndexPath;
    NSIndexPath *lastLevelIndexPath;
    
	
	UITextField * activeField;  
	BOOL keyboardShown;
	CGFloat oldContentOffsetValue;
	BOOL isNeedSetOffset; 
	bool isTextView;
    UITextView *activeView;
                                            
    CustomAlertView *alert;                                        
    
	IBOutlet UIButton *btRecorder;
	IBOutlet UIButton *btCamera;
	IBOutlet UIButton *btVideo;
    
    DOCTYPE docType;
    MENUTYPE menuType;
    TRANSFORM_TYPE transformType;
    
    StorageHelper *_storeHelper;
    ASIFormDataRequest *request;
    DocRequest *docRequest;
    WorkflowInfo *workflowInfo;
    
    NSMutableArray *dispatchedArray;
    NSString *dispatchedUsersName;
    NSString *dispatchedUsersID;
    
    ContributeInfo *contributeInfo;
    DocDetail      *_docDetail;
}

@property (retain, nonatomic) NSString *dispatchedUsersName;
@property (retain, nonatomic) NSString *dispatchedUsersID;
@property (retain, nonatomic) NSMutableArray *typeArray;
@property (retain, nonatomic) NSMutableArray *levelArray;
@property (retain, nonatomic) ASIFormDataRequest *request;
@property (nonatomic) DOCTYPE docType;
@property (nonatomic) MENUTYPE menuType;
@property (nonatomic) TRANSFORM_TYPE transformType;
@property (nonatomic) BOOL keyboardShown;
@property (nonatomic,retain)	UITextField *activeField;
@property (nonatomic,retain)    CustomAlertView *alert;

@property (nonatomic,retain)    StorageHelper *storeHelper;
@property (nonatomic,retain)	IBOutlet UITableView *attachTable;
@property (nonatomic,retain)	NSArray *attachArray;
@property (nonatomic,retain)	IBOutlet UIImageView *imgContentsBgd;
@property (nonatomic,retain)	IBOutlet UITextField *fdTitle;
@property (nonatomic,retain)	IBOutlet UITextField *fdKeyword;
@property (nonatomic,retain)	IBOutlet UITextField *fdDocSource;
@property (nonatomic,retain)	IBOutlet UITextView *contents;
@property (nonatomic,retain)	IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain)	IBOutlet UIButton *btType;
@property (nonatomic,retain)	IBOutlet UIButton *btLevel;
@property (nonatomic,retain)	IBOutlet UIButton *btReceptor;

@property (nonatomic,retain)	IBOutlet UIButton *btRecorder;
@property (nonatomic,retain)	IBOutlet UIButton *btCamera;
@property (nonatomic,retain)	IBOutlet UIButton *btVideo;

@property (nonatomic, retain)   DocDetail   *docDetail;

-(IBAction) getPhoto;
-(IBAction) getRecord;
-(IBAction) getVideo;

-(IBAction)setLevel:(id)sender;
-(IBAction)setType:(id)sender;
-(IBAction)setReceptor:(id)sender;

-(void)saveDoc;
-(void)submitForAudit;
-(void)shareToWB;

- (void)alertInfo:(NSString *)info withTitle:(NSString *)title;
@end
