//
//  NewsAllocSearchViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsAllocSearchViewController.h"
#import "NewsClueSearchViewController.h"
#import "NewsGatheringAppDelegate.h"
#import "DatePicker.h"
#import "UIAlertTableView.h"

#define START_TIME_PICKER   101
#define END_TIME_PICKER	    102


@implementation NewsAllocSearchViewController

@synthesize scrollView,startTime,endTime,newsTitle,newsType,newsStatus,contents,btConfirm,contentsBackground,typeArray,statusArray,lastIndexPath,newsKeyword,cluedistInfo;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	

    self.title= @"搜索新闻派单";
    bTimeAlertView = TRUE;
	self.navigationController.navigationBar.hidden=NO;
    originalContentHeight = [scrollView contentSize].height;
    
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    typeArray = appDelegate.typeArray;
    [newsType setTitle:[typeArray objectAtIndex:0] forState:UIControlStateNormal];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString*locationString=[formatter stringFromDate: [NSDate date]];
    [startTime setTitle:locationString forState:UIControlStateNormal];
    [endTime setTitle:locationString forState:UIControlStateNormal];
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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 500)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
    custTableView.delegate = self;
	self.newsTitle.delegate = self;
    self.newsKeyword.delegate = self;
    contents.delegate = self;
	
	keyboardShown = NO;  
    [self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[contentsBackground setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(contentsBackground.image != nil)
        [self.contents setBackgroundColor:[UIColor clearColor]];
    
    
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    isTextView = YES;
    activeView = textView;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    [textView resignFirstResponder];
    activeView = nil;
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

-(IBAction)setStartDateTime:(id)sender{
    
    bTimeAlertView = YES;
    DatePicker *startDatePicker = [[DatePicker alloc] initWithTitle:@"开始时间" 
                                                            message:@"\n\n\n\n\n\n\n\n" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"关闭" 
                                                  otherButtonTitles:@"确定",nil];
    startDatePicker.tag = START_TIME_PICKER;
    if(startTime.titleLabel.text.length > 0){
        startDatePicker.selectedDate = startTime.titleLabel.text;
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
    if(endTime.titleLabel.text.length > 0){
        startDatePicker.selectedDate = endTime.titleLabel.text;
    }
    [startDatePicker show];
    [startDatePicker release];
}

- (void)datePciker:(DatePicker *)datePicker didFinishedSelectDate:(NSString *)selectedDate {
    
	if([datePicker tag] == START_TIME_PICKER){
        
		startTime.titleLabel.textColor = [UIColor blackColor];
        [startTime setTitle:selectedDate forState:UIControlStateNormal];
        
	}
	
	if([datePicker tag] == END_TIME_PICKER){
		
		endTime.titleLabel.textColor = [UIColor blackColor];
		[endTime setTitle:selectedDate forState:UIControlStateNormal];
        
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
    return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    // Configure the cell...
	
	NSUInteger row = [indexPath row];
	NSUInteger oldRow = [lastIndexPath row];
	cell.textLabel.text = [array objectAtIndex:row];
	cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (bTimeAlertView) {
        return;
    }
    if (buttonIndex == 1) {
        
        if (tableType == TABLETYPE_CLUETYPE) {
            [newsType setTitle:tmpCellString forState:UIControlStateNormal];
            //newsType.titleLabel.text =  tmpCellString;
        }
        if (tableType == TABLETYPE_CLUESTATUS) {
            [newsStatus setTitle:tmpCellString forState:UIControlStateNormal];
            //newsStatus.titleLabel.text = tmpCellString;
        }
    }
	printf("User Pressed Button %d\n",buttonIndex+1);
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
		
		NSLog(@"-----text---,%@",newCell.textLabel.text);
	}
	
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(IBAction)setType:(id)sender{
    
    bTimeAlertView = NO;
    tableType = TABLETYPE_CLUETYPE;
    //TEST DATA
    
    if (tmpCellString == nil) {
        tmpCellString = [[NSString alloc] initWithString:@""];
    }
    if (array == nil) {
        array = [[NSArray alloc] initWithArray:typeArray];
    }

    UIAlertTableView *alert = [[UIAlertTableView alloc] initWithTitle:@"选择线索类型"
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

-(IBAction)setStatus:(id)sender{
    
    bTimeAlertView = NO;
    tableType = TABLETYPE_CLUESTATUS;
    //TEST DATA
    statusArray = [[NSArray alloc] initWithObjects:@"已处理",@"未处理", nil ];
    
    tmpCellString = [[NSString alloc] initWithString:@""];
    
    array = [[NSArray alloc] initWithArray:statusArray];
    
    UIAlertTableView *alert = [[UIAlertTableView alloc] initWithTitle:@"选择线索状态"
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


- (IBAction)confirm{
    
    cluedistInfo.title = self.newsTitle.text;
    cluedistInfo.type = self.newsType.titleLabel.text;
    cluedistInfo.status = self.newsStatus.titleLabel.text;
    cluedistInfo.keyword = self.newsKeyword.text;
    cluedistInfo.begtimeshow = self.startTime.titleLabel.text;
    cluedistInfo.endtimeshow = self.endTime.titleLabel.text;
    cluedistInfo.note = self.contents.text;
    
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
    //[array release];
    //[statusArray release];
    //[typeArray release];
    [scrollView release];
    [super dealloc];
}


@end
