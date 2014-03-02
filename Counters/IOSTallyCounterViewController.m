//
//  IOSViewController.m
//  Counters
//
//  Created by David Ladowitz on 3/1/14.
//  Copyright (c) 2014 Little Cat Labs. All rights reserved.
//

#import "IOSTallyCounterViewController.h"
#import "IOSTallyCounter.h"

@interface IOSTallyCounterViewController ()
// *****************************************************
# pragma mark                    User Interface Controls
// *****************************************************
@property (weak, nonatomic) IBOutlet UILabel *counterTitle;
@property (weak, nonatomic) IBOutlet UILabel *counterValue;

// *****************************************************
# pragma mark                              Model Objects
// *****************************************************
@property (strong, nonatomic) IOSTallyCounter *counter;


@end

@implementation IOSTallyCounterViewController

static void *CounterNameObservationContext = &CounterNameObservationContext;
static NSString *kCounterNameKey = @"name";

static void *CounterValueObservationContext = &CounterValueObservationContext;
static NSString *kCounterValueKey = @"currentValue";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // TODO: Move this out of the view controller eventually.
    self.counter = [[IOSTallyCounter alloc] initWithName:@"My Counter"
                                            initialValue:10
                                            currentValue:0];
    // Trick to force initial update.
    self.counter.name = self.counter.name;
    self.counter.currentValue = self.counter.currentValue;
    self.counter.initialValue = self.counter.initialValue;
}

- (IBAction)incrementCounter:(id)sender {
    [self.counter incrementValue];
}

- (IBAction)decrementCounter:(id)sender {
    [self.counter decrementValue];
}

- (void)updateCounterName
{
    self.counterTitle.text = self.counter.name;
}

- (void)updateCounterValue
{
    self.counterValue.text = [NSString stringWithFormat:@"%d", self.counter.currentValue];
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    NSString *selectorName = NSStringFromSelector(_cmd);
    NSLog(@"[%@,%@]", className, selectorName);

}
- (IBAction)viewWasTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"Starting Tap....");
    
    // Determine where the user tapped.
    CGPoint tapPoint = [sender locationInView:self.view];
    
    // Determine the vertical center of the view.
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat verticalCenter = viewHeight / (CGFloat)2.0;
    
    // Decide whether to increment or decrement based on where user tapped.
    if (tapPoint.y < verticalCenter) {
        [self.counter incrementValue];
    } else {
        [self.counter decrementValue];
    }
}

- (void)addObservers
{
    if (self.counter != nil)
    {
        NSKeyValueObservingOptions kvoOptions = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
        [self.counter addObserver:self forKeyPath:kCounterNameKey options:kvoOptions context:CounterNameObservationContext];
        [self.counter addObserver:self forKeyPath:kCounterValueKey options:kvoOptions context:CounterValueObservationContext];
    }
}

- (void)removeObservers
{
    if (self.counter != nil) {
        [self.counter removeObserver:self forKeyPath:kCounterNameKey];
        [self.counter removeObserver:self forKeyPath:kCounterValueKey];
    }
}

- (void)setCounter:(IOSTallyCounter *)counter
{
    [self removeObservers];
    _counter = counter;
    [self addObservers];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    id kvoChangeKind = [change objectForKey:NSKeyValueChangeKindKey];
    NSKeyValueChange changeType = (NSKeyValueChange)[kvoChangeKind unsignedIntegerValue];
    if (changeType == NSKeyValueChangeSetting) {
        if (context == CounterValueObservationContext) {
            NSInteger oldValue = (NSInteger)[[change objectForKey:NSKeyValueChangeOldKey] integerValue];
            NSInteger newValue = (NSInteger)[[change objectForKey:NSKeyValueChangeNewKey] integerValue];
            NSLog(@"value changed from %d to %d\n", oldValue, newValue);
            [self updateCounterValue];
        } else if (context == CounterNameObservationContext) {
            NSString *oldName = (NSString *)[change objectForKey:NSKeyValueChangeOldKey];
            NSString *newName = (NSString *)[change objectForKey:NSKeyValueChangeNewKey];
            NSLog(@"value changed from '%@' to '%@'\n", oldName, newName);
            [self updateCounterName];
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _counter = nil;
    }
    return self;
}

- (void)dealloc
{
    [self removeObservers];
    _counter = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
