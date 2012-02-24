//
//  NewsAllocDetailViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsAllocDetailViewController.h"
#import "ClueDistInfo.h"
#import "ClueDistRequest.h"
#import "NewsGatheringAppDelegate.h"

@implementation NewsAllocDetailViewController

@synthesize sendUserName;
@synthesize clueTitle;
@synthesize clueType;
@synthesize contents;
@synthesize btStartTime;
@synthesize btEndTime;
@synthesize clueKeyword;
@synthesize clueKeyid;
@synthesize imgContentsBgd;
@synthesize cluedistInfo;
@synthesize cluedistRequest;
@synthesize dispatchedUsers;


- (void)alertInfo:(NSString *)info withTitle:(NSString *)title{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:info
                                                       delegate:nil 
                                              cancelButtonTitle:@"关闭" 
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)parserDetailDidFinished:(ClueDistInfo *)clueDistInfo{
    
    self.cluedistInfo = [clueDistInfo retain];
}

- (void)parserSubmitDidFinished:(ResultInfo *)resultInfo{
    
    if ([resultInfo.flag isEqualToString:@"200"]) {
        [self alertInfo:@"派发成功." withTitle:nil];
        [self.navigationController popViewControllerAnimated:YES]; 
    }else{
        [self alertInfo:@"派发失败，请重试." withTitle:@"错误"];
    }
}

-(void)dispatchCLue{

    if ([dispatchedUsers length]<1) {
        [self alertInfo:@"请选择派发人！" withTitle:@"数据错误"];
        return;
    }
    [cluedistRequest getDispatchResult:clueKeyid withUsers:dispatchedUsers];
    [cluedistRequest release];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// 下一个界面的返回按钮  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
        temporaryBarButtonItem.title = @"返回";  
        temporaryBarButtonItem.target = self;  
        // temporaryBarButtonItem.action = @selector(back:);  
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
        [temporaryBarButtonItem release]; 
    }
    return self;
}

-(void)initForm{
    
    //取新闻类型
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    array = [[NSMutableArray alloc] init];
    for (DirtInfo *dirInfo  in appDelegate.loginSuccessInfo.dictList) {
        if( [dirInfo.dic_desc isEqualToString:@"新闻类型"]){
            [array addObject:dirInfo.dic_value];
        }
    }
    
    if (cluedistInfo != nil) {
    
        //当状态为1时才能修改或提交派发
        if ([cluedistInfo.status isEqualToString:@"1"]) {
            
            bEnableDispatch = YES;
            
            UIBarButtonItem *submitButton;
            submitButton=[[UIBarButtonItem alloc]initWithTitle: @"派发" style:UIBarButtonItemStyleBordered target:self action:@selector(dispatchCLue)];
            submitButton.style=UIBarButtonItemStylePlain;
            self.navigationItem.rightBarButtonItem=submitButton;
            [submitButton release];
        }
        else{
            bEnableDispatch = NO;
        }
        
    
        clueTitle.text = cluedistInfo.title;
        
        if ((cluedistInfo.type == nil) ||([cluedistInfo.type isEqualToString:@""]) ) {
            cluedistInfo.type = @"1";
        }
        clueType.text = [array objectAtIndex:[cluedistInfo.type intValue]-1];
        
        if ((cluedistInfo.begtimeshow == nil) || ([cluedistInfo.begtimeshow isEqualToString:@""])) {
            cluedistInfo.begtimeshow =@"2012-01-01 01:01:01";
        }
        if ((cluedistInfo.endtimeshow == nil) || ([cluedistInfo.endtimeshow isEqualToString:@""])) {
            cluedistInfo.endtimeshow =@"2012-01-01 01:01:01";
        }
        btStartTime.text = cluedistInfo.begtimeshow;
        btEndTime.text = cluedistInfo.endtimeshow;
        
        clueKeyword.text = cluedistInfo.keyword;
        contents.text = cluedistInfo.note;
    }    
    
}

-(void) getCLueInfo{
    
    [cluedistRequest getDetailWithKeyID:clueKeyid];
    [cluedistRequest release];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
	self.title= @"派单详情";
	self.navigationController.navigationBar.hidden=NO;
    
    cluedistRequest = [[ClueDistRequest alloc] init];
    cluedistRequest.delegate = self;
    
    [self getCLueInfo];
    [self initForm];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 500)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;

	//keyboardShown = NO;  
    //[self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[imgContentsBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgContentsBgd.image != nil)
        [self.contents setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    [cluedistInfo release];
    [cluedistRequest release];
    [super dealloc];
}


@end
