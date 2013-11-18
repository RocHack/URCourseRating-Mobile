//
//  viewController.m
//  LogInAndSignUpDemo
//
//  Created by Praneet Tata on 6/26/13.
//
//

#import "viewController.h"
#import "rootViewViewController.h"
#import "ScrollSub.h"
#import "NewCell.h"
#import "reviewSubmission.h"


@interface viewController (){
    int position;
}

@property (nonatomic,retain) NSMutableArray *reviews;
@property (nonatomic,retain) UIActivityIndicatorView *activityLoader;


@end

@implementation viewController

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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"cname" equalTo:self.courseName];
    [query whereKey:@"Auth" equalTo:[NSNumber numberWithBool:YES]];
//    NSString *pTitle = self.courseName;
    

    UIImage *backButtonImage = [UIImage imageNamed:@"backArrow2.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    /*
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    */
    
    self.activityLoader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityLoader.hidesWhenStopped = YES;
    [self.activityLoader startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityLoader];

    self.box.backgroundColor = [UIColor colorWithRed:(225.0/255.0) green:(243.0/255.0) blue:(255.0/255.0) alpha:1];
    self.box.layer.masksToBounds = NO;
    self.box.layer.shadowOffset = CGSizeMake(-15, 20);
    self.box.layer.shadowRadius = 5;
    self.box.layer.shadowOpacity = 0.5;

    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            // The find succeeded.
          //  NSLog(@"%@",results[0]);
            [self setReviews:[NSMutableArray arrayWithArray:results]];
            [self.activityLoader stopAnimating];
            [self setViewLabels];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)setViewLabels{
    self.Course.text = self.reviews[0][@"course"];
    self.cTitle.text = self.reviews[0][@"cname"];
    self.title = self.reviews[0][@"course"];
    double AvE = 0;
    double AvC = 0;
    double AvO = 0;
    int NumR = [self.reviews count];
    for(int i = 0; i < NumR; i++){
        AvE += [self.reviews[i][@"easiness"] intValue];
        AvC += [self.reviews[i][@"content"] intValue];
        AvO += [self.reviews[i][@"overall"] intValue];
    }
    
    AvE = AvE/NumR;
    AvC = AvC/NumR;
    AvO = AvO/NumR;
    self.AverageC.text = [NSString stringWithFormat:@"%.01f", AvC];
    self.AverageE.text = [NSString stringWithFormat:@"%.01f", AvE];
    self.AverageO.text = [NSString stringWithFormat:@"%.01f", AvO];
    self.NumberR.text  = [NSString stringWithFormat:@"%d", NumR];
    
    
    if([self.AverageC.text floatValue] > 3.8){
        self.AverageC.backgroundColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];
    }
    else if([self.AverageC.text floatValue] < 2.9){
        self.AverageC.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
    }
    else{
        self.AverageC.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
    }
    
    if([self.AverageO.text floatValue] > 3.8){
        self.AverageO.backgroundColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];
    }
    else if([self.AverageO.text floatValue] < 2.9){
        self.AverageO.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
    }
    else{
        self.AverageO.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
    }
    
    if([self.AverageE.text floatValue] > 3.8){
        self.AverageE.backgroundColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];
    }
    else if([self.AverageE.text floatValue] < 2.9){
        self.AverageE.backgroundColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
    }
    else{
        self.AverageE.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
    }
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
    NewCell *cell = (NewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    if(indexPath.row < [self.reviews count]){
        
        NSDictionary *dictionaryApps = (NSDictionary *)[self.reviews objectAtIndex:indexPath.row];
    

        NSString *score = [NSString stringWithFormat:@"%.01f",[dictionaryApps[@"overall"] floatValue]];
        NSString *easiness = [NSString stringWithFormat:@"%.01f",[dictionaryApps[@"easiness"] floatValue]];
        NSString *content = [NSString stringWithFormat:@"%.01f",[dictionaryApps[@"content"] floatValue]];
        NSString *date = [NSString stringWithFormat:@"%@",dictionaryApps[@"year"]];
        cell.comments.text = dictionaryApps[@"comments"];
        
        UIImage *overallCirc = [self circImage:score];
        cell.score.image =overallCirc;
        
        UIImage *easinessCirc = [self circImage:easiness];
        cell.easiness.image = easinessCirc;
        
        UIImage *contentCirc  = [self circImage:content];
        cell.content.image = contentCirc;
        
        
        
        
        cell.date.text = date;
        cell.semester.text = dictionaryApps[@"semester"];
        cell.professor.text = dictionaryApps[@"profname"];
        cell.status.text = @"";
        cell.submission.text = @"";

    }
    else{

        cell.comments.text = @"";
        cell.date.text = @"";
        cell.semester.text = @"";
        cell.professor.text = @"";
        cell.com.text = @"";
        cell.C.text = @"";
        cell.E.text = @"";
        cell.O.text = @"";
        cell.status.text = @"";
        cell.submission.text = @"";
        
    }
    return cell;
}



