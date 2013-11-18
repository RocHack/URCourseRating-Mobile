//
//  SubclassConfigViewController.h
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//

@interface SubclassConfigViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

- (IBAction)logOutButtonTapAction:(id)sender;

@end
