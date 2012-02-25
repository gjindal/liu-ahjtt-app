//
//  TreeViewController.h
//  TreeView
//
//  Created by QQ on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"
#import "TreeViewCell.h"
#import "ClueDistRequest.h"
#import "DeptInfo.h"


@interface TreeViewController : UITableViewController 
<UITableViewDelegate,UITableViewDataSource,ClueDistRequestDelegate>{
	TreeNode* tree;
	NSMutableArray* nodes;
    
    NSMutableArray *deptNodes;
    DeptInfo *deptInfo;
    ClueDistRequest *cluedistRequest;
    
}
//如果你想呈现自己的树，在子类中覆盖此方法
-(void)initTree;
//如果你想在选中某一个节点时，发生自定义行为，在子类中覆盖此方法
-(void)onSelectedRow:(NSIndexPath *)indexPath :(TreeNode *)node;
//如果你想定义自己的单元格视图（比如更换默认的文件夹图标），在子类中覆盖此方法
-(void)configCell:(TreeViewCell *)cell :(TreeNode *)node;
@end
