//
//  ClueWriteDetailViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClueWriteDetailViewController.h"
#import "MyAlertView.h"
#import "NetRequest.h"
#import "NewsGatheringAppDelegate.h"
#import "UIAlertTableView.h"


@implementation ClueWriteDetailViewController
@synthesize clueType,clueTitle,contents,scrollView,lastIndexPath;

-(void)submitDoc{
    
    /*
     8080/editmobile/mobile/contriM!submit_pass.do稿件内容接口地址，
     参数userid用户编号，
     pwd加密密码，
     title标题，
     type稿件类型（字典表配置），
     keyword关键字，
     source稿源，
     note内容，
     level稿件审批流程（字典表配置），
     flowid稿件与附件关联表，要求上传时候能有对应的处理。
     */
    
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	
	//appDelegate.networkActivityIndicatorVisible = YES;
    
    /*
	NSString *post = [[NSString alloc] initWithFormat:@"&userid=%@&pwd=%@&title=%@&type=%@&keyword=%@&source=%@&note=%@&level=%@&flowid=%@",appDelegate.username,appDelegate.password,fdTitle.text,fdDocType.text,fdKeyword.text,fdDocSource.text,contents.text,@"2",@"1234567890123456"];
    NSString *url = [[NSString alloc] initWithFormat:@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submit_pass.do"];
    
	NSData *returnData = [NetRequest PostData:url withRequestString:post];    
    
    NSString *result = [[NSString alloc] initWithData:returnData
											 encoding:NSUTF8StringEncoding];
	NSLog(@"Result = %@",result);
    // appDelegate.networkActivityIndicatorVisible = NO;
	[post release]; 
    [url release];*/
	return;
    
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
	
	self.title= @"线索撰写";
	self.navigationController.navigationBar.hidden=NO;
    UIBarButtonItem *submitButton;
    submitButton=[[UIBarButtonItem alloc]initWithTitle: @"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(submitDoc)];
	submitButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=submitButton;
	[submitButton release];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 460)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
	self.clueTitle.delegate = self;
    contents.delegate = self;
	
	keyboardShown = NO;  
    [self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[imgContentsBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgContentsBgd.image != nil)
        [self.contents setBackgroundColor:[UIColor clearColor]];
	
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
    if (buttonIndex == 1) {
        clueType.titleLabel.text =  tmpCellString;
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
	
}


-(IBAction)setType:(id)sender{
    
    //TEST DATA
    array = [[NSArray alloc] initWithObjects:@"类型1",@"类型2",@"类型3",@"类型4",nil];
    
    tmpCellString = [[NSString alloc] initWithString:@""];

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


#pragma mark - UITextField Delegate  
-(void)textFieldDidBeginEditing:(UITextField *)textField {  
    
    isTextView = NO;
    activeField = textField;  
}  

-(void)textFieldDidEndEditing:(UITextField *)textField {  
    activeField = nil;  
}  

-(BOOL)textFieldShouldReturn:(UITextField *)textField {  
    [textField resignFirstResponder];  
    return YES;  
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [activeView release];
    activeView = nil;
    isTextView = YES;
    activeView = [textView retain];
    return YES;
}

// Call this method somewhere in your view controller setup code.  
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
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
    
    keyboardShown = YES;
}

// Called when the UIKeyboardDidHideNotification is sent
- (void)keyboardWasHidden:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Reset the height of the scroll view to its original value
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height += keyboardSize.height;
    scrollView.frame = viewFrame;
    
    keyboardShown = NO;
}

- (void)dealloc {
    
    [super dealloc];
}
@end
