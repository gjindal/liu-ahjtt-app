    //
//  NewsClueSearchViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsClueSearchViewController.h"


@implementation NewsClueSearchViewController
@synthesize scrollView,startTime,endTime,newsTitle,newsType,newsStatus,contents,btConfirm;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"搜索新闻线索";
	self.navigationController.navigationBar.hidden=NO;
	
		originalContentHeight = [scrollView contentSize].height;
	
}



/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[scrollView setContentSize:CGSizeMake(320, 1024)];
	
	[contents setFont:[UIFont fontWithName:nil size:14]];
	
	UIImageView *txtViewBkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18,240,284,118)];
	[txtViewBkImageView setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(txtViewBkImageView.image != nil)
		[self.contents setBackgroundColor:[UIColor clearColor]];
	
	[self.view insertSubview:txtViewBkImageView belowSubview:self.contents];
	[txtViewBkImageView release];
}

 
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];	
	return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {	
	[self scrollViewToCenterOfScreen:textField];
}


- (void) textViewDidBeginEditing: (UITextView *) textView { 
	[self scrollViewToCenterOfScreen:textView];
} 


- (void)scrollViewToCenterOfScreen:(UIView *)theView {  
	CGFloat viewCenterY = theView.center.y;  
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];  
	
	CGFloat availableHeight = applicationFrame.size.height - 264;  
	
	CGFloat y = viewCenterY - availableHeight / 2.0;// - 40;  
	if (y < 0) 
	{  
		y = 0;  
	}  
	
	
	[scrollView setContentOffset:CGPointMake(0, y) animated:YES];
	CGSize contentSize = [self.scrollView contentSize];
	contentSize.height += 264 - 25;
	
	if(contentSize.height <= (originalContentHeight + 264 - 25))
		[self.scrollView setContentSize:contentSize];
	
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
    [super dealloc];
}


@end
