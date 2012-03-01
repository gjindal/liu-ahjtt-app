//
//  DocChangeListViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DocChangeListViewController.h"
#import "DocChangeDetailViewController.h"
#import "DocSearchViewController.h"
#import "DocRequest.h"
#import "ContributeInfo.h"


@implementation DocChangeListViewController
@synthesize docDetail;
@synthesize docRequest;


#pragma mark -
#pragma mark View lifecycle

-(void)searchDocs{

    [self.navigationController pushViewController:docSearchVtrl animated:YES];

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

- (void)getAppListDidFinished:(NSArray *)docList{
    [dataArray removeAllObjects];
    //[dataArray arrayByAddingObjectsFromArray:docList];
    [dataArray addObjectsFromArray:docList];
    [self.tableView reloadData];
}

-(void) viewDidLoad{

    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    docRequest = [[DocRequest alloc] init];
    docRequest.delegate = self;    
    
    nextPage = NEXTPAGE_OTHERS;//
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"稿件管理";
	self.navigationController.navigationBar.hidden=NO;

        if (docSearchVtrl == nil) {
            docSearchVtrl = [[DocSearchViewController alloc] initWithNibName:@"DocSearchViewController" bundle:nil] ;
            docSearchVtrl.contributeInfo.title = @"";
            docSearchVtrl.contributeInfo.keyword = @"";
            docSearchVtrl.contributeInfo.type = @"";
            docSearchVtrl.strStartTime = @"";
            docSearchVtrl.strEndTime = @"";
        }
        [docRequest getAppListWithTitle:docSearchVtrl.contributeInfo.title
                            Keyword:docSearchVtrl.contributeInfo.keyword
                               Type:docSearchVtrl.contributeInfo.type
                            Begtime:docSearchVtrl.strStartTime
                            Endtime:docSearchVtrl.strEndTime];


   	UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle: @"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(searchDocs)];	
    searchButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=searchButton;
	[searchButton release];
    
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
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    ContributeInfo *contributeInfo = (ContributeInfo *)[dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = contributeInfo.title;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.text = contributeInfo.time;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];

    switch ([contributeInfo.status intValue]) {
        case 3:
            [cell.imageView setImage:[UIImage imageNamed:@"red.png"]];
            break;
        case 4:
            [cell.imageView setImage:[UIImage imageNamed:@"yellow.png"]];
            break;
        case 5:
            [cell.imageView setImage:[UIImage imageNamed:@"blue.png"]];
            break;            
        default:
            [cell.imageView setImage:[UIImage imageNamed:@"blue.png"]];
            break;
    }

    cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@] | [%@]",contributeInfo.time,contributeInfo.statusNm];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *strID = ((ContributeInfo *)[dataArray objectAtIndex:[indexPath row]]).conid;
    [docRequest getDocDetailWithConid:strID];
    
}

- (void)getDocDetailDidFinished:(ContributeInfo *)contributeInfo{

    DocChangeDetailViewController *docChangeDetailCtrl = [[DocChangeDetailViewController alloc] initWithNibName:@"DocChangeDetailViewController" bundle:nil];
    
    docChangeDetailCtrl.contributeInfo = [contributeInfo retain];
    [self.navigationController pushViewController:docChangeDetailCtrl animated:YES];
    [docChangeDetailCtrl release];
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

