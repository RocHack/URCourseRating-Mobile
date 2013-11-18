//
//  NewCell.h
//  NewsApp
//
//  Created by Praneet Tata on 6/10/13.
//  Copyright (c) 2013 Sol Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UITextView *comments;
@property (nonatomic,weak) IBOutlet UIImageView *score;
@property (nonatomic,weak) IBOutlet UIImageView *easiness;
@property (nonatomic,weak) IBOutlet UIImageView *content;
@property (nonatomic,weak) IBOutlet UILabel *date;
@property (nonatomic,weak) IBOutlet UILabel *semester;
@property (nonatomic,weak) IBOutlet UILabel *professor;
@property (nonatomic,weak) IBOutlet UILabel *com;
@property (nonatomic,weak) IBOutlet UILabel *C;
@property (nonatomic,weak) IBOutlet UILabel *E;
@property (nonatomic,weak) IBOutlet UILabel *O;
@property (nonatomic,weak) IBOutlet UILabel *submission;
@property (nonatomic,weak) IBOutlet UILabel *status;
@end
