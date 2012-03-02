//
//  RecycleListViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RecycleListViewController.h"
#import "DocWriteDetailViewController.h"

#import "CycleTableViewCell.h"

@interface RecycleListViewController (PrivateMethods)

- (void)getAllCycleList;

@end

@implementation RecycleListViewController


#pragma mark -
#pragma mark View lifecycle

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

- (void)viewDidLoad {

    [super viewDidLoad];
    
    _docRequest = [[DocRequest alloc] init];
    _docRequest.delegate = self;
    
    _dataArray = [[NSMutableArray alloc]  initWithCapacity:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"回收站";
	self.navigationController.navigationBar.hidden=NO;
	
	UIBarButtonItem *cleanButton=[[UIBarButtonItem alloc]initWithTitle: @"清空" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteAll)];
	cleanButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=cleanButton;
	[cleanButton release];
    
    [self getAllCycleList];
}

#pragma -
#pragma Public Methods.

-(void)deleteAll {
    
    for (ContributeInfo *info in _dataArray) {
        [_docRequest removeDocWithConid:info.conid];
    }
    
    [self getAllCycleList];
}

- (void)back:(id)sender {  
    
    [self.navigationController popViewControllerAnimated:YES];  
}

#pragma -
#pragma Private Methods.

- (void)getAllCycleList {

    [_docRequest getCycleListWithTitle:nil Keyword:nil Type:@"1" Begtime:nil Endtime:nil];
}

#pragma -
#pragma DocRequestDelegate Support.

- (void)getCycleListDidFinished:(NSArray *)docList {

    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:docList];
    [self.tableView reloadData];
}

- (void)resumeDocDidFinished:(ContributeInfo *)contributeInfo {

}

- (void)removeDocDidFinished:(ContributeInfo *)contributeInfo {

}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_dataArray count];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

    return @"操作";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CycleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
//    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    ContributeInfo *contributeInfo = (ContributeInfo *)[_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = contributeInfo.title;
    cell.detailTextLabel.text = contributeInfo.time;
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"彻底删除" otherButtonTitles:@"还原", nil];
        actionSheet.tag = indexPath.row;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }   
}

#pragma -
#pragma UIActionSheetDelegate Support.

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    int nIndex = actionSheet.tag;
    if(nIndex + 1 > [_dataArray count])
        return;
    
    ContributeInfo *contributeInfo = [_dataArray objectAtIndex:nIndex];
    
    switch (buttonIndex) {
        case 0:
            [_docRequest removeDocWithConid:contributeInfo.conid];
            break;
        case 1:
            [_docRequest resumeDocWithConid:contributeInfo.conid];
            break;
        default:
            break;
    }
    
    [self getAllCycleList];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

