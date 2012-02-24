//
//  NewsAllocListViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsAllocListViewController.h"
#import "NewsClueSearchViewController.h"
#import "NewsAllocDetailViewController.h"
#import "NewsClueDetailViewController.h"
#import "NewsAllocSearchViewController.h"

@implementation NewsAllocListViewController
@synthesize cluedistRequest,schCluedistInfo;

#pragma mark -
#pragma mark View lifecycle
-(void)searchNews
{
	NewsAllocSearchViewController *viewCtrl = [[NewsAllocSearchViewController alloc] initWithNibName:@"NewsAllocSearchViewController" bundle:nil] ;
	viewCtrl.nSearchType = SEARCHTYPE_ALLOC;
	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
}

- (void)back:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES];  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"新闻派单";
	self.navigationController.navigationBar.hidden=NO;
	
	UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle: @"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(searchNews)];
	searchButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=searchButton;
	[searchButton release];
    
    //init the search clue entity,如果没有搜索条件，就搜索全部资料，否测以这个实体内容去搜索
    if (schCluedistInfo == nil) {
        schCluedistInfo = [[ClueDistInfo alloc] init];
        schCluedistInfo.title = @"";
        schCluedistInfo.keyword = @"";
        schCluedistInfo.note = @"";
        schCluedistInfo.status = @"";
        schCluedistInfo.begtimeshow = @"";
        schCluedistInfo.endtimeshow =@"";
        schCluedistInfo.type = @"";
    }
    
    //reload the data from server
    cluedistRequest = [[ClueDistRequest alloc] init];
    cluedistRequest.delegate = self;
    [cluedistRequest getListWithTitle:schCluedistInfo.title Keyword:schCluedistInfo.keyword Note:schCluedistInfo.note Status:schCluedistInfo.status BegTime:schCluedistInfo.begtimeshow EndTime:schCluedistInfo.endtimeshow Type:schCluedistInfo.type];
	
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

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [dataArray count];;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...

    
    // Configure the cell...
    //转换对像为实体
    ClueDistInfo *cluedistInfo = (ClueDistInfo *)[dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cluedistInfo.title;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.text = cluedistInfo.begtimeshow;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    //cell.backgroundColor = [UIColor grayColor];
    //0草稿、1提交待派发、2已派发
    switch ([cluedistInfo.status intValue]) {
        case 0:
            [cell.imageView setImage:[UIImage imageNamed:@"red.png"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] | [%@]",cluedistInfo.begtimeshow,@"草稿"];
            break;
        case 1:
            [cell.imageView setImage:[UIImage imageNamed:@"yellow.png"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] | [%@]",cluedistInfo.begtimeshow,@"提交待派发"];
            break;
        case 2:
            [cell.imageView setImage:[UIImage imageNamed:@"blue.png"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] | [%@]",cluedistInfo.begtimeshow,@"已派发"];
            break;            
        default:
            break;
    }

    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)parserDetailDidFinished:(ClueDistInfo *)clueDistInfo{

    NewsAllocDetailViewController *newsAllocDetailCtrl = [[NewsAllocDetailViewController alloc] initWithNibName:@"NewsAllocDetailViewController" bundle:nil];
    
    newsAllocDetailCtrl.cluedistInfo = [clueDistInfo retain];
    newsAllocDetailCtrl.clueKeyid = clueDistInfo.keyid;
    [self.navigationController pushViewController:newsAllocDetailCtrl animated:YES];
    [newsAllocDetailCtrl release];

}

- (void)parserListDidFinished:(NSArray *)distList{
    dataArray = [distList retain];
    [self.tableView reloadData];
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    cluedistRequest = [[ClueDistRequest alloc] init];
    cluedistRequest.delegate = self;
    ClueDistInfo *cluedistInfo = [dataArray objectAtIndex:indexPath.row];
    [cluedistRequest getDetailWithKeyID:cluedistInfo.keyid];
    
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

    [dataArray release];
    [super dealloc];
}


@end

