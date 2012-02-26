//
//  TreeNode.m
//  TreeView
//
//  Created by QQ on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TreeNode.h"


@implementation TreeNode
@synthesize p_node,children,data,title,key,expanded,hidden,type,bChecked;
-(id)init{
	if (self=[super init]) {
		p_node=nil;
		children=nil;
		key=nil;
	}
	return self;
}
-(void)setDeep:(int)value{
	deep=value;
}
-(void)addChild:(TreeNode *)child{
	if (children==nil) {
		children=[[NSMutableArray alloc]init];
	}
	child.p_node=self;	
	[children addObject:child];
}
-(int)childrenCount{
	return children==nil?0:children.count;
}
-(int)deep{
	return p_node==nil?0:p_node.deep+1;
}
-(BOOL)hasChildren{
	if(children==nil || children.count==0)
		return NO;
	else return YES;
}
+(TreeNode*)findNodeByKey:(NSString*)_key :(TreeNode*)node{
	if ([_key isEqualToString:[node key]]) {//如果node就匹配，返回node
		return node;
	}else if([node hasChildren]){//如果node有子节点，查找node 的子节点		
		for(TreeNode* each in [node children]){
			//NSLog(@"retrieve node:%@ %@",each.title,each.key);
			TreeNode* a=[TreeNode findNodeByKey:_key :each];
			if (a!=nil) {
				return a;
			}
		}
	}
	//如果node没有子节点,则查找终止,返回nil
	return nil;		
}
+(void)getNodes:(TreeNode*)root :(NSMutableArray*) array{
	if(![root hidden])//只有节点被设置为“不隐藏”的时候才返回节点
		[array addObject:root];
	if ([root hasChildren]&&[root expanded]) {
		for(TreeNode* each in [root children]){
			[TreeNode getNodes:each :array];
		}
	}
	return;
}
@end
