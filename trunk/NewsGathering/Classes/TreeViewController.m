//
//  TreeViewController.m
//  TreeView
//
//  Created by QQ on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TreeViewController.h"
#import "ClueDistRequest.h"
#import "DeptInfo.h"
#import "UserInfo.h"
#import "NewsGatheringAppDelegate.h"

@implementation TreeViewController
@synthesize delegate;
@synthesize dispatchedPersons;
@synthesize titleText;
@synthesize bMultiSelect;


-(void)viewDidLoad{
	[super viewDidLoad];
	//[self initTree];
}

//获取到人员后插入tableview
- (void)parserUserDidFinished:(NSArray *)userList{
    userNodes = [[NSMutableArray alloc] initWithArray:userList];
}

-(void)initTree{
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    deptNodes=[[NSMutableArray alloc] initWithArray:appDelegate.deptArray];
    
    tree=[[TreeNode alloc]init];
    tree.deep=0;
	tree.title=@"安徽交通广播";
    
    for(DeptInfo *deptPt in deptNodes){
        
        TreeNode *nodePt = [[TreeNode alloc]init];
        nodePt.title = deptPt.deptName;
        nodePt.key = deptPt.deptID;
        nodePt.type = @"dept";
        nodePt.bChecked = NO;
        
        if ([deptPt.parentID isEqualToString:@"1"]) {
            [tree addChild:nodePt];
            [cluedistRequest getUserWithDeptID:nodePt.key];
            for (UserInfo *user in userNodes) {
                TreeNode *userNd = [[TreeNode alloc]init];
                userNd.title = user.userName;
                userNd.key = user.userID;
                userNd.type = @"person";
                userNd.bChecked = NO;
                [nodePt addChild:userNd];
            }
        }
        
        for(DeptInfo *deptCh in deptNodes){

            TreeNode *nodeCh = [[TreeNode alloc]init];
            nodeCh.title = deptCh.deptName;
            nodeCh.key = deptCh.deptID;
            nodeCh.type = @"dept";
            nodeCh.bChecked = NO;
            
            if ([deptPt.deptID isEqualToString:deptCh.parentID]) {
                [nodePt addChild:nodeCh];
                [cluedistRequest getUserWithDeptID:nodeCh.key];
                for (UserInfo *user in userNodes) {
                    TreeNode *userNd = [[TreeNode alloc]init];
                    userNd.title = user.userName;
                    userNd.key = user.userID;
                    userNd.type = @"person";
                    userNd.bChecked = NO;
                    [nodeCh addChild:userNd];
                }
            }
        }
    }
    
    nodes=[[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
}
    


-(void)confirm{

    int i  = 0;
    for(TreeNode *node in nodes){
        if (node.bChecked) {
            i++;
        }
    }
    
    dispatchedPersons = [[NSMutableArray alloc] initWithCapacity:i];

    for(TreeNode *node in nodes){
        if (node.bChecked) {
            UserInfo *userInfo1 = [[UserInfo alloc]init];
            userInfo1.userID = node.key;
            userInfo1.userName = node.title;
            [dispatchedPersons addObject:userInfo1];
            [userInfo1 release];
        }
    }
    [delegate passValue:self.dispatchedPersons];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    

    if (cluedistRequest == nil) {
        cluedistRequest = [[ClueDistRequest alloc] init];
    }
    cluedistRequest.delegate = self;
    [self initTree];
    
	self.title= titleText;
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
    temporaryBarButtonItem.title = @"取消";  
    temporaryBarButtonItem.target = self;    
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
    [temporaryBarButtonItem release]; 
    
	self.navigationController.navigationBar.hidden=NO;
    
	UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle: @"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(confirm)];
	searchButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=searchButton;
	[searchButton release];

}

#pragma mark ===table view datasource methods====
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}
-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return nodes.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString* cellid=@"cell";
	TreeViewCell* cell=(TreeViewCell*)[tableView dequeueReusableCellWithIdentifier:
									   cellid];
	if (cell==nil) {
		cell=[[[TreeViewCell alloc]initWithStyle:UITableViewCellStyleDefault
								 reuseIdentifier:cellid]autorelease];
	}
	TreeNode* node=[nodes objectAtIndex:indexPath.row];
	[cell setOwner:self];
	[cell setOnExpand:@selector(onExpand:)];
	[cell setTreeNode:node];
	[self configCell:cell :node];
	return cell;
}



//如果你想在选中某一个节点时，发生自定义行为，在子类中覆盖此方法
-(void)onSelectedRow:(NSIndexPath*)indexPath :(TreeNode *)node{
    
    NSLog(@"load table view: data.");
    for (int i = 0; i < [userNodes count]; i++) {
        [nodes addObject:[userNodes objectAtIndex:i]];
    }
    
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:0];
    for (int ind = 0; ind < [userNodes count]; ind++) {
        
        TreeNode *userNode = [[TreeNode alloc] init];
        userNode.title = ((UserInfo *)[userNodes objectAtIndex:ind]).userName;
        userNode.key = ((UserInfo *)[userNodes objectAtIndex:ind]).userID;
        [node addChild:userNode];
        
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:[nodes indexOfObject:[userNodes objectAtIndex:ind]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    NSLog(@"load table view finishend.");
    

}

//如果你想定义自己的单元格视图（比如更换默认的文件夹图标），在子类中覆盖此方法
-(void)configCell:(TreeViewCell*)cell :(TreeNode*)node{
    if ([node.type isEqualToString:@"person"]) {
        [cell.imgIcon setImage:[UIImage imageNamed:@"person.png"]];
    }else{
        [cell.imgIcon setImage:[UIImage imageNamed:@"depart.png"]];
    }
	//NSLog(@"initCell---key:%@,title:%@",node.key,node.title);
}

#pragma mark ===table view delegate methods===
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //当点击时获取部门内的人员
    TreeNode* node=[nodes objectAtIndex:indexPath.row];
    if ([node.type isEqualToString:@"dept"]) {
        return;
    }
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if (cell.accessoryType == UITableViewCellAccessoryNone)		{
        node.bChecked = YES;
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		cell.textLabel.textColor=[UIColor blueColor];
		NSLog(@"-----text---,%@",cell.textLabel.text);
	}
	else if (cell.accessoryType == UITableViewCellAccessoryCheckmark)	{
        node.bChecked = NO;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.textColor=[UIColor blackColor];
		
	}
    
}

-(void) viewWillDisappear:(BOOL)animated{

}

#pragma mark -
-(void)onExpand:(TreeNode*)node{
	nodes=[[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
	[self.tableView reloadData];
}
-(void)dealloc{
    [cluedistRequest release];
	[tree release];
	[nodes release];
	[super dealloc];
}
@end
