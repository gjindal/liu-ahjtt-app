//
//  TreeViewCell.h
//  TreeView
//
//  Created by QQ on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeNode.h"
@interface TreeViewCell : UITableViewCell {
	UIButton* btnExpand;//按钮：用于展开子节点
	SEL onExpand;//selector:点击“+”展开按钮时触发
	TreeNode* treeNode;//每个单元格表示一个节点
	UILabel* label;//标签：显示节点title
	id owner;//表示onExpand方法委托给哪个对象
	UIImageView* imgIcon;//图标	
}
@property (assign) SEL onExpand;
@property (retain) id owner;
@property (retain) UIImageView* imgIcon;
+(int) indent;
+(void)setIndent:(int)value;
+(int)icoWidth;
+(void)setIcoWidth:(int)value;
+(int)icoHeight;
+(void)setIcoHeight:(int)value;
+(int)labelMarginLeft;
+(void)setLabelMarginLeft:(int)value;
-(void)setTreeNode:(TreeNode *)node;
-(int)getIndent;
@end
