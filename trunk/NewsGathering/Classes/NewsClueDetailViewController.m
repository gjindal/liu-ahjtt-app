//
//  NewsClueDetailViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsClueDetailViewController.h"
#import "UIAlertTableView.h"
#import "DatePicker.h"
#import "UIAlertTableView.h"
#import "NewsGatheringAppDelegate.h"

#define START_TIME_PICKER   101
#define END_TIME_PICKER	    102

@implementation NewsClueDetailViewController
@synthesize scrollView;
@synthesize clueTitle;
@synthesize clueType;
@synthesize contents;
@synthesize imgContentsBgd;
@synthesize btConfirm;
@synthesize bEnableChange;
@synthesize btStartTime;
@synthesize btEndTime;
@synthesize clueKeyword;
@synthesize bEnableAudit;
@synthesize newsclueInfo;
@synthesize isAddNewsClue;


- (void)alertInfo:(NSString *)info withTitle:(NSString *)title{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:info
                                                       delegate:nil 
                                              cancelButtonTitle:@"关闭" 
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

-(void)dataDidResponsed:(NSArray *)newsCLueInfoArray flag:(int)flag{
    
    if(flag == kFlag_NewsClue_Update ) {
        if ([((NewsClueInfo *)[newsCLueInfoArray objectAtIndex:0]).flag isEqualToString:@"200"] ) {
            [self alertInfo:@"线索修改成功" withTitle:@""];
            [self.navigationController popViewControllerAnimated:YES];  
        } 
        else{
            [self alertInfo:@"线索修改失败" withTitle:@""];
        }
    }
    if(flag == kFlag_NewsClue_Add ) {
        if ([((NewsClueInfo *)[newsCLueInfoArray objectAtIndex:0]).flag isEqualToString:@"200"] ) {
            [self alertInfo:@"线索添加成功" withTitle:@""];
            [self.navigationController popViewControllerAnimated:YES];  
        } 
        else{
            [self alertInfo:@"线索添加失败" withTitle:@""];
        }
    }
    if(flag == kFlag_NewsClue_Submit ) {
        if ([((NewsClueInfo *)[newsCLueInfoArray objectAtIndex:0]).flag isEqualToString:@"200"] ) {
            [self alertInfo:@"线索提交成功" withTitle:@""];
            [self.navigationController popViewControllerAnimated:YES];  
        } 
        else{
            [self alertInfo:@"线索提交失败" withTitle:@""];
        }
    }
}

-(IBAction)confirmChanges:(id)sender{
    
    if ([clueTitle.text length]<1) {
        [self alertInfo:@"标题不能为空" withTitle:@"数据错误"];
        return;
    }
    if ([clueType.titleLabel.text length]<1) {
        [self alertInfo:@"类别不能为空" withTitle:@"数据错误"];
        return;
    }
    if ([btStartTime.titleLabel.text length]<1) {
        [self alertInfo:@"开时时间不能为空" withTitle:@"数据错误"];
        return;
    }
    if ([btEndTime.titleLabel.text length]<1) {
        [self alertInfo:@"结束时间不能为空" withTitle:@"数据错误"];
        return;
    }
    if ([clueKeyword.text length]<1) {
        [self alertInfo:@"关键字不能为空" withTitle:@"数据错误"];
        return;
    }
    if ([contents.text length]<1) {
        [self alertInfo:@"内容不能为空" withTitle:@"数据错误"];
        return;
    }
    if ([contents.text length]>2000) {
        [self alertInfo:@"内容不能超过2000字" withTitle:@"数据错误"];
        return;
    }
    
    NSInteger nType=1;
    for (NSString *temp in array) {
        if ([temp isEqualToString:clueType.titleLabel.text]) {
            break;
        }
        nType = nType+1;
    }
    NSString *strType = [[NSString alloc] initWithFormat:@"%d",nType];

    newsclueRequest = [[NewsClueRequest alloc] init];
    newsclueRequest.delegate = self;
    
    if (isAddNewsClue) {
        [newsclueRequest addNewsClueWithTitle:clueTitle.text Keyword:clueKeyword.text Note:contents.text Begtime:btStartTime.titleLabel.text Endtime:btEndTime.titleLabel.text Type:strType];
    }
    else{
        if ([newsclueInfo.keyid length]<1) {
            [self alertInfo:@"ID丢失，请返回重新进入修改！" withTitle:@"数据错误"];
            return;
        }
        [newsclueRequest updateNewsClueWithTitle:clueTitle.text Keyid:newsclueInfo.keyid Keyword:clueKeyword.text Note:contents.text Begtime:btStartTime.titleLabel.text Endtime:btEndTime.titleLabel.text Type:strType];
    }
    
    [newsclueRequest release];
}

-(void)passAudit{
    
    newsclueRequest = [[NewsClueRequest alloc] init];
    newsclueRequest.delegate = self;
    

    if ([newsclueInfo.keyid length]<1) {
            [self alertInfo:@"ID丢失，请返回重新进入修改！" withTitle:@"数据错误"];
            return;
        }
    [newsclueRequest submitNewsClueWithKeyID:newsclueInfo.keyid];
    [newsclueRequest release];
    
    [self.navigationController popViewControllerAnimated:YES];  

}

-(void) setChangeFunction{
    
    if (bEnableChange) {
        self.clueTitle.enabled = YES;
        self.clueType.enabled = YES;
        self.contents.editable = YES;
        self.btConfirm.hidden = NO;
        self.btConfirm.enabled = YES;
        self.btEndTime.enabled = YES;
        self.btStartTime.enabled = YES;
        self.clueKeyword.enabled = YES;
    }
    else{
        self.clueTitle.enabled = NO;
        self.clueType.enabled = NO;
        self.contents.editable = NO;
        self.btConfirm.enabled = NO;
        self.btConfirm.hidden = YES;
        self.btEndTime.enabled = NO;
        self.btStartTime.enabled = NO;
        self.clueKeyword.enabled = NO;
    }
    
    if (isAddNewsClue) {
        self.btConfirm.hidden = NO;
        self.clueType.enabled = YES;
    }
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
    //array =[[NSMutableArray alloc] init];
    array = appDelegate.typeArray;
    /*for (DirtInfo *dirInfo  in appDelegate.loginSuccessInfo.dictList) {
        if( [dirInfo.dic_desc isEqualToString:@"新闻类型"]){
            [array addObject:dirInfo.dic_value];
        }
    }*/
    
    if (newsclueInfo != nil) {
        
        NSLog(@"-----%@",newsclueInfo.status);
        //当状态为0时才能修改或提交派发
        if ([newsclueInfo.status isEqualToString:@"0"]) {
            self.bEnableChange = YES; 
            self.bEnableAudit = YES;
        }
        else{
            self.bEnableChange = NO; 
            self.bEnableAudit = NO;
        }
        
        clueTitle.text = newsclueInfo.title;
        
        if ((newsclueInfo.type == nil) ||([newsclueInfo.type isEqualToString:@""]) ) {
            newsclueInfo.type = @"1";
        }
        [clueType setTitle:[array objectAtIndex:[newsclueInfo.type intValue]-1] forState:UIControlStateNormal];
        if ((newsclueInfo.begtimeshow == nil) || ([newsclueInfo.begtimeshow isEqualToString:@""])) {
            newsclueInfo.begtimeshow =@"2012-01-01 01:01:01";
        }
        if ((newsclueInfo.endtimeshow == nil) || ([newsclueInfo.endtimeshow isEqualToString:@""])) {
            newsclueInfo.endtimeshow =@"2012-01-01 01:01:01";
        }
        [btStartTime setTitle:newsclueInfo.begtimeshow forState:UIControlStateNormal];
        [btEndTime setTitle:newsclueInfo.endtimeshow forState:UIControlStateNormal];
        
        clueKeyword.text = newsclueInfo.keyword;
        contents.text = newsclueInfo.note;
    }
    else if(isAddNewsClue){
        
        clueTitle.text = @"";
        clueKeyword.text = @"";
        contents.text = @"";
        
        [clueType setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];

        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString*locationString=[formatter stringFromDate: [NSDate date]];
        [btEndTime setTitle:locationString forState:UIControlStateNormal];
        [btStartTime setTitle:locationString forState:UIControlStateNormal];
        [formatter release];
        
        //新建的时候可以保存，不可以派发
        self.bEnableChange = YES; 
        self.bEnableAudit = NO;
    }
    
    if (bEnableAudit) {
        UIBarButtonItem *submitButton;
        submitButton=[[UIBarButtonItem alloc]initWithTitle: @"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(passAudit)];
        submitButton.style=UIBarButtonItemStylePlain;
        self.navigationItem.rightBarButtonItem=submitButton;
        [submitButton release];
    }

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
	self.title= @"线索详情";
	self.navigationController.navigationBar.hidden=NO;
    
    
    [self initForm];
    [self setChangeFunction];


}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 500)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
    //self.custTableView.delegate = self;
	self.clueTitle.delegate = self;
    self.contents.delegate = self;
    self.clueKeyword.delegate = self;
    
	
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
    if (bTimeAlertView) {
        return;
    }
    
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

- (void)datePciker:(DatePicker *)datePicker didFinishedSelectDate:(NSString *)selectedDate {
    
	if([datePicker tag] == START_TIME_PICKER){
        
		btStartTime.titleLabel.textColor = [UIColor blackColor];
        [btStartTime setTitle:selectedDate forState:UIControlStateNormal];
		//btStartTime.titleLabel.text = selectedDate;
		
	}
	
	if([datePicker tag] == END_TIME_PICKER){
		
		btEndTime.titleLabel.textColor = [UIColor blackColor];
        [btEndTime setTitle:selectedDate forState:UIControlStateNormal];
		//btEndTime.titleLabel.text = selectedDate;
        
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


-(IBAction)setType:(id)sender{
    
    bTimeAlertView = NO;
    
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
