//
//  rootViewViewController.h
//  LogInAndSignUpDemo
//
//  Created by Praneet Tata on 6/25/13.
//
//

#import <UIKit/UIKit.h>
#import "CustomLogin.h"

@interface rootViewViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) CustomLogin *login;
@property (nonatomic, retain) IBOutlet UITextField *search;


- (IBAction)PushView:(id)sender;
- (IBAction)userDoneEntertingSearch:(id)sender;

@end
