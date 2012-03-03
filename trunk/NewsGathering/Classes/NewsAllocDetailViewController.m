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
#import "TreeViewController.h"
#import "DocWriteDetailViewController.h"

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
@synthesize dispatchedUsersName;
@synthesize dispatchedTableView;
@synthesize dispatchedArray;
@synthesize dispatchedUsersID;


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
    
    if ([dispatchedUsersID length]<1) {
        [self alertInfo:@"请选择派发人！" withTitle:@"数据错误"];
        return;
    }
    [cluedistRequest getDispatchResult:clueKeyid withUsers:dispatchedUsersID];

}

-(void)writeDoc{
    DocWriteDetailViewController *viewCtrl = [[DocWriteDetailViewController alloc] initWithNibName:@"DocWriteDetailViewController" bundle:nil] ;

	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];

}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// 下一个界面的返回按钮  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
        temporaryBarButtonItem.title = @"取消";  
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
            UIBarButtonItem *submitButton;
            submitButton=[[UIBarButtonItem alloc]initWithTitle: @"撰稿" style:UIBarButtonItemStyleBordered target:self action:@selector(writeDoc)];
            submitButton.style=UIBarButtonItemStylePlain;
            self.navigationItem.rightBarButtonItem=submitButton;
            [submitButton release];
            
        }
        
    
        clueTitle.text = cluedistInfo.title;
        sendUserName.text = cluedistInfo.sendUserName;
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
}

//通过代理方法获取组织结构中的选择的人员
- (void)passValue:(NSMutableArray *)value
{
    NSMutableArray *dispathedPersonInfo = value;
    int i = 0;
    for(UserInfo *userInfo in dispathedPersonInfo){
        if(i == 0){
            self.dispatchedUsersID = userInfo.userID;
            self.dispatchedUsersName = userInfo.userName;
        }else{
            self.dispatchedUsersName = [NSString stringWithFormat:@"%@,%@",self.dispatchedUsersName,userInfo.userName];
            self.dispatchedUsersID = [NSString stringWithFormat:@"%@,%@",self.dispatchedUsersID,userInfo.userID];
        }
        i++;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
	self.title= @"派单详情";
	self.navigationController.navigationBar.hidden=NO;
    
    cluedistRequest = [[ClueDistRequest alloc] init];
    cluedistRequest.delegate = self;
    dispatchedTableView.delegate = self;
    dispatchedTableView.dataSource = self;
    
    [self getCLueInfo];
    [self initForm];
    [self.dispatchedTableView reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 700)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;

	//keyboardShown = NO;  
    //[self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[imgContentsBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgContentsBgd.image != nil)
        [self.contents setBackgroundColor:[UIColor clearColor]];
    
    dispatchedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 465, 320, 120) style:UITableViewStyleGrouped];
    dispatchedTableView.delegate = self;
    dispatchedTableView.dataSource = self;
    [dispatchedTableView setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:dispatchedTableView];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"被派发人";
            break;
    }  
    return nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //[cell setBackgroundImageByName:@"list_item_background.png"];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    if ((dispatchedUsersName == nil) || [dispatchedUsersName isEqualToString:@""]) {
        cell.textLabel.text = @"选择派发人";
    }else{
        cell.textLabel.text = dispatchedUsersName;
    }
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeViewController *treeViewCtrl = [[TreeViewController alloc] init];
    treeViewCtrl.delegate = self;
    treeViewCtrl.titleText = [[NSString alloc] initWithFormat:@"选择派发人"];
    [self.navigationController pushViewController:treeViewCtrl animated:YES];
    [treeViewCtrl release];
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
    
    [dispatchedTableView release];
    //[cluedistInfo release];
    //[cluedistRequest release];
    [super dealloc];
}


@end
