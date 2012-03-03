//
//  DocWriteListViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DocWriteListViewController.h"
#import "DocWriteDetailViewController.h"

@implementation DocWriteListViewController


#pragma mark -
#pragma mark View lifecycle


-(void)writeNewsDoc
{
	DocWriteDetailViewController *viewCtrl = [[DocWriteDetailViewController alloc] initWithNibName:@"DocWriteDetailViewController" bundle:nil] ;
    viewCtrl.transformType = TYPE_ADD;
	//viewCtrl.nSearchType = SEARCHTYPE_CLUE;
	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"稿件撰写";
	self.navigationController.navigationBar.hidden=NO;
	
	UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle: @"新建" style:UIBarButtonItemStyleBordered target:self action:@selector(writeNewsDoc)];
	searchButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=searchButton;
	[searchButton release];
	
    if(_docHelper == nil)
        _docHelper = [[DocDetailHelper alloc] init];
    if(dataArray != nil) {
    
        [dataArray release];
        dataArray = nil;
    }
    
    dataArray = [[_docHelper getAllDocDetail] retain];
    [self.tableView reloadData];
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
    return [dataArray count];
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
    DocDetail *docDetail = (DocDetail *)[dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = docDetail.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"[%@][%@]", docDetail.saveTime, ([docDetail.status isEqualToString:DOC_STATUS_UNSUMMIT]?@"未提交":@"已提交")];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_docHelper deleteDoc:[dataArray objectAtIndex:indexPath.row]];
        [dataArray release];
        dataArray = nil;
        dataArray = [[_docHelper getAllDocDetail] retain];
        [self.tableView reloadData];
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    
    [self.tableView endUpdates];
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DocWriteDetailViewController *viewCtrl = [[DocWriteDetailViewController alloc] initWithNibName:@"DocWriteDetailViewController" bundle:nil];
    viewCtrl.transformType = TYPE_MODIFY;
    viewCtrl.docDetail = (DocDetail *)[dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewCtrl animated:YES];
    [viewCtrl release];
    
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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

