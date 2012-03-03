//
//  DocSearchViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DocSearchViewController.h"
#import "DatePicker.h"
#import "UIAlertTableView.h"
#import "NewsGatheringAppDelegate.h"
#import "ContributeInfo.h"

#define START_TIME_PICKER   101
#define END_TIME_PICKER	    102

@implementation DocSearchViewController
@synthesize btType;
@synthesize btConfirm;
@synthesize btEndTime;
@synthesize btStartTime;
@synthesize fdTitle;
@synthesize fdKeyword;
@synthesize bTimeAlertView;
@synthesize contributeInfo;;
@synthesize lastIndexPath;
@synthesize tmpCellString;
@synthesize typeArray;
@synthesize strEndTime;
@synthesize strStartTime;


-(IBAction) confirm:(id)sender{

    contributeInfo.title = self.fdTitle.text;
    contributeInfo.keyword = self.fdKeyword.text;
    strStartTime = self.btStartTime.titleLabel.text;
    strEndTime = self.btEndTime.titleLabel.text;
    
    int level = [typeArray indexOfObject:self.btType.titleLabel.text]+1;
    contributeInfo.type = [NSString stringWithFormat:@"%d",level];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //仅初始化搜索需要的关键字
        if ( contributeInfo == nil) {
            contributeInfo = [[ContributeInfo alloc] init];
            contributeInfo.title = @"";
            contributeInfo.type = @"";
            contributeInfo.keyword = @"";
        }
        strStartTime = @"";
        strEndTime = @"";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = @"稿件搜索";
    
    bTimeAlertView = TRUE;
    [activeField resignFirstResponder];
    activeField = nil;
    
    //取新闻类型
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    typeArray = appDelegate.typeArray;
    
    [btType setTitle:[typeArray objectAtIndex:0] forState:UIControlStateNormal];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString*locationString=[formatter stringFromDate: [NSDate date]];
    [btStartTime setTitle:locationString forState:UIControlStateNormal];
    [btEndTime setTitle:locationString forState:UIControlStateNormal];
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    

    CGRect textFieldRect = [activeField frame];
    [scrollView scrollRectToVisible:textFieldRect animated:YES];
    
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    isTextView = NO;
    activeField = textField;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [activeField resignFirstResponder];
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [activeField resignFirstResponder];
    activeField = nil;
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UIView *subView in scrollView.subviews) {
        if([subView isKindOfClass:[UITextView class]]) {
            
            [subView resignFirstResponder];
        }
        
        if([subView isKindOfClass:[UITextField class]]) {
            
            [subView resignFirstResponder];
        }
    }
}

#pragma mark - click event
-(IBAction)setStartDateTime:(id)sender{
    
    bTimeAlertView = YES;
    DatePicker *startDatePicker = [[DatePicker alloc] initWithTitle:@"开始时间" 
                                                            message:@"\n\n\n\n\n\n\n\n" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"关闭" 
                                                  otherButtonTitles:@"确定",nil];
    startDatePicker.tag = START_TIME_PICKER;
    if(btStartTime.titleLabel.text.length > 0){
        startDatePicker.selectedDate = btStartTime.titleLabel.text;
    }
    [startDatePicker show];
    [startDatePicker release];
}

-(IBAction)setEndDateTime:(id)sender{
    
    bTimeAlertView = YES;
    DatePicker *startDatePicker = [[DatePicker alloc] initWithTitle:@"开始时间" 
                                                            message:@"\n\n\n\n\n\n\n\n" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"关闭" 
                                                  otherButtonTitles:@"确定",nil];
    startDatePicker.tag = END_TIME_PICKER;
    if(btEndTime.titleLabel.text.length > 0){
        startDatePicker.selectedDate = btEndTime.titleLabel.text;
    }
    [startDatePicker show];
    [startDatePicker release];
}

- (void)datePciker:(DatePicker *)datePicker didFinishedSelectDate:(NSString *)selectedDate {
    
	if([datePicker tag] == START_TIME_PICKER){
        
		btStartTime.titleLabel.textColor = [UIColor blackColor];
        [btStartTime setTitle:selectedDate forState:UIControlStateNormal];
        
	}
	
	if([datePicker tag] == END_TIME_PICKER){
		
		btEndTime.titleLabel.textColor = [UIColor blackColor];
		[btEndTime setTitle:selectedDate forState:UIControlStateNormal];
        
	}
}

-(IBAction)setType:(id)sender{
    
    bTimeAlertView = NO;
    
    tmpCellString = [[NSString alloc] initWithString:@""];
    
    UIAlertTableView *alert = [[UIAlertTableView alloc] initWithTitle:@"选择稿件类型"
															  message:nil
															 delegate:self
													cancelButtonTitle:@"取消"
													otherButtonTitles:@"完成", nil];
	alert.tableDelegate = self;
	alert.dataSource = self;
	alert.tableHeight = 120;
	[alert show];
	[alert release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (bTimeAlertView) {
        return;
    }
    if (buttonIndex == 1) {
        [btType setTitle:tmpCellString forState:UIControlStateNormal];
    }
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [typeArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.text = [typeArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
	
	NSUInteger row = [indexPath row];
	NSUInteger oldRow = [lastIndexPath row];
	cell.textLabel.text = [typeArray objectAtIndex:row];
	cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	//NSInteger row=[indexPath row];
	
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//NSLog(@"----hello----,%@",indexPath);
	return indexPath;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int newRow = [indexPath row];
	int oldRow = [lastIndexPath row];
    
	if ((newRow == 0 && oldRow == 0) || (newRow != oldRow)){
		
		UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
		newCell.accessoryType = UITableViewCellAccessoryCheckmark;
		//newCell.textLabel.textColor=[UIColor redColor];
		
		UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath]; 
		oldCell.accessoryType = UITableViewCellAccessoryNone;
		//oldCell.textLabel.textColor=[UIColor blackColor];
		lastIndexPath = [indexPath retain];	
        
        tmpCellString = newCell.textLabel.text;
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 480)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
    custTableView.delegate = self;
	self.fdTitle.delegate = self;
    self.fdKeyword.delegate = self;
	
	keyboardShown = NO;  
    [self performSelector:@selector(registerForKeyboardNotifications)]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
