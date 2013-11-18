//
//  EditPassViewController.m
//  TestApp
//
//  Created by Praneet Tata on 8/8/13.
//
//

#import "EditPassViewController.h"

@interface EditPassViewController ()

@end

@implementation EditPassViewController

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
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;


    self.title = @"Change Password";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)changePassword:(id)sender{
    
    if([self.oldPass.text isEqualToString: @""] || [self.theNewPass.text isEqualToString:@""] || [self.confirmPass.text isEqualToString: @""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Fill In All Fields" message:@"One or more fields have not been filled. Please fill all fields." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([self.oldPass.text isEqual:[PFUser currentUser].password]){
        
        if([self.theNewPass.text isEqual:self.confirmPass.text] ){
         
            [PFUser currentUser].password = self.theNewPass.text;
            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Password Changed" message:@"Your password has been changed" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert1 show];
            
        }
        else{
            UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"Passwords Do Not Match" message:@"The passwords that you have entered do not match" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert2 show];
        }
        
        
    }
    else{
        
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Invalid Password" message:@"An incorrect password was entered. Please enter the correct password" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert3 show];
        
    }
    
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if([alertView.title isEqual: @"Password Changed"]){
        
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(IBAction)userDoneOldPass:(id)sender{
    self.oldPass = (UITextField*)sender;
    
}

-(IBAction)userDoneNewPass:(id)sender{
    self.theNewPass = (UITextField*)sender;
    
}

-(IBAction)userDoneConfirm:(id)sender{
    self.confirmPass = (UITextField*)sender;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
