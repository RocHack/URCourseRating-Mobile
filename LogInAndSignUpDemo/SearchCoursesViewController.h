//
//  SearchCoursesViewController.h
//  TestApp
//
//  Created by Praneet Tata on 8/8/13.
//
//

#import <UIKit/UIKit.h>

@interface SearchCoursesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle cname:(NSString *)name;

@property (nonatomic, retain) PFLogInViewController *login;
@property (nonatomic, retain) NSString *courseName;
@property (nonatomic, strong) IBOutlet UITableView *tableView;



@end
