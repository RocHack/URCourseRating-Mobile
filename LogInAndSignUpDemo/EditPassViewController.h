//
//  EditPassViewController.h
//  TestApp
//
//  Created by Praneet Tata on 8/8/13.
//
//

#import <UIKit/UIKit.h>

@interface EditPassViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>

@property(nonatomic,retain) IBOutlet UITextField *oldPass;
@property(nonatomic,retain) IBOutlet UITextField *theNewPass;
@property(nonatomic,retain) IBOutlet UITextField *confirmPass;


-(IBAction)changePassword:(id)sender;
-(IBAction)userDoneOldPass:(id)sender;
-(IBAction)userDoneNewPass:(id)sender;
-(IBAction)userDoneConfirm:(id)sender;


@end
