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

@implementation TreeViewController
-(void)viewDidLoad{
	[super viewDidLoad];
	[self initTree];
}

- (void)parserDeptDidFinished:(NSArray *)deptList{
    deptNodes=[[NSMutableArray alloc] initWithArray:deptList];
    
    tree=[[TreeNode alloc]init];
    tree.deep=0;
	tree.title=@"安徽交通广播";
    
    for(DeptInfo *deptPt in deptNodes){
        
        TreeNode *nodePt = [[TreeNode alloc]init];
        nodePt.title = deptPt.deptName;
        nodePt.key = deptPt.deptID;
        
        if ([deptPt.deptID isEqualToString:@"1"]) {
            [tree addChild:nodePt];
        }
        
        for(DeptInfo *deptCh in deptNodes){

            TreeNode *nodeCh = [[TreeNode alloc]init];
            nodeCh.title = deptPt.deptName;
            nodeCh.key = deptPt.deptID;
            
            if ([deptPt.deptID isEqualToString:deptCh.parentID]) {
                [nodePt addChild:nodeCh];
            }
        }
    }
    
    nodes=[[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
}


-(void)initTree{
    
    cluedistRequest.delegate = self;
    [cluedistRequest getDept];
    /*
	//NSLog(@"initTree===");
	tree=[[TreeNode alloc]init];
	tree.deep=0;
	tree.title=@"安徽交通广播";
	TreeNode* node[10];
	for (int i=0; i<10; i++) {
		node[i]=[[TreeNode alloc]init];
		node[i].title=[NSString stringWithFormat:@"节点%d",i];
		node[i].key=[NSString stringWithFormat:@"%d",i];
	}
    [node[0] addChild:node[1]];
	[node[0] addChild:node[2]];
	[node[0] addChild:node[3]];
	
	[node[2] addChild:node[4]];
	[node[2] addChild:node[5]];
	[node[2] addChild:node[6]];
	
	[node[6] addChild:node[7]];
	[node[6] addChild:node[8]];
	[node[3] addChild:node[9]];
	
	[tree addChild:node[0]];
	nodes=[[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
     */
	
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
   // cluedistRequest.delegate = self;
   // [cluedistRequest getDept];
    
	self.title= @"选择派发人";
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
    temporaryBarButtonItem.title = @"取消";  
    temporaryBarButtonItem.target = self;  
    // temporaryBarButtonItem.action = @selector(back:);  
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
    [temporaryBarButtonItem release]; 
    
	self.navigationController.navigationBar.hidden=NO;
    
	UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithTitle: @"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(searchNews)];
	searchButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=searchButton;
	[searchButton release];

}
//如果你想在选中某一个节点时，发生自定义行为，在子类中覆盖此方法
-(void)onSelectedRow:(NSIndexPath*)indexPath :(TreeNode *)node{
	//TreeNode* node=[nodes objectAtIndex:indexPath.row];
	//NSLog(@"onSelectedRow---key:%@,title:%@",node.key,node.title);
}
//如果你想定义自己的单元格视图（比如更换默认的文件夹图标），在子类中覆盖此方法
-(void)configCell:(TreeViewCell*)cell :(TreeNode*)node{
	//NSLog(@"initCell---key:%@,title:%@",node.key,node.title);
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
#pragma mark ===table view delegate methods===
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	TreeNode* node=[nodes objectAtIndex:indexPath.row];
	[self onSelectedRow:indexPath :node];
}
#pragma mark -
-(void)onExpand:(TreeNode*)node{
	nodes=[[NSMutableArray alloc]init];
	[TreeNode getNodes:tree :nodes];
	[self.tableView reloadData];
}
-(void)dealloc{
	[tree release];
	[nodes release];
	[super dealloc];
}
@end
