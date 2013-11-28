//
//  NewCell.m
//  NewsApp
//
//  Created by Praneet Tata on 6/10/13.
//  Copyright (c) 2013 Sol Studios. All rights reserved.
//

#import "NewCell.h"

@implementation NewCell

@synthesize comments = _comments;
@synthesize score = _score;
@synthesize easiness = _easiness;
@synthesize content = _content;
@synthesize semester = _semester;
@synthesize professor = _professor;

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
