    //
//  NewsClueSearchViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsClueSearchViewController.h"


@implementation NewsClueSearchViewController
@synthesize scrollView,startTime,endTime,newsTitle,newsType,newsStatus,contents,btConfirm,nSearchType;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	switch (nSearchType) {
		case 1:
			self.title= @"搜索新闻线索";
			break;
		case 2:
			self.title= @"搜索新闻派单";
			break;
		default:
			break;
	}

	self.navigationController.navigationBar.hidden=NO;
	
    originalContentHeight = [scrollView contentSize].height;
    
    

}

#pragma -
#pragma Handler Keyboard.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (keyboardShown)
        return;
    
    NSDictionary* info = [aNotification userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Resize the scroll view (which is the root view of the window)
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height -= keyboardSize.height;
    scrollView.frame = viewFrame;
    
    // Scroll the active text field into view.
    if(isTextView) {
    
        CGRect textFieldRect = [activeView frame];
        [scrollView scrollRectToVisible:textFieldRect animated:YES];
    }else {
        CGRect textFieldRect = [activeField frame];
        [scrollView scrollRectToVisible:textFieldRect animated:YES];
    }
    
    
//    NSLog(@"%f %f", scrollView.contentSize.width, scrollView.contentSize.height);
//    CGSize size = scrollView.contentSize;
//    size.height -= keyboardSize.height;
//    scrollView.contentSize = size;
//    NSLog(@"%f %f", scrollView.contentSize.width, scrollView.contentSize.height);
    //[scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    keyboardShown = YES;
}


// Called when the UIKeyboardDidHideNotification is sent
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Reset the height of the scroll view to its original value
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height += keyboardSize.height;
    scrollView.frame = viewFrame;
    
    //[scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    keyboardShown = NO;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[contents setFont:[UIFont fontWithName:nil size:14]];
	
	UIImageView *txtViewBkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18,240,284,118)];
	[txtViewBkImageView setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(txtViewBkImageView.image != nil)
		[self.contents setBackgroundColor:[UIColor clearColor]];
	
	[self.view insertSubview:txtViewBkImageView belowSubview:self.contents];
	[txtViewBkImageView release];
    
    [btConfirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    startTime.delegate = self;
    endTime.delegate = self;
    newsTitle.delegate = self;
    newsType.delegate = self;
    newsStatus.delegate = self;
    contents.delegate = self;
    
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	[scrollView setContentSize:CGSizeMake(320, 416)];
    
    for (UIView *subView in self.view.subviews) {
//        if([subView isKindOfClass:[UITextField class]]){
//            ((UITextField *)subView).delegate = self;
//            NSLog(@"%@", subView);
//        }
        [scrollView addSubview:subView];
    }
    
    [scrollView addSubview:btConfirm];
    
    [self.view addSubview:scrollView];
    
    keyboardShown = NO;
    [self registerForKeyboardNotifications];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(isTextView) {
        
        [activeView resignFirstResponder];
        activeView = nil;
    }else {
    
        [activeField resignFirstResponder];
        activeField = nil;
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    
    if(isTextView) {
        
        [activeView resignFirstResponder];
        activeView = nil;
    }else {
        
        [activeField resignFirstResponder];
        activeField = nil;
    }
    
    [super viewWillDisappear:animated];
}
 
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
//	[theTextField resignFirstResponder];	
//	return YES;
//}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    isTextView = NO;
    activeField = textField;
    return YES;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//    [activeField resignFirstResponder];
//    activeField = nil;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [activeField resignFirstResponder];
    activeField = nil;
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    isTextView = YES;
    activeView = textView;
    return YES;
}

//- (void)textViewDidEndEditing:(UITextView *)textView {
//    
//    [textView resignFirstResponder];
//    activeView = nil;
//}

- (void)confirm{
    
    [self.navigationController popViewControllerAnimated:YES];
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
