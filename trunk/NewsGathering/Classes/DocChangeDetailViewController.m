//
//  DocChangeDetailViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DocChangeDetailViewController.h"


@implementation DocChangeDetailViewController

@synthesize fdTitle,fdAuthor,fdStatus,
			contents,btRecorder,btCamera,btVideo,
			scrollView,keyboardShown,activeField,
			attachTable,attachArray,lblMessage,txtMessage;


-(IBAction) getPhoto{
	
	
}

-(IBAction) getRecord{
	
	
}

-(IBAction) getVideo{
	
	
}

-(void)passDoc{
	
}


- (void)back:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES];  
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// 下一个界面的返回按钮  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
        temporaryBarButtonItem.title = @"返回";  
        temporaryBarButtonItem.target = self;  
        temporaryBarButtonItem.action = @selector(back:);  
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
        [temporaryBarButtonItem release]; 
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"稿件编辑";
	self.navigationController.navigationBar.hidden=NO;
	
	UIBarButtonItem *passButton=[[UIBarButtonItem alloc]initWithTitle: @"通过" style:UIBarButtonItemStyleBordered target:self action:@selector(passDoc)];
	passButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=passButton;
	[passButton release];
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//lblMessage = [[UILabel alloc]initWithFrame:CGRectMake(10.0,900.0, 200.0, 30.0)];
	//lblMessage.text = @"留言：";
	//[self.view addSubview:lblMessage];
	//txtMessage = [[UITextView alloc]initWithFrame:CGRectMake(10.0, 930.0, 300, 100)];
	//[self.view addSubview:txtMessage];
	
	[scrollView setContentSize:CGSizeMake(320, 1200)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
	self.fdTitle.delegate = self;
	self.fdAuthor.delegate = self;
	self.fdStatus.delegate = self;
	
	keyboardShown = NO;  
    [self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[imgContentsBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgContentsBgd.image != nil)
		[self.contents setBackgroundColor:[UIColor clearColor]];
	
	[imgMessageBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgMessageBgd.image != nil)
		[self.txtMessage setBackgroundColor:[UIColor clearColor]];
	
	self.attachArray = [NSArray arrayWithObjects:	@"Voice_2012-02-05 08:30:00",
						@"Video_2012_02-05 09:00:00",
						@"Image_2012_02-06 10:00:01",
						nil];
	
	self.attachTable.delegate = self;
	self.attachTable.dataSource = self;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.attachArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [self.attachArray objectAtIndex:indexPath.row];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	for (int i = 0; i < [self.attachArray count]; i++) {
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		if (i != indexPath.row) {
			//cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if (indexPath.row == 0) {
	}
	
	if (indexPath.row == 1) {
	}
	
	
}


#pragma mark - UITextField Delegate  
-(void)textFieldDidBeginEditing:(UITextField *)textField  
{  
    activeField = textField;  
}  

-(void)textFieldDidEndEditing:(UITextField *)textField  
{  
    activeField = nil;  
}  

-(BOOL)textFieldShouldReturn:(UITextField *)textField  
{  
    [textField resignFirstResponder];  
    return YES;  
}  

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scroll detected");
}

// 触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging  -  End of Scrolling.");
}

// 滚动停止时，触发该函数

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating  -   End of Scrolling.");
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation  -   End of Scrolling.");
}

// Call this method somewhere in your view controller setup code.  
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
    NSLog(@"-------");  
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
    CGRect textFieldRect = [activeField frame];  
    [scrollView scrollRectToVisible:textFieldRect animated:YES];  
	
    oldContentOffsetValue = [scrollView contentOffset].y;  
	
	
    CGFloat value = (activeField.frame.origin.y+scrollView.frame.origin.y+activeField.frame.size.height - self.view.frame.size.height + keyboardSize.height)+2.0f;  
    if (value > 0) {  
        [scrollView setContentOffset:CGPointMake(0, value) animated:YES];  
        isNeedSetOffset = YES;  
    }  
	
	
    keyboardShown = YES;  
}  


// Called when the UIKeyboardDidHideNotification is sent  
- (void)keyboardWasHidden:(NSNotification*)aNotification  
{  
	
    NSDictionary* info = [aNotification userInfo];  
	
    // Get the size of the keyboard.  
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];  
    CGSize keyboardSize = [aValue CGRectValue].size;  
	
    // Reset the height of the scroll view to its original value  
    CGRect viewFrame = [scrollView frame];  
    viewFrame.size.height += keyboardSize.height;  
    scrollView.frame = viewFrame;  
	
    if (isNeedSetOffset) {  
        [scrollView setContentOffset:CGPointMake(0, oldContentOffsetValue) animated:YES];  
    }  
	
    isNeedSetOffset = NO;  
	
    keyboardShown = NO;  
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}



@end
