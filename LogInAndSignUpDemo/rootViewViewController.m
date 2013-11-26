//
//  rootViewViewController.m
//  LogInAndSignUpDemo
//
//  Created by Praneet Tata on 6/25/13.
//
//

#import "rootViewViewController.h"
#import "viewController.h"
#import "NewCourse.h"
#import "UserViewController.h"
#import "SearchCoursesViewController.h"


@interface rootViewViewController ()

@end

@implementation rootViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:nil action:nil];

    /*
    int width = self.navigationController.navigationBar.frame.size.width;
    int height= self.navigationController.navigationBar.frame.size.height;
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:20];
    navLabel.text = @"Course Search";
    navLabel.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = navLabel;*/
    self.login = [[CustomLogin alloc] init];
    self.login.delegate = self;
    self.login.signUpController.delegate = self;
    self.login.fields = PFLogInFieldsDefault;
    self.search.delegate = self;
    
    
    
    UIImage *user = [UIImage imageNamed:@"profileIcon.png"];
    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [userButton setImage:user forState:UIControlStateNormal];
    
    userButton.frame = CGRectMake(0, 0, user.size.width, user.size.height);
    
    [userButton addTarget:self action:@selector(displayLogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:userButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    NSLog(@"%@",[PFUser currentUser]);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"%@",[PFUser currentUser]);
    
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}



- (void) displayLogin{
    
    if(![PFUser currentUser]){
        [self presentViewController: self.login animated:YES completion:nil];
        
    }
    else{
        NSLog(@"%@",[PFUser currentUser]);
        UserViewController *userInfo = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:nil];
        userInfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInfo animated:YES];
    }
    
    
}

-(IBAction)userDoneEntertingSearch:(id)sender{
    self.search = (UITextField*)sender;

}


- (IBAction)PushView:(id)sender {
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"course" equalTo:self.search.text];
    [query whereKey:@"Auth" equalTo:[NSNumber numberWithBool:YES]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        activityView.center=self.view.center;
        
        [activityView startAnimating];
        
        [self.view addSubview:activityView];
        if (!error) {
            [activityView stopAnimating];
            if([results count] != 0 || !results){
                NSLog(@"No error?");
                SearchCoursesViewController *newView;
                newView = [[SearchCoursesViewController alloc] initWithNibName:@"SearchCoursesViewController" bundle:nil cname:self.search.text];
                newView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:newView animated:YES];
            }
            else{
                NSString *title;
                NSString *message;
                if ([self.search.text isEqual: @""]){
                    title = @"Enter a course";
                    message = @"Please enter a course into the search bar";
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    
                    
                    [alert show];
                }
                else{
                    title = @"Course not found!";
                    message = @"The course you entered was not found. Please enter the course name properly or alternatively, create a page for this course";
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                                    message:message delegate:self cancelButtonTitle: @"Create Course Page"
                                                          otherButtonTitles: @"Cancel",nil];
                    
                    
                    [alert show];
                }

            }

        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);

        }
    }];
    
    
    
    
}

//Change this
/*
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame; frame.origin.y = -100;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame; frame.origin.y = +100;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
 
}*/


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {
        if([alertView.title isEqual: @"Course not found!"]){
            if([PFUser currentUser] != NULL){
                NewCourse *newSubmission = [[NewCourse alloc]initWithNibName:@"NewCourse" bundle:nil];
                [self.navigationController pushViewController:newSubmission animated:YES];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Log in" message:@"Please Log in first to create a new course page" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        if([alertView.title isEqual: @"Please Log in"]){
            [self presentViewController: self.login animated:YES completion:nil];
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.search resignFirstResponder];
    
}

@end
