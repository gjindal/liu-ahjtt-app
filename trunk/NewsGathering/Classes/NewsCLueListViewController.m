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

@implementation NewsCLueListViewController


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
        ClueWriteDetailViewController *clueDetailCtrl = [[ClueWriteDetailViewController alloc] initWithNibName:@"ClueWriteDetailViewController" bundle:nil];
        [self.navigationController pushViewController:clueDetailCtrl animated:YES];
        [clueDetailCtrl release];
    }
    
    if (segmentCtrl.selectedSegmentIndex == 1) {
        NewsClueSearchViewController *viewCtrl = [[NewsClueSearchViewController alloc] initWithNibName:@"NewsClueView" bundle:nil] ;
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

    dataArray = [[NSArray arrayWithObjects:@"合肥下雪", @"合肥下雨", @"合肥下冰雹aaaaaaaaaaaaaaaaaaaaaaa", 
                  @"合肥下冰雹aaaaaaaaaaaaaaaaaaaaaaa", 
                  @"合肥下冰雹aaaaaaaaaaaaaaaaaaaaaaa", 
                  @"合肥下冰雹aaaaaaaaaaaaaaaaaaaaaaa", 
                  @"合肥下冰雹aaaaaaaaaaaaaaaaaaaaaaa", 
                  @"合肥下冰雹aaaaaaaaaaaaaaaaaaaaaaa", nil] retain];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    
    for (UIView *views in self.navigationController.navigationBar.subviews) {
        if ([views isKindOfClass:[UISegmentedControl class]]) {
            NSLog(@"找到啦");
            [views removeFromSuperview];
        }
    }

    [super viewWillDisappear:animated];
}

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
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.text = @"2012-02-09";
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    //cell.backgroundColor = [UIColor grayColor];
    [cell.imageView setImage:[UIImage imageNamed:@"blue.png"]];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
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
    
    NewsClueDetailViewController *newClueDetailCtrl = [[NewsClueDetailViewController alloc] initWithNibName:@"NewsClueDetailViewController" bundle:nil];
    [self.navigationController pushViewController:newClueDetailCtrl animated:YES];
    [newClueDetailCtrl release];
    
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
    [segmentCtrl release];
    [super dealloc];
}


@end

