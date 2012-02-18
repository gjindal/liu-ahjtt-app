

#import <UIKit/UIKit.h>

@class UIAlertView;

@interface UIAlertTableView : UIAlertView {
	// The Alert View to decorate
    UIAlertView *alertView;
	
	// The Table View to display
	UITableView *tableView;
	
	// Height of the table
	int tableHeight;
	
	// Space the Table requires (incl. padding)
	int tableExtHeight;
	
	id<UITableViewDataSource> dataSource;
	id<UITableViewDelegate> tableDelegate;
}

@property (nonatomic, assign) id dataSource;
@property (nonatomic, assign) id tableDelegate;

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, assign) int tableHeight;

- (void)prepare;

@end

