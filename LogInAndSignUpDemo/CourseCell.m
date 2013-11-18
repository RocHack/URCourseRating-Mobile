//
//  CourseCell.m
//  LogInAndSignUpDemo
//
//  Created by Praneet Tata on 7/19/13.
//
//

#import "CourseCell.h"

@implementation CourseCell

@synthesize cname = _cname;
@synthesize courseTitle = _courseTitle;
@synthesize reviewsNumber = _reviewsNumber;
@synthesize content = _content;
@synthesize easiness = _easiness;
@synthesize overall = _overall;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
