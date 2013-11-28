//
//  UserViewController.h
//
//  Created by Praneet Tata on 7/26/13.
//
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UIScrollView *controlScroll;
@property (nonatomic,weak) IBOutlet UILabel *username;
@property (nonatomic,weak) IBOutlet UILabel *email;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

-(IBAction)logOut:(id)sender;
-(IBAction)editPassword:(id)sender;


@end
