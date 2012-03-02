//
//  NewsCLueListViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsCLueListViewController.h"
#import "NewsClueSearchViewController.h"
#import "NewsClueDetailViewController.h"
#import "UITableViewCellEx.h"
#import "ClueWriteDetailViewController.h"
#import "NewsClueInfo.h"

@implementation NewsCLueListViewController
@synthesize dataArray;
@synthesize schNewsclueInfo;

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

-(void)segmentAction:(id)sender
{
    segmentCtrl = (UISegmentedControl *)sender;
    if (segmentCtrl.selectedSegmentIndex == 0) {
        NewsClueDetailViewController *clueDetailCtrl = [[NewsClueDetailViewController alloc] initWithNibName:@"NewsClueDetailViewController" bundle:nil];
        clueDetailCtrl.isAddNewsClue = YES;
        [self.navigationController pushViewController:clueDetailCtrl animated:YES];
        [clueDetailCtrl release];
    }
    
    if (segmentCtrl.selectedSegmentIndex == 1) {
        NewsClueSearchViewController *viewCtrl = [[NewsClueSearchViewController alloc] initWithNibName:@"NewsClueView" bundle:nil] ;
        viewCtrl.newsclueInfo = schNewsclueInfo;
        viewCtrl.nSearchType = SEARCHTYPE_CLUE;
        [self.navigationController pushViewController:viewCtrl animated:YES];
        [viewCtrl release];
    }

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

-(void)viewDidLoad{
    [super viewDidLoad];
    
    newsclueRequest = [[NewsClueRequest alloc] init];
    newsclueRequest.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"新闻线索";
	self.navigationController.navigationBar.hidden=NO;

    segmentCtrl= [[UISegmentedControl alloc]
                 initWithFrame:CGRectMake(225.0f, 6.0, 90.0f, 32.0f)];
	[segmentCtrl insertSegmentWithTitle:@"增加" atIndex:0 animated:YES]; 
	[segmentCtrl insertSegmentWithTitle:@"搜索" atIndex:1 animated:YES];	
	segmentCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
	[segmentCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentCtrl.selectedSegmentIndex = -1;
	[self.navigationController.navigationBar addSubview: segmentCtrl];
    
    //init the search clue entity,如果没有搜索条件，就搜索全部资料，否测以这个实体内容去搜索
    if (schNewsclueInfo == nil) {
        schNewsclueInfo = [[NewsClueInfo alloc] init];
        schNewsclueInfo.title = @"";
        schNewsclueInfo.keyword = @"";
        schNewsclueInfo.note = @"";
        schNewsclueInfo.status = @"";
        schNewsclueInfo.begtimeshow = @"";
        schNewsclueInfo.endtimeshow =@"";
        schNewsclueInfo.type = @"";
    }

    //reload the data from server
    if (newsclueRequest == nil) {
        newsclueRequest = [[NewsClueRequest alloc] init];
        newsclueRequest.delegate = self;
    }
    [newsclueRequest getNewsClueListWithTitle:schNewsclueInfo.title
                                      Keyword:schNewsclueInfo.keyword
                                         Note:schNewsclueInfo.note
                                       Status:schNewsclueInfo.status
                                      Begtime:schNewsclueInfo.begtimeshow
                                      Endtime:schNewsclueInfo.endtimeshow
                                         Type:schNewsclueInfo.type];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    
    for (UIView *views in self.navigationController.navigationBar.subviews) {
        if ([views isKindOfClass:[UISegmentedControl class]]) {
            [views removeFromSuperview];
        }
    }

    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [dataArray count];
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //[cell setBackgroundImageByName:@"list_item_background.png"];

    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    //转换对像为实体
    NewsClueInfo *newclueInfo = [[NewsClueInfo alloc] init];
    newclueInfo = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = newclueInfo.title;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.text = newclueInfo.begtimeshow;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    //cell.backgroundColor = [UIColor grayColor];
    //0草稿、1提交待派发、2已派发
    switch ([newclueInfo.status intValue]) {
        case 0:
            [cell.imageView setImage:[UIImage imageNamed:@"red.png"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] | [%@]",newclueInfo.begtimeshow,@"草稿"];
            break;
        case 1:
            [cell.imageView setImage:[UIImage imageNamed:@"yellow.png"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] | [%@]",newclueInfo.begtimeshow,@"提交待派发"];
            break;
        case 2:
            [cell.imageView setImage:[UIImage imageNamed:@"blue.png"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] | [%@]",newclueInfo.begtimeshow,@"已派发"];
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


-(void)dataDidResponsed:(NSArray *)newsCLueInfoArray flag:(int)flag{
    
    if(flag == kFlag_NewsClue_Detail ) {
        
        NewsClueDetailViewController *newClueDetailCtrl = [[NewsClueDetailViewController alloc] initWithNibName:@"NewsClueDetailViewController" bundle:nil];
        
        newClueDetailCtrl.newsclueInfo = [newsCLueInfoArray objectAtIndex:0];
        [self.navigationController pushViewController:newClueDetailCtrl animated:YES];
        [newClueDetailCtrl release];
        
    }
    
    if(flag == kFlag_NewsClue_List ) {
        
        dataArray = newsCLueInfoArray;
        [self.tableView reloadData];
    }
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NewsClueInfo *newsclueInfo = [dataArray objectAtIndex:indexPath.row];
    [newsclueRequest getNewsClueDetailWithKeyID:newsclueInfo.keyid];
    
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
    [segmentCtrl release];
    [super dealloc];
}


@end

