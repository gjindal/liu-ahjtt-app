
// 线索接口.

#define kFlag_NewsClue_List     1
#define kFlag_NewsClue_Detail   2
#define kFlag_NewsClue_Add      3
#define kFlag_NewsClue_Update   4
#define kFlag_NewsClue_Delete   5
#define kFlag_NewsClue_Submit   6

#define kInterface_NewsClue_List    @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!getKeysList.do"   // 查询线索列表接口
#define kInterface_NewsClue_Detail  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!getKeyDetail.do"  // 查询线索详情接口
#define kInterface_NewsClue_Add     @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!addKey.do"        // 增加线索接口
#define kInterface_NewsClue_Update  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!updateKey.do"     // 修改线索接口
#define kInterface_NewsClue_Delete  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!delKey.do"        // 删除线索接口
#define kInterface_NewsClue_Submit  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!updateStatus.do"  // 提交线索接口

// 线索派发接口.
#define kFlag_ClueDist_List     1
#define kFlag_ClueDist_Detail   2
#define kFlag_ClueDist_Dept     3
#define kFlag_ClueDist_User     4

#define kInterface_ClueDist_List    @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getKeysList.do"   // 查询可派单线索列表接口
#define kInterface_ClueDist_Detail  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getKeyDetail.do"  // 查询线索详情接口
#define kInterface_ClueDist_Dept    @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getDeptTree.do"   // 派发线索接口1，获得管理的部门
#define kInterface_ClueDist_User    @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getDeptUsers.do"  // 派发线索接口2，获得有部门权限的用户