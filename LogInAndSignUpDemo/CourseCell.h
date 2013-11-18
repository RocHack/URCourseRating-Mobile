//
//  CourseCell.h
//  LogInAndSignUpDemo
//
//  Created by Praneet Tata on 7/19/13.
//
//

#import <UIKit/UIKit.h>

@interface CourseCell : UITableViewCell


@property (nonatomic,weak) IBOutlet UILabel *cname;
@property (nonatomic,weak) IBOutlet UILabel *courseTitle;
@property (nonatomic,weak) IBOutlet UILabel *reviewsNumber;
@property (nonatomic,weak) IBOutlet UILabel *content;
@property (nonatomic,weak) IBOutlet UILabel *easiness;
@property (nonatomic,weak) IBOutlet UILabel *overall;
@property (nonatomic,weak) IBOutlet UILabel *AO;
@property (nonatomic,weak) IBOutlet UILabel *AC;
@property (nonatomic,weak) IBOutlet UILabel *AE;
@property (nonatomic,weak) IBOutlet UILabel *R;


@end
