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
@synthesize currentFinishPageIndex;
@synthesize docChangeType;


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
        self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;  
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

-(void)getCompleteListDidFinished:(NSArray *)docList{
    if ([docList count]<1) {
        //[alertView alertInfo:@"已没有更多数据" withTitle:@"提醒"];
        return;
    }else{
        currentFinishPageIndex++;
    }
    //[dataArray removeAllObjects];
    [dataArray addObjectsFromArray:docList];
    [self.tableView reloadData];
}

-(void)segmentAction:(id)sender
{
    segmentCtrl = (UISegmentedControl *)sender;
    NSLog(@"======%d",segmentCtrl.selectedSegmentIndex);
    if (docChangeType == DOCCHANGE_TYPE_UNFINISH) {
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
    }
    
    if (docChangeType == DOCCHANGE_TYPE_FINISHED) {
        if (docSearchVtrl == nil) {
            docSearchVtrl = [[DocSearchViewController alloc] initWithNibName:@"DocSearchViewController" bundle:nil] ;
            docSearchVtrl.contributeInfo.title = @"";
            docSearchVtrl.contributeInfo.keyword = @"";
            docSearchVtrl.contributeInfo.type = @"";
            docSearchVtrl.strStartTime = @"";
            docSearchVtrl.strEndTime = @"";
        }
        [docRequest getCompleteListWithTitle:docSearchVtrl.contributeInfo.title
                                Keyword:docSearchVtrl.contributeInfo.keyword
                                Begtime:docSearchVtrl.strStartTime
                                Endtime:docSearchVtrl.strEndTime
                                Type:docSearchVtrl.contributeInfo.type
                                Page:@"1" rp:@"6" sortName:@"conid"];
    }
}

-(void) viewDidLoad{

    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle: @"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(searchDocs)];	
    searchButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=searchButton;
	[searchButton release];
    
    /*
    segmentCtrl= [[UISegmentedControl alloc]
                  initWithFrame:CGRectMake(225.0f, 6.0, 90.0f, 32.0f)];
	[segmentCtrl insertSegmentWithTitle:@"未完成" atIndex:0 animated:YES]; 
	[segmentCtrl insertSegmentWithTitle:@"已完成" atIndex:1 animated:YES];	
	segmentCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
	[segmentCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentCtrl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentCtrl;
    */
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    alertView = [[CustomAlertView alloc] init];
    docRequest = [[DocRequest alloc] init];
    docRequest.delegate = self;    
    
    docSearchVtrl = nil;
    
    
    currentFinishPageIndex = 1;
    nextPage = NEXTPAGE_OTHERS;//
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    if (docChangeType == DOCCHANGE_TYPE_UNFINISH) {
        self.title= @"稿件管理";
        
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
    }else{
        self.title= @"已完成稿件";
        if (docSearchVtrl == nil) {
            docSearchVtrl = [[DocSearchViewController alloc] initWithNibName:@"DocSearchViewController" bundle:nil] ;
            docSearchVtrl.contributeInfo.title = @"";
            docSearchVtrl.contributeInfo.keyword = @"";
            docSearchVtrl.contributeInfo.type = @"";
            docSearchVtrl.strStartTime = @"";
            docSearchVtrl.strEndTime = @"";
        }
        [docRequest getCompleteListWithTitle:docSearchVtrl.contributeInfo.title
                                     Keyword:docSearchVtrl.contributeInfo.keyword
                                     Begtime:docSearchVtrl.strStartTime
                                     Endtime:docSearchVtrl.strEndTime
                                        Type:docSearchVtrl.contributeInfo.type
                                        Page:@"1" rp:@"6" sortName:@"conid"];
    
    }

   // segmentCtrl.selectedSegmentIndex = 0;
}


#pragma mark -
#pragma mark Table view data source

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if(docChangeType == DOCCHANGE_TYPE_UNFINISH) return;
    
	CGPoint offset = scrollView.contentOffset;       
    CGRect bounds = scrollView.bounds;       
    CGSize size = scrollView.contentSize;       
    UIEdgeInsets inset = scrollView.contentInset;       
    float y = offset.y + bounds.size.height - inset.bottom;       
    float h = size.height;       
	
    float reload_distance = 0;       
    if((y >= h + reload_distance)) {           
        
        NSLog(@"THE  %d PAGE DATA",currentFinishPageIndex+1);
        if (docSearchVtrl == nil) {
            docSearchVtrl = [[DocSearchViewController alloc] initWithNibName:@"DocSearchViewController" bundle:nil] ;
            docSearchVtrl.contributeInfo.title = @"";
            docSearchVtrl.contributeInfo.keyword = @"";
            docSearchVtrl.contributeInfo.type = @"";
            docSearchVtrl.strStartTime = @"";
            docSearchVtrl.strEndTime = @"";
        }
        [docRequest getCompleteListWithTitle:docSearchVtrl.contributeInfo.title
                                     Keyword:docSearchVtrl.contributeInfo.keyword
                                     Begtime:docSearchVtrl.strStartTime
                                     Endtime:docSearchVtrl.strEndTime
                                        Type:docSearchVtrl.contributeInfo.type
                                        Page:[NSString stringWithFormat:@"%d", currentFinishPageIndex+1] rp:@"6" sortName:@"conid"];

    }   	
}

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
            [cell.imageView setImage:[UIImage imageNamed:@"red.png"]];
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ContributeInfo * contribut = (ContributeInfo *)[dataArray objectAtIndex:indexPath.row];
        if ([contribut.status isEqualToString:@"99"]) {
            [alertView alertInfo:@"不能删除" withTitle:@"稿件已完成"];
        }else if (([contribut.status isEqualToString:@"4"])||([contribut.status intValue]>5)) {
            [alertView alertInfo:@"不能删除" withTitle:@"正在审核中..."];
        }
        else{
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            nDeleteIndex = indexPath.row;
            [docRequest deleteDocWithConid:((ContributeInfo *)[dataArray objectAtIndex:indexPath.row]).conid];
        }
    }   
    
    [self.tableView endUpdates];
    //    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    //        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //    }   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *strID = ((ContributeInfo *)[dataArray objectAtIndex:[indexPath row]]).conid;
    [docRequest getDocDetailWithConid:strID];
    
}

-(void)deleteDocDidFinished:(ContributeInfo *)contributeInfo{
    if ([contributeInfo.flag isEqualToString:@"200"]) {
        [dataArray removeObjectAtIndex:nDeleteIndex];
        [alertView alertInfo:@"删除成功" withTitle:nil];
        [self.tableView reloadData];
    }else{
        [alertView alertInfo:@"删除失败" withTitle:nil];
    }
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

