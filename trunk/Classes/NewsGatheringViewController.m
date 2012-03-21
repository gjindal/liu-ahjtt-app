//
//  NewsGatheringViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-5.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "NewsGatheringViewController.h"
#import "MD5EncryptProcess.h"
#import "MainPanelViewController.h"
#import "NewsGatheringAppDelegate.h"
#import "NetRequest.h"
#import "LoginResultInfo.h"

#import <QuartzCore/QuartzCore.h>

@interface NewsGatheringViewController (PrivateMethods)

- (void)alertInfo:(NSString *)info;

@end

@implementation NewsGatheringViewController
@synthesize fdUsername;
@synthesize fdUserpassword;


////////////////

- (void) activateWWAN {
	NSError *err = nil;
	NSHTTPURLResponse *res = nil;
	NSURL * url = [[NSURL alloc] initWithString:@"http://www.google.com"];
	NSMutableURLRequest *req = [NSMutableURLRequest
								requestWithURL:url
								cachePolicy:NSURLRequestReloadIgnoringCacheData
								timeoutInterval:5];	
	
	NSData * data = [NSURLConnection sendSynchronousRequest:req
                                          returningResponse:&res
                                                      error:&err];
	
	NSLog(@"%d",[data length]);
	[url release];
}

-(NSData *) login:(NSString *)username andpassword:(NSString *)password{
	
    NewsGatheringAppDelegate *appDelegate = (NewsGatheringAppDelegate *)[[UIApplication sharedApplication] delegate];
    
//	NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@",username,[MD5EncryptProcess md5:password]];
    NSString *post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@&token=%@",username,[MD5EncryptProcess md5:password],appDelegate.strDeviceToken];
    NSLog(@"%@", [MD5EncryptProcess md5:password]);
    NSString *url = [[NSString alloc] initWithFormat:kInterface_Login];

    if (netRequest == nil) {
        netRequest = [[NetRequest alloc] init];
    }
    netRequest.delegate = self;
	NSData *returnData = [netRequest PostData:url withRequestString:post];    
    //记下用户名密码，以便发送请求时带上
	appDelegate.username = username;
    appDelegate.password = [MD5EncryptProcess md5:password];

	[post release]; 
    [url release];
	return returnData;

}

-(void)didFinishedRequest:(NSData *)result{
    NSData *returnData = [result retain];

    NSString *strResult = [[NSString alloc] initWithData:returnData
											 encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", strResult);
    
    _loginParserHelper = [[LoginParserHelper alloc] init];
    _loginParserHelper.delegate = self;
    [_loginParserHelper startWithString:strResult];
}

- (void) setUserFunction{

    //取新闻类型
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.typeArray = [[NSMutableArray alloc] init];
    appDelegate.levelArray = [[NSMutableArray alloc] init];
    for (DirtInfo *dirInfo  in appDelegate.loginSuccessInfo.dictList) {
        if( [dirInfo.dic_desc isEqualToString:@"新闻类型"]){
            [appDelegate.typeArray addObject:dirInfo.dic_value];
        }
        if ([dirInfo.dic_desc isEqualToString:@"审批流程"]) {
            [appDelegate.levelArray addObject:dirInfo];
        }
    }

}

/////////////////////////////

- (void)keyboardWillShow:(NSNotification *)noti
{        
	//键盘输入的界面调整        
	//键盘的高度
	float height = 216.0;                
	CGRect frame = self.view.frame;        
	frame.size = CGSizeMake(frame.size.width, frame.size.height - height);        
	[UIView beginAnimations:@"Curl"context:nil];//动画开始          
	[UIView setAnimationDuration:0.30];           
	[UIView setAnimationDelegate:self];          
	[self.view setFrame:frame];         
	[UIView commitAnimations];         
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UIView *subView in self.view.subviews) {
        if([subView isKindOfClass:[UITextView class]]) {
            
            [subView resignFirstResponder];
        }
        
        if([subView isKindOfClass:[UITextField class]]) {
            
            [subView resignFirstResponder];
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{        
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.        
    NSTimeInterval animationDuration = 0.30f;        
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];        
    [UIView setAnimationDuration:animationDuration];        
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);        
    self.view.frame = rect;        
    [UIView commitAnimations];        
    [textField resignFirstResponder];
    return YES;        
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{        

	CGRect frame = textField.frame;
	int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
	NSTimeInterval animationDuration = 0.30f;                
	[UIView beginAnimations:@"ResizeForKeyBoard" context:nil];                
	[UIView setAnimationDuration:animationDuration];
	float width = self.view.frame.size.width;                
	float height = self.view.frame.size.height;        
	if(offset > 0)
	{
		CGRect rect = CGRectMake(0.0f, -offset,width,height);                
		self.view.frame = rect;        
	}        
	[UIView commitAnimations];                
}

//按下记住用户名按钮
-(IBAction)remPressed{
	if (isRemember) {
		isRemember = NO;
		[rememberOrNot setBackgroundImage: [UIImage imageNamed:@"box2"] forState:UIControlStateNormal];
	}else {
		isRemember = YES;
		[rememberOrNot setBackgroundImage: [UIImage imageNamed:@"box1"] forState:UIControlStateNormal];
	}
	
}

-(IBAction)loginSystem:(id)sender{
	
	[fdUsername resignFirstResponder];
    [fdUserpassword resignFirstResponder];

    if([fdUsername.text length] < 1) {
        
        [self alertInfo:@"用户名不可为空!"];
        return;
    }
    
    if([fdUserpassword.text length] < 1) {
        
        [self alertInfo:@"密码不可为空!"];
        return;
    }
    
    if(isRemember){
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"IsRemember"];
        
        NSString *  newValue;
        NSString *  oldValue;
        
        newValue = fdUsername.text;
        oldValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
        if ( ! [newValue isEqual:oldValue] ) {
            [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:@"Username"];
        }
        
        newValue = fdUserpassword.text;
        oldValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];
        if ( ! [newValue isEqual:oldValue] ) {
            [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:@"Password"];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"IsRemember"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Username"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Password"];
    }
    
	
	NSData *resultData = [self login:fdUsername.text andpassword:fdUserpassword.text];
//	NSString *result = [[NSString alloc] initWithData:resultData
//											 encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@", result);
//    
//    _loginParserHelper = [[LoginParserHelper alloc] init];
//    _loginParserHelper.delegate = self;
//    [_loginParserHelper startWithString:result];
    
}

