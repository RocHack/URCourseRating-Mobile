//
//  NewCourse.m
//  LogInAndSignUpDemo
//
//  Created by Praneet Tata on 7/18/13.
//
//

#import "NewCourse.h"

@interface NewCourse ()

@end

@implementation NewCourse

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
    

    UIImage *backButtonImage = [UIImage imageNamed:@"backArrow2.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.title = @"New Course Submission";
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
  
    CGSize scrollableSize = CGSizeMake(320.0, self.MainScrollView.intrinsicContentSize.height);
    [self.MainScrollView setContentSize:scrollableSize];

    // Do any additional setup after loading the view from its nib.
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)userDoneEntertingComments:(id)sender{
    [self.professor resignFirstResponder];
    [self.courseName resignFirstResponder];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


-(void)textViewDidBeginEditing:(UITextView *)textField {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame; frame.origin.y = -100;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
}


-(void)textViewDidEndEditing:(UITextView *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame; frame.origin.y = +100;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
    
}

-(IBAction)contentChange:(id)sender{
    
    self.contentD.text = [NSString stringWithFormat:@"%.01f",self.content.value];
    
}

-(IBAction)easinessChange:(id)sender{
    self.easinessD.text = [NSString stringWithFormat:@"%.01f",self.easiness.value];
}

-(IBAction)overallChange:(id)sender{
    self.overallD.text = [NSString stringWithFormat:@"%.01f",self.overall.value];
}


-(IBAction)SubmitReview:(id)sender{
 
    
    PFObject *newReview = [PFObject objectWithClassName:@"Reviews"];
    [newReview setObject:self.courseName.text forKey:@"cname"];
    [newReview setObject:self.comments forKey:@"comments"];
    [newReview setObject:[NSNumber numberWithBool:NO] forKey:@"Auth"];
    [newReview setObject:[NSNumber numberWithFloat:self.content.value] forKey:@"content"];
    [newReview setObject:[NSNumber numberWithFloat:self.easiness.value] forKey:@"easiness"];
    [newReview setObject:[NSNumber numberWithFloat:self.overall.value] forKey:@"overall"];
    [newReview setObject:self.professor.text forKey:@"profname"];
    [newReview setObject:self.semester.text forKey:@"semester"];
    [newReview setObject:[NSNumber numberWithInt:[self.year.text intValue]] forKey:@"year"];
    [newReview setObject:self.department.text forKey:@"sname"];
    [newReview setObject:[NSNumber numberWithInt: [self.courseName.text intValue]] forKey:@"snum"];
    NSMutableString *cname = [NSMutableString stringWithFormat:@"%@ %@",self.department.text,self.courseNumber.text];
    [newReview setObject:cname forKey:@"course"];
    NSDictionary *User = (NSDictionary *)[PFUser currentUser];
    NSString *userName = User[@"username"];
    [newReview setObject:userName forKey:@"UserSub"];
    [newReview saveInBackground];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks for your feedback!" message:@"Thank you for your feedback. Your review is awaiting moderation" delegate:self cancelButtonTitle:@"Dismiss"otherButtonTitles:nil, nil];
    [alert show];
    


}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
