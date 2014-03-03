//
//  IOSTallyCounterSettingsViewController.m
//  Counters
//
//  Created by David Ladowitz on 3/2/14.
//  Copyright (c) 2014 Little Cat Labs. All rights reserved.
//

#import "IOSTallyCounterSettingsViewController.h"
#import "IOSTallyCounter.h"
#import "IOSTextCell.h"
#import "IOSNumericCell.h"

@interface IOSTallyCounterSettingsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation IOSTallyCounterSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Just one section.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Counter name, current value, initial value.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Determine the reuse identifier for the cell at this row.
    NSInteger row = [indexPath row];
    NSString *cellIdentifier = nil;
    if (row == 0) {
        cellIdentifier = @"TextCell";
    } else {
        cellIdentifier = @"NumericCell";
    }
    // Dequeue a reusable cell for the row.
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                              forIndexPath:indexPath];
    // Set appearance properties for this cell.
    [cell setOpaque:NO];
    switch (indexPath.row) {
        case 0:
            [self applyTextAppearanceToCell:cell withLabel:@"Name"
                                placeholder:@"Counter Name"
                                      value:[self.counter name]];
            break;
        case 1:
            [self applyNumericAppearanceToCell:cell withLabel:@"Current Value"
                                   placeholder:@"Current Value"
                                         value:[self.counter currentValue]];
            break;
        case 2:
            [self applyNumericAppearanceToCell:cell withLabel:@"Initial Value"
                                   placeholder:@"Initial Value"
                                         value:[self.counter initialValue]];
            break;
        default:
            break;
    }
    return cell;
}

- (void)applyTextAppearanceToCell:(id)cell withLabel:(NSString *)label placeholder:(NSString *)placeholder value:(NSString *)value
{
    IOSTextCell *textCell = (IOSTextCell *)cell;
    [[textCell cellLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0]];
    [[textCell cellLabel] setTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.30]];
    [[textCell cellLabel] setText:label];
    [[textCell cellText] setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0]];
    [[textCell cellText] setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [[textCell cellText] setPlaceholder:placeholder];
    [[textCell cellText] setText:value];
}

- (void)applyNumericAppearanceToCell:(id)cell withLabel:(NSString *)label placeholder:(NSString *)placeholder value:(NSInteger)value
{
    IOSNumericCell *numericCell = (IOSNumericCell *)cell;
    [[numericCell cellLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0]];
    [[numericCell cellLabel] setTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.30]];
    [[numericCell cellLabel] setText:label];
    [[numericCell cellText] setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0]];
    [[numericCell cellText] setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [[numericCell cellText] setPlaceholder:placeholder];
    [[numericCell cellText] setText:[NSString stringWithFormat:@"%d", value]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.view endEditing:NO];
    id cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [self.counter setName:[[cell cellText] text]];
    cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    [self.counter setCurrentValue:[[[cell cellText] text] intValue]];
    cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
    [self.counter setInitialValue:[[[cell cellText] text] intValue]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
