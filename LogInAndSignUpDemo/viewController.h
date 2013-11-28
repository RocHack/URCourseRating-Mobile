//
//  viewController.h
//
//  Created by Praneet Tata on 6/26/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface viewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle cname:(NSString *)name;

@property (nonatomic, retain) PFLogInViewController *login;
@property (nonatomic, retain) NSString *courseName;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *Course;
@property (nonatomic, weak) IBOutlet UILabel *cTitle;
@property (nonatomic, weak) IBOutlet UILabel *AverageE;
@property (nonatomic, weak) IBOutlet UILabel *AverageC;
@property (nonatomic, weak) IBOutlet UILabel *AverageO;
@property (nonatomic, weak) IBOutlet UILabel *NumberR;
@property (nonatomic, weak) IBOutlet UIView *box;
@property (nonatomic, weak) IBOutlet UIButton *submitButton;

- (IBAction)submitReview:(id)sender;

@end
