//
//  NewCourse.h
//
//  Created by Praneet Tata on 7/18/13.
//
//

#import <UIKit/UIKit.h>


@interface NewCourse : UIViewController <UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,weak)IBOutlet UIScrollView *MainScrollView;
@property (nonatomic,weak)IBOutlet UISlider *easiness;
@property (nonatomic,weak)IBOutlet UISlider *content;
@property (nonatomic,weak)IBOutlet UISlider *overall;
@property (nonatomic,weak)IBOutlet UITextView *comments;
@property (nonatomic,weak)IBOutlet UITextField *professor;
@property (nonatomic,weak)IBOutlet UITextField *courseName;
@property (nonatomic,weak)IBOutlet UITextField *semester;
@property (nonatomic,weak)IBOutlet UITextField *year;
@property (nonatomic,weak)IBOutlet UITextField *department;
@property (nonatomic,weak)IBOutlet UITextField *courseNumber;
@property (nonatomic,weak)IBOutlet UILabel *easinessD;
@property (nonatomic,weak)IBOutlet UILabel *contentD;
@property (nonatomic,weak)IBOutlet UILabel *overallD;


- (IBAction)userDoneEntertingComments:(id)sender;
- (IBAction)SubmitReview:(id)sender;
- (IBAction)contentChange:(id)sender;
- (IBAction)easinessChange:(id)sender;
- (IBAction)overallChange:(id)sender;

@end
