//
//  IOSNumericCell.h
//  Counters
//
//  Created by David Ladowitz on 3/2/14.
//  Copyright (c) 2014 Little Cat Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOSNumericCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UITextField *cellText;

@end
