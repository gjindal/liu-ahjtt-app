//
//  DocChangeDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import "StorageHelper.h"
#import "DocRequest.h"
#import "DocRequestDelegate.h"
#import "ContributeInfo.h"
#import "Contants.h"
#import "ASIFormDataRequest.h"
#import "UIViewPassValueDelegate.h"
#import "CustomAlertView.h"
#import "AuditOpinionViewController.h"
#import "ImagePlayViewController.h"
#import "FTPTransFileDelegate.h"
#import "FTPDownloadFile.h"
#import "FTPUploadFile.h"


typedef enum {
    ACTIONSHEET_TYPE_SUBMIT,
    ACTIONSHEET_TYPE_WEIBO

}ACTIONSHEET_TYPE;

@interface DocChangeDetailViewController : UIViewController <UITextFieldDelegate,
                                                             UIScrollViewDelegate,
                                                             UITableViewDelegate, 
                                                             UITableViewDataSource, 
                                                             UITextViewDelegate, 
                                                             UIActionSheetDelegate, 
                                                             UIImagePickerControllerDelegate, 
                                                             UINavigationControllerDelegate, 
                                                            
                                                             UIAlertViewDelegate,
                                                             ASIHTTPRequestDelegate,
                                                             DocRequestDelegate,UIViewPassValueDelegate,
                                                            NSURLConnectionDataDelegate,FTPTransFileDelegate> 
{
	
    IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imgContentsBgd;
    
	IBOutlet UITextField *fdTitle;
	IBOutlet UITextField *fdKeyword;
	IBOutlet UITextField *fdSource;
    IBOutlet UIButton *btType;
    IBOutlet UIButton *btLevel;
    IBOutlet UIButton *btNextReceptor;
	IBOutlet UITextView *contents;

	IBOutlet UITableView *attachTable;
    IBOutlet UIButton *btRecorder;
	IBOutlet UIButton *btCamera;
	IBOutlet UIButton *btVideo;
    IBOutlet UIButton *btOpinion;
    
	NSMutableArray *attachArray;
    NSMutableArray *typeArray;
    NSMutableArray *levelArray;
    NSIndexPath *lastTypeIndexPath;
    NSIndexPath *lastLevelIndexPath;
    NSIndexPath *currentAttchIndexPath;
	
	UITextField * activeField;  
	BOOL keyboardShown;
	CGFloat oldContentOffsetValue;
	BOOL isNeedSetOffset; 
    
    BOOL enableEdit;
    BOOL enableAudit;
    BOOL enableShare;
    ContributeInfo *contributeInfo;
    DocRequest *docRequest;
    StorageHelper *_storeHelper;
    FTPDownloadFile *ftpDownload;
    
    DOCTYPE docType;
    MENUTYPE menuType;
    TRANSFORM_TYPE transformType;
    ALERTTABLE_TYPE alertType;
    
    ASIFormDataRequest *request;
    WorkflowInfo *workflowInfo;
    NSArray *workflowInfoArray;
    NSString *tmpCellString;
    int attachIndex;
    
    NSMutableArray *receptorArray;
    NSString *nextReceptorUserName;
    NSString *nextReceptorUserID;
    CustomAlertView *alert;
    
    NSMutableData *receivedData;
    NSURLConnection *urlConnect;
    
    NSFileHandle *file;
    NSString *fileName;
    NSString *nextStatus;//根据状态判断是被打回了，还是通过了
    
    AuditOpinionViewController *opinionViewController;
    
    ImagePlayViewController *imagePlayCtrl;
    
    int fileCount;
    FTPUploadFile *ftpUploadFile;

}

@property (nonatomic) BOOL keyboardShown;
@property (nonatomic,retain)	UITextField *activeField;
@property (nonatomic,retain)	NSMutableArray *attachArray;
@property (nonatomic,retain)	NSMutableArray *receptorArray;
@property (nonatomic,retain)	NSMutableArray *typeArray;
@property (nonatomic,retain)	NSMutableArray *levelArray;
@property (nonatomic,retain)	NSIndexPath *lastTypeIndexPath;
@property (nonatomic,retain)	NSIndexPath *lastLevelIndexPath;

@property (nonatomic,retain)	ContributeInfo *contributeInfo;
@property (nonatomic,retain)	DocRequest *docRequest;
@property (retain, nonatomic)   ASIFormDataRequest *request;
@property (retain, nonatomic)   StorageHelper *storeHelper;
@property (retain, nonatomic)   NSString *nextReceptorUserName;
@property (retain, nonatomic)   NSString *nextReceptorUserID;

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

-(IBAction)setLevel:(id)sender;
-(IBAction)setType:(id)sender;
-(IBAction)setNextReceptor:(id)sender;
-(IBAction)writeOpinion:(id)sender;

- (void) beginDownloadWithID:(NSString *)ID;

-(void) showMediaWithFile:(NSString *) fileName1;
-(void) sendContents;
-(void) initForm;
-(void) submitDoc;

-(void) saveDoc;
-(void) shareToWB;
-(void) passAudit;
-(void) goBack;

- (UIImage *)scaleAndRotateImage:(UIImage *)image;

@end
