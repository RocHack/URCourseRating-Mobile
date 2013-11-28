//
//  reviewSubmission.h
//
//  Created by Praneet Tata on 7/2/13.
//
//

#import <UIKit/UIKit.h>

@interface reviewSubmission : UIViewController <UITextViewDelegate,UITextFieldDelegate, UIPickerViewDelegate,UIAlertViewDelegate>

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle sname:(NSString *)sn snum:(NSString*)si cname:(NSString*)cn ;

@property (nonatomic,weak)IBOutlet UIScrollView *MainScrollView;
@property (nonatomic,weak)IBOutlet UISlider *easiness;
@property (nonatomic,weak)IBOutlet UISlider *content;
@property (nonatomic,weak)IBOutlet UISlider *overall;
@property (nonatomic,weak)IBOutlet UITextView *comments;
@property (nonatomic,weak)IBOutlet UITextField *professor;
@property (nonatomic,weak)IBOutlet UITextField *courseName;
@property (nonatomic,weak)IBOutlet UITextField *semester;
@property (nonatomic,weak)IBOutlet UITextField *year;
@property (nonatomic,weak)IBOutlet UILabel *course;
@property (nonatomic,weak)IBOutlet UILabel *easinessD;
@property (nonatomic,weak)IBOutlet UILabel *contentD;
@property (nonatomic,weak)IBOutlet UILabel *overallD;
@property (nonatomic,retain) NSString *sname;
@property (nonatomic,retain) NSString *cname;
@property (nonatomic,retain) NSString *snum;


- (IBAction)userDoneEntertingComments:(id)sender;
- (IBAction)SubmitReview:(id)sender;
- (IBAction)contentChange:(id)sender;
- (IBAction)easinessChange:(id)sender;
- (IBAction)overallChange:(id)sender;


@end
