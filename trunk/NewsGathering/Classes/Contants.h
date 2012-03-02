//
typedef enum {
    DOCTYPE_DRAFT,    // shows glow when pressed
    DOCTYPE_DELETED,
} DOCTYPE;

typedef enum {
    MENUTYPE_SUBMIT,
    MENUTYPE_MEDIALIB,
}MENUTYPE;

typedef enum {
    ALERTTABLE_DOCTYPE,
    ALERTTABLE_LEVEL,
    ALERTTABLE_OTHERS
}ALERTTABLE_TYPE;

typedef enum {
    TYPE_ADD,
    TYPE_MODIFY
}TRANSFORM_TYPE;

#define kAttachID_Invalide @"-1"

//login interface
#define kInterface_Login @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/loginM!submit.do"

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
#define kFlag_ClueDist_Submit   5

#define kInterface_ClueDist_Submit  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!sendToUser.do"    //线索派发接口
#define kInterface_ClueDist_List    @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getKeysList.do"   // 查询可派单线索列表接口
#define kInterface_ClueDist_Detail  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getKeyDetail.do"  // 查询线索详情接口
#define kInterface_ClueDist_Dept    @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getDeptTree.do"   // 派发线索接口1，获得管理的部门
#define kInterface_ClueDist_User    @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getDeptUsers.do"  // 派发线索接口2，获得有部门权限的用户

// 稿件接口.

#define kFlag_Contri_List           1
#define kFlag_Contri_Detail         2
#define kFlag_Contri_Add            3
#define kFlag_Contri_Update         4
#define kFlag_Contri_Delete         5
#define kFlag_Contri_Submit         6
#define kFlag_Contri_Resume         7
#define kFlag_Contri_Remove         8
#define kFlag_Contri_AppList        9
#define kFlag_Contri_Approve        10
#define kFlag_Contri_Upload         11
#define kFlag_Contri_Download       12
#define kFlag_Contri_Add_Approve    13
#define KFlag_Contri_Get_Workflow   14
#define kFlag_Contri_Get_Cycle_List 15

#define kInterface_Contri_List          @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getList_pass.do"        // 查询稿件列表接口
#define kInterface_Contri_Detail        @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getContriDetail.do"     // 查询稿件详情接口
#define kInterface_Contri_Add           @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submit_pass.do"         // 增加稿件接口
#define kInterface_Contri_Update        @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!update_pass.do"         // 修改稿件接口
#define kInterface_Contri_Delete        @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!removetocycle.do"       // 删除稿件到回收站接口
#define kInterface_Contri_Submit        @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitApprove.do"       // 提交稿件接口
#define kInterface_Contri_Resume        @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!rebackById.do"          // 恢复回收站稿件接口
#define kInterface_Contri_Remove        @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!removeById.do"          // 彻底删除回收站稿件接口
#define kInterface_Contri_AppList       @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getAppList_pass.do"   // 查询待审批稿件列表接口
#define kInterface_Contri_Approve       @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitUpdateStatus.do"  // 稿件审核接口
#define kInterface_Contri_Upload        @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitUpdateStatus.do"  // 附件上传接口
#define kInterface_Contri_Download      @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!downloadFile.do"        // 附件下载接口
#define kInterface_Contri_Add_Approve   @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitApprove.do"       // 
#define kInterface_Contri_Get_Workflow  @"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getworkflowInit.do"
#define kInterface_Contri_Get_Cycle_List@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getCycleList_pass.do"   // 获取回收站列表

