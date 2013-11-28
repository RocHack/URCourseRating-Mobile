//
//  SearchCoursesViewController.m
//  TestApp
//
//  Created by Praneet Tata on 8/8/13.
//
//

#import "SearchCoursesViewController.h"

#import "viewController.h"
#import "rootViewViewController.h"
#import "ScrollSub.h"
#import "reviewSubmission.h"
#import "CourseCell.h"
#import "CustomLogin.h"


@interface SearchCoursesViewController ()

@property (nonatomic,retain) NSMutableArray *reviews;
@property (nonatomic,retain) NSMutableArray *reviews2;
@property (nonatomic,retain) UIActivityIndicatorView *activityLoader;
//@property (nonatomic,assign) NSInteger *numberReviews;
//@property (nonatomic,assign) NSInteger *averageOverall;
//@property (nonatomic,assign) NSInteger *averageEasiness;
//@property (nonatomic,assign) NSInteger *averageContent;



@end

@implementation SearchCoursesViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cname:(NSString *)name
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.courseName = name;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:self.tableView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.reviews = [NSMutableArray array];
    self.title = @"Courses";
    
    UIImage *backButtonImage = [UIImage imageNamed:@"backArrow2.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    //UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    
    [query whereKey:@"course" equalTo:self.courseName];
    [query whereKey:@"Auth" equalTo:[NSNumber numberWithBool:YES]];
    
    
    self.activityLoader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityLoader.hidesWhenStopped = YES;
    [self.activityLoader startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityLoader];
    
    [query whereKey:@"course" equalTo:self.courseName];
    [query whereKey:@"Auth" equalTo:[NSNumber numberWithBool:YES]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"%lu",(unsigned long)[results count]);
            if([results count] > 0){
                [self setReviews2:[NSMutableArray arrayWithArray:results]];
                [self.reviews addObject:results[0]];
                for(int i = 1; i  < [results count]; i++){
                    
                    bool add = YES;
                    for(int j = 0; j < [self.reviews count]; j++){
                        if([[results[i] valueForKey:@"cname"] isEqual:[self.reviews[j] valueForKey:@"cname"]]){
                            add = NO;
                        }
                    }
                    
                    if(add){
                        [self.reviews addObject:results[i]];
                    }
                }
                NSLog(@"%lu",(unsigned long)[self.reviews count]);
            }
            [self.activityLoader stopAnimating];
            [self.tableView reloadData];
        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource Methods



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.reviews.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CourseCell *cell = (CourseCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    if(indexPath.row < [self.reviews count]){
        int numberReviews = 0;
        double averageOverall = 0;
        double averageEasiness = 0;
        double averageContent = 0;
        
        NSDictionary *courseDict = (NSDictionary *)[self.reviews objectAtIndex:indexPath.row];
        
        
        for(int i = 0; i < [self.reviews2 count]; i++){
            
            if([courseDict[@"cname"]isEqual: [self.reviews2[i] valueForKeyPath:@"cname"]]){
                numberReviews++;
                averageContent += [[self.reviews2[i] valueForKeyPath:@"content"] intValue];
                averageEasiness += [[self.reviews2[i] valueForKeyPath:@"easiness"] intValue];
                averageOverall+= [[self.reviews2[i] valueForKeyPath:@"overall"] intValue];
            }
        }
        averageOverall = averageOverall/numberReviews;
        averageEasiness = averageEasiness/numberReviews;
        averageContent = averageContent/numberReviews;
        NSLog(@"%f",averageEasiness);
        NSLog(@"%f",averageOverall);
        NSLog(@"%f",averageContent);
        cell.courseTitle.text = [courseDict valueForKeyPath:@"cname"];
        cell.cname.text = [courseDict valueForKeyPath:@"course"];
        cell.reviewsNumber.text = [NSString stringWithFormat:@"%d",numberReviews];
        cell.overall.text = [NSString stringWithFormat:@"%.01f",averageOverall];
        cell.content.text = [NSString stringWithFormat:@"%.01f",averageContent];
        cell.easiness.text = [NSString stringWithFormat:@"%.01f",averageEasiness];
        
        
        if([cell.content.text floatValue] > 3.8){
            cell.content.textColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];;
        }
        else if([cell.content.text floatValue] < 2.9){
            cell.content.textColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
        }
        else{
            cell.content.textColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
        }
        
        if([cell.overall.text floatValue] > 3.8){
            cell.overall.textColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];;
        }
        else if([cell.overall.text floatValue] < 2.9){
            cell.overall.textColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
        }
        else{
            cell.overall.textColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
        }
        
        if([cell.easiness.text floatValue] > 3.8){
            cell.easiness.textColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];;
        }
        else if([cell.easiness.text floatValue] < 2.9){
            cell.easiness.textColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];    }
        else{
            cell.easiness.textColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
        }
        
        
    }
    
    else{
        
        cell.courseTitle.text = @"";
        cell.cname.text = @"";
        cell.reviewsNumber.text = @"";
        cell.overall.text = @"";
        cell.content.text = @"";
        cell.easiness.text = @"";
        cell.AO.text = @"";
        cell.AC.text = @"";
        cell.AE.text = @"";
        cell.R.text = @"";
        
    }
    
    
    
    
    return cell;
    
}



#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *courseDict = (NSDictionary *)[self.reviews objectAtIndex:indexPath.row];
    
    if(indexPath.row <= self.reviews.count)
    {
        NSString *course = [courseDict valueForKeyPath:@"cname"];
        NSLog(@"%@",course);
        viewController *coursePage = [[viewController alloc] initWithNibName:@"viewController" bundle:nil cname:course];
        NSLog(@"%@",coursePage.courseName);
        [self.navigationController pushViewController:coursePage animated:YES];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}




-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {
        self.login = [[CustomLogin alloc] init];
        self.login.delegate = self;
        self.login.signUpController.delegate = self;
        self.login.fields = PFLogInFieldsDefault;
        [self presentViewController:self.login animated:YES completion:nil];
    }
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
    self.navigationItem.rightBarButtonItem.title = @"Logout";
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


@end
