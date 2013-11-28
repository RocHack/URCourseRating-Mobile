//
//  DepsViewContoller.h
//
//  Created by Praneet Tata on 7/19/13.
//
//

#import <UIKit/UIKit.h>

@interface DepsViewContoller : UIViewController <UITableViewDataSource, UITableViewDataSource, UIAlertViewDelegate>


@property (nonatomic, retain) PFLogInViewController *login;
@property (nonatomic, strong) UITableView *tableView;

@end
