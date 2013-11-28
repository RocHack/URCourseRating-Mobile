//
//  reviewSubmission.m
//
//  Created by Praneet Tata on 7/2/13.
//
//

#import "reviewSubmission.h"


@interface reviewSubmission ()

@end

@implementation reviewSubmission

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil sname:(NSString *)sn snum:(NSString *)si cname:(NSString *)cn
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.cname = cn;
        self.sname = sn;
        self.snum = si;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.comments.delegate = self;
    self.semester.delegate = self;
    self.year.delegate = self;
    self.title = @"Submit a Review";
    self.course.text = self.cname;
    UIImage *backButtonImage = [UIImage imageNamed:@"backArrow2.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize scrollableSize = CGSizeMake(320, self.MainScrollView.intrinsicContentSize.height);
    [self.MainScrollView setContentSize:scrollableSize];
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
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
*/  

-(IBAction)contentChange:(id)sender{
    
    if(self.content.value > 3.8){
        self.contentD.textColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];
    }
    else if(self.content.value < 2.9){
        self.contentD.textColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
    }
    else{
        self.contentD.textColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
    }

    self.contentD.text = [NSString stringWithFormat:@"%.01f",self.content.value];
    
}

-(IBAction)easinessChange:(id)sender{
    
    if(self.easiness.value > 3.8){
        self.easinessD.textColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];
    }
    else if(self.easiness.value < 2.9){
        self.easinessD.textColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
    }
    else{
        self.easinessD.textColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
    }

    
    self.easinessD.text = [NSString stringWithFormat:@"%.01f",self.easiness.value];
}

-(IBAction)overallChange:(id)sender{
    
    if(self.overall.value > 3.8){
        self.overallD.textColor = [UIColor colorWithRed:(104.0/255.0) green:(200.0/255.0) blue:(79.0/255.0) alpha:1.0];
    }
    else if(self.overall.value < 2.9){
        self.overallD.textColor = [UIColor colorWithRed:(245.0/255.0) green:(99.0/255.0) blue:(89.0/255.0) alpha:1.0];
    }
    else{
        self.overallD.textColor = [UIColor colorWithRed:(255.0/255.0) green:(211.0/255.0) blue:(0.0/255.0) alpha:1.0];
    }

    
    self.overallD.text = [NSString stringWithFormat:@"%.01f",self.overall.value];
}

-(IBAction)SubmitReview:(id)sender{
    
    PFObject *newReview = [PFObject objectWithClassName:@"Reviews"];
    [newReview setObject:self.courseName.text forKey:@"cname"];
    [newReview setObject:self.comments.text forKey:@"comments"];
    [newReview setObject:[NSNumber numberWithBool:NO] forKey:@"Auth"];
    [newReview setObject:[NSNumber numberWithFloat:self.content.value] forKey:@"content"];
    [newReview setObject:[NSNumber numberWithFloat:self.easiness.value] forKey:@"easiness"];
    [newReview setObject:[NSNumber numberWithFloat:self.overall.value] forKey:@"overall"];
    [newReview setObject:self.professor.text forKey:@"profname"];
    [newReview setObject:self.semester.text forKey:@"semester"];
    [newReview setObject:[NSNumber numberWithInt:[self.year.text intValue]] forKey:@"year"];
    [newReview setObject:self.sname forKey:@"sname"];
    [newReview setObject:[NSNumber numberWithInt: [self.snum intValue]] forKey:@"snum"];
    [newReview setObject:self.cname forKey:@"course"];
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



@end
