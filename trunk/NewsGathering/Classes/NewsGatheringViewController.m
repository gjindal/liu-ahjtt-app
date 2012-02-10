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

#import <QuartzCore/QuartzCore.h>

@implementation NewsGatheringViewController
@synthesize fdUsername;
@synthesize fdUserpassword;




////////////////

-(NSData *) login:(NSString *)username andpassword:(NSString *)password{
	
	NSString *post = nil;  
	post = [[NSString alloc] initWithFormat:@"&usercode=%@&password=%@",@"1",[MD5EncryptProcess md5:password]];
	NSData *postData =[NSData dataWithBytes:[post UTF8String] length:[post length]];
	
	//[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];  
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
	[request setURL:[NSURL URLWithString:@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/loginM!submit.do"]];  
	[request setHTTPMethod:@"POST"]; 
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];  
	[request setHTTPBody:postData];  

	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse :nil error:nil];
	
	[post release]; 
	return returnData;

	
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

	/*
	NSData *resultData = [self login:fdUsername.text andpassword:fdUserpassword.text];
	NSString *result = [[NSString alloc] initWithData:resultData
											 encoding:NSUTF8StringEncoding];
	NSLog(@"Result = %@",result);
	
	*/
	MainPanelViewController *viewCtrl = [[MainPanelViewController alloc] initWithNibName:@"MainPanelView" bundle:nil] ;
	
	CATransition *transition = [CATransition animation];
	transition.duration = 1.2f;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	transition.type = @"cube";
	transition.subtype = kCATransitionFromRight;
	transition.delegate = self;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	
	
	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
	
	
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden=YES;
	fdUserpassword.secureTextEntry=YES;
	
	if (isRemember) {
		[rememberOrNot setBackgroundImage: [UIImage imageNamed:@"box1"] forState:UIControlStateNormal];
	}else {
		[rememberOrNot setBackgroundImage: [UIImage imageNamed:@"box2"] forState:UIControlStateNormal];
	}
}


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		isRemember=YES;

    }
    return self;
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
