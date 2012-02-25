//
//  TreeViewCell.m
//  TreeView
//
//  Created by QQ on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TreeViewCell.h"

static int indent=15;//默认缩进值15
static int icoHeight=32;//默认图标32高
static int icoWidth=32;//默认图标32宽
static int labelMarginLeft=2;//默认标签左边留空2
@implementation TreeViewCell
@synthesize onExpand,imgIcon,owner;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
    }
    return self;
}
+(int)indent{
	return indent;
}
+(void)setIndent:(int)value{
	indent=value;
}
+(int)icoWidth{
	return icoWidth;
}
+(void)setIcoWidth:(int)value{
	icoWidth=value;
}
+(int)icoHeight{
	return icoHeight;
}
+(void)setIcoHeight:(int)value{
	icoHeight=value;
}
+(int)labelMarginLeft{
	return labelMarginLeft;
}
+(void)setLabelMarginLeft:(int)value{
	labelMarginLeft=value;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)onExpand:(id)sender{
	if ([treeNode hasChildren]) {//如果有子节点
		//NSLog(@"%d",[treeNode hasChildren]);
		treeNode.expanded=!treeNode.expanded;//切换“展开/收起”状态
		if(treeNode.expanded){//若展开状态设置“+/-”号图标
			[btnExpand setImage:[UIImage imageNamed:
								 @"minus.png"] forState:UIControlStateNormal];
		}else {
			[btnExpand setImage:[UIImage imageNamed:
								 @"plus.png"] forState:UIControlStateNormal];
		}
		if(owner!=nil && onExpand!=nil)//若用户设置了onExpand属性则调用
			[owner performSelector:onExpand withObject:treeNode];
	}
}
-(int)getIndent{
	return indent;
}
-(void)setTreeNode:(TreeNode *)node{
	treeNode=node;
	if (label==nil) {
		btnExpand=[[UIButton alloc]initWithFrame:CGRectMake((indent*node.deep), 5, 32, 32)];
		[btnExpand addTarget:self action:@selector(onExpand:)
			forControlEvents:UIControlEventTouchUpInside];

		//NSLog(@"label is nil");
		imgIcon=[[UIImageView alloc]initWithFrame:
				  CGRectMake(32+(indent*node.deep), 0, icoWidth, icoHeight)];
		label=[[UILabel alloc]initWithFrame:
			   CGRectMake(32+labelMarginLeft+icoWidth+(indent*node.deep), 0, 200,36)];
				[imgIcon setImage:[UIImage imageNamed:@"folder_small.png"]];
		[self addSubview:label];
		[self addSubview:imgIcon];
		[self addSubview:btnExpand];
	}else {
		[btnExpand setFrame:CGRectMake(indent*node.deep, 5, 32, 32)];
		[imgIcon setFrame:CGRectMake(32+(indent*node.deep), 0, icoWidth, icoHeight)];
		[label setFrame:CGRectMake(32+labelMarginLeft+icoWidth+(indent*node.deep), 0, 200, 36)];
		}
	if ([node hasChildren]) {
		//NSLog(@"node has children");
		if ([node expanded]) {
			[btnExpand setImage:[UIImage imageNamed:@"minus.png"]
										   forState:UIControlStateNormal];
		}else {
			UIImage *img=[UIImage imageNamed:@"plus.png"];
			//NSLog(@"%d",img==nil);
			[btnExpand setImage:img
										   forState:UIControlStateNormal];
		}
	}else {
		
		[btnExpand setImage:nil forState:UIControlStateNormal];
	}
	[label setText:node.title];
}
- (void)dealloc {
    [super dealloc];
}


@end