#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}


- (IBAction)submitReview:(id)sender{
    
    if([PFUser currentUser] == NULL){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Only registered users may submit a review!"
                                                        message:@"Please Log into submit a review!" delegate:self cancelButtonTitle: @"Login"
                                              otherButtonTitles: @"Cancel",nil];
        
        
        [alert show];
    }
    else{
        NSArray *splitstring = [self.courseName componentsSeparatedByString:@" "];
        reviewSubmission *newReview = [[reviewSubmission alloc] initWithNibName:@"reviewSubmission" bundle:nil sname:splitstring[0] snum:splitstring[1] cname:self.reviews[0][@"course"]];
        [self.navigationController pushViewController:newReview animated:YES];

    }
}

- (UIImage*)circImage:(NSString *)score{
    
    float scoren = [score floatValue];
    UIImage *circ;
    NSLog(@"%f",scoren);
    if(scoren < 0.5){
        circ = [UIImage imageNamed:@"CirclesRed0p3.png"];
    }
    else if(scoren == 0.5){
        circ = [UIImage imageNamed:@"CirclesRed0p5.png"];
    }
    else if(scoren > 0.5 && scoren <0.8){
        circ = [UIImage imageNamed:@"CirclesRed0p5.png"];
    }
    else if(scoren <= 0.8 && scoren > 1){
        circ = [UIImage imageNamed:@"CirclesRed0p8.png"];
    }
    else if(scoren == 1){
        circ = [UIImage imageNamed:@"CirclesRed1.png"];
    }
    else if(scoren < 1 && scoren > 1.5){
        circ = [UIImage imageNamed:@"CirclesRed1p3.png"];
    }
    else if(scoren == 1.5){
        circ = [UIImage imageNamed:@"CirclesRed1p5.png"];
    }
    else if(scoren > 1.5 && scoren < 2.0){
        circ = [UIImage imageNamed:@"CirclesRed1p8.png"];
    }
    else if(scoren == 2.0){
        circ = [UIImage imageNamed:@"CirclesRed2.png"];
    }
    else if(scoren > 2.0 && scoren < 2.5){
        circ = [UIImage imageNamed:@"CirclesRed2p3.png"];
    }
    else if(scoren == 2.5){
        circ = [UIImage imageNamed:@"CirclesRed2p5.png"];
    }
    else if(scoren > 2.5 && scoren < 3.0){
        circ = [UIImage imageNamed:@"CirclesRed2p8.png"];
    }
    else if(scoren == 3.0){
        circ = [UIImage imageNamed:@"CirclesYellow3.png"];
    }
    else if(scoren > 3.0 && scoren < 3.5){
        circ = [UIImage imageNamed:@"CirclesYellow3p3.png"];
    }
    else if(scoren == 3.5){
        circ = [UIImage imageNamed:@"CirclesYellow3p5.png"];
    }
    else if(scoren > 3.5 && scoren < 3.9){
        circ = [UIImage imageNamed:@"CirclesYellow3p8.png"];
    }
    else if(scoren == 3.9){
        circ = [UIImage imageNamed:@"CirclesGreen3p9.png"];
    }
    else if(scoren == 4.0){
        circ = [UIImage imageNamed:@"CirclesGreen4.png"];
    }
    else if(scoren > 4.0 && scoren < 4.5){
        circ = [UIImage imageNamed:@"CirclesGreen4p3.png"];
    }
    else if(scoren == 4.5){
        circ = [UIImage imageNamed:@"CirclesGreen4p5.png"];
    }
    else if(scoren < 4.5 && scoren >5.0){
        circ = [UIImage imageNamed:@"CirclesGreen4p8.png"];
    }
    else{
        circ = [UIImage imageNamed:@"CirclesGreen5.png"];
    }

    return circ;

}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
  
    if (buttonIndex == 0) {
        self.login = [[PFLogInViewController alloc] init];
        self.login.delegate = self;
        self.login.signUpController.delegate = self;
        self.login.fields = PFLogInFieldsDefault;
        [self presentModalViewController:self.login animated:YES];        
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
 //   NSLog(@"%@",[PFUser currentUser]);
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