-(void) saveLoginInfo{
  
}

-(IBAction) telService{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",btTel.titleLabel.text]]];

}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden=YES;
	fdUserpassword.secureTextEntry=YES;
	
    NSString *strRemember = [[NSUserDefaults standardUserDefaults] stringForKey:@"IsRemember"];
	if ([strRemember isEqualToString:@"YES"]) {
		[rememberOrNot setBackgroundImage: [UIImage imageNamed:@"box1"] forState:UIControlStateNormal];
        self.fdUsername.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
        self.fdUserpassword.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];
        
	}else {
        self.fdUsername.text = @"";
        self.fdUserpassword.text = @"";
		[rememberOrNot setBackgroundImage: [UIImage imageNamed:@"box2"] forState:UIControlStateNormal];
	}
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		//isRemember=YES


    }
    return self;
}

- (void)parserDeptDidFinished:(NSArray *)deptList{
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.deptArray =[[NSMutableArray alloc] initWithArray:deptList];
}

#pragma -
#pragma LoginParserHelper Delegate.

- (void)parserDidFinished:(LoginResultInfo *)resultInfo {

    if(resultInfo != nil) {
    
        if(resultInfo.isLoginSuccess == YES) {
            
            
            cluedistRequest = [[ClueDistRequest alloc] init];
            cluedistRequest.delegate = self;
            [cluedistRequest getDept];
            
            NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            appDelegate.loginSuccessInfo = (LoginSuccessInfo *)resultInfo;
            appDelegate.loginId = [appDelegate.loginSuccessInfo.id retain];
            appDelegate.ftpInfo = [appDelegate.loginSuccessInfo.ftpInfo retain];
            //appDelegate.ftpInfo.ftpURL = [NSString stringWithFormat:@"ftp://%@",appDelegate.ftpInfo.ftpURL];
            
            MainPanelViewController *viewCtrl = [[MainPanelViewController alloc] initWithNibName:@"MainPanelView" bundle:nil] ;
            
            CATransition *transition = [CATransition animation];
            transition.duration = 1.2f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            transition.type = @"cube";
            transition.subtype = kCATransitionFromRight;
            transition.delegate = self;
            
            [self setUserFunction];
            
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            
            
            [self.navigationController pushViewController:viewCtrl animated:YES];
            [viewCtrl release];
        }else {
        
            NSString *alertMessage = [resultInfo.message stringByAppendingString:@"!"];
            [self alertInfo:alertMessage];
        }
    }
}

#pragma -
#pragma Private Methods.

- (void)alertInfo:(NSString *)info {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:info
                                                       delegate:nil 
                                              cancelButtonTitle:@"关闭" 
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	fdUsername.delegate = self;
	fdUserpassword.delegate = self;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    if(!isRemember){
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Username"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Password"];
    }
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}

@end
