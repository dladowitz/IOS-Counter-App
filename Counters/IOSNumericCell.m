//
//  IOSNumericCell.m
//  Counters
//
//  Created by David Ladowitz on 3/2/14.
//  Copyright (c) 2014 Little Cat Labs. All rights reserved.
//

#import "IOSNumericCell.h"

@implementation IOSNumericCell

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
