//
//  UserViewController.m
//  LogInAndSignUpDemo
//
//  Created by Praneet Tata on 7/26/13.
//
//

#import "UserViewController.h"
#import "NewCell.h"
#import "EditPassViewController.h"
@interface UserViewController ()

@property (nonatomic,retain) NSMutableArray *reviews;


@end

@implementation UserViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        _tableView.dataSource = self;
        _tableView.delegate = (id)self;
    }
    return self;
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGSize scrollableSize = CGSizeMake(320, self.controlScroll.intrinsicContentSize.height);
    [self.controlScroll setContentSize:scrollableSize];
    self.title = @"Profile";
    
    UIImage *backButtonImage = [UIImage imageNamed:@"backArrow2.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;    
    
    self.reviews = [NSMutableArray array];

    NSDictionary *userName = (NSDictionary *)[PFUser currentUser];
    self.username.text = userName[@"username"];
    self.email.text = userName[@"email"];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reviews"];
    [query whereKey:@"UserSub" equalTo:self.username.text];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"%@",results[0]);
            [self setReviews:[NSMutableArray arrayWithArray:results]];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewDelegate
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
        int num = [dictionaryApps[@"Auth"] intValue];
        if(num){
            cell.submission.text = @"Posted";
            cell.submission.textColor = [UIColor colorWithRed:(106.0/255.0) green:(233.0/255.0) blue:(121.0/255.0) alpha:1];
        }
        cell.comments.text = dictionaryApps[@"comments"];
        UIImage *overallCirc = [self circImage:score];
        cell.score.image =overallCirc;
        
        UIImage *easinessCirc = [self circImage:easiness];
        cell.easiness.image = easinessCirc;
        
        UIImage *contentCirc  = [self circImage:content];
        cell.content.image = contentCirc;
        //    cell.courseName.text = dictionaryApps[@"cname"];
        cell.date.text = date;
        cell.semester.text = dictionaryApps[@"semester"];
        cell.professor.text = dictionaryApps[@"profname"];
    }
    else{
        cell.comments.text = @"";
    //    cell.score.text = @"";
    //    cell.easiness.text = @"";
    //    cell.content.text = @"";
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

- (UIImage*)circImage:(NSString *)score{
    
    float scoren = [score floatValue];
    NSLog(@"%f",scoren);
    UIImage *circ;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}
////////



-(IBAction)editPassword:(id)sender{
    
    EditPassViewController *newPass = [[EditPassViewController alloc] initWithNibName:@"EditPassViewController" bundle:nil];
    [self.navigationController pushViewController:newPass animated:YES];
    
    
}



-(IBAction)logOut:(id)sender{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure you wish to logout?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    
    [alert show];
    
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {
        [PFUser logOut];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        ;
    }
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
