//
//  CoursesViewController.h
//
//  Created by Praneet Tata on 7/19/13.
//
//

#import <UIKit/UIKit.h>


@interface CoursesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle cname:(NSString *)name;

@property (nonatomic, retain) PFLogInViewController *login;
@property (nonatomic, retain) NSString *courseName;
@property (nonatomic, strong) IBOutlet UITableView *tableView;



@end
