//
//  TreeNode.h
//  TreeView
//
//  Created by QQ on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TreeNode : NSObject {
	TreeNode* p_node;//父节点
	NSMutableArray* children;//子节点
	id data;//节点可以包含任意数据
	NSString* title;//节点要显示的文字
	NSString* key;//主键，在树中唯一
	BOOL expanded;//标志：节点是否已展开，保留给TreeViewCell使用的
	BOOL hidden;//标志，节点是否隐藏
	int deep;//节点位于树的第几层,TreeViewCell使用
}
//节点本身不负责内存管理！使用assign(引用计数器不会改变),调用者实例化时需要自己retain
@property (retain) TreeNode* p_node;
@property (retain) id data;
@property (retain) NSString *title,*key;
@property (assign) BOOL expanded,hidden;
@property (retain) NSMutableArray* children;
-(int) deep;
-(void)setDeep:(int)value;
//hasChildren的访问方法
-(BOOL)hasChildren;
//子节点的添加方法
-(void)addChild:(TreeNode*)child;
-(int)childrenCount;
+(TreeNode*)findNodeByKey:(NSString*)_key :(TreeNode*)node;
+(void)getNodes:(TreeNode*)root :(NSMutableArray*) array;
@end
