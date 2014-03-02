//
//  IOSTallyCounter.m
//  HelloiOS
//
//  Created by David Ladowitz on 3/1/14.
//  Copyright (c) 2014 Little Cat Labs. All rights reserved.
//

#import "IOSTallyCounter.h"

@implementation IOSTallyCounter

- (id)init
{
    return [self initWithName:@"Default Name" initialValue:0 currentValue:0];
}

- (id)initWithName:(NSString *)name initialValue:(NSInteger)initial currentValue:(NSInteger)current
{
    self = [super init];
    if (self != nil) {
        _name = [name copy];
        _initialValue = initial;
        _currentValue = current;
    }
    return self;
}

- (void)incrementValue
{
    NSLog(@"Incrementing Value");
    self.currentValue = self.currentValue + 1;
}

- (void)decrementValue
{
    NSLog(@"Decrementing Value");
    self.currentValue = self.currentValue - 1;
}


- (void)resetValue
{
    self.currentValue = self.initialValue;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"<%@: name='%@', initial=%d, current=%d>",
            NSStringFromClass([self class]), self.name,
            self.initialValue, self.currentValue];
}

- (BOOL)isEqual:(id)object
{
    // Only compare instance variable values if the passed object is
    // of the proper type.
    if ([object isKindOfClass:[IOSTallyCounter class]]) {
        IOSTallyCounter *passedCounter = (IOSTallyCounter *)object;
        BOOL namesAreEqual = [self.name isEqualToString:[passedCounter name]];
        BOOL currentValuesAreEqual = self.currentValue == passedCounter.currentValue;
        BOOL initialValuesAreEqual = self.initialValue == passedCounter.initialValue;
        return namesAreEqual && currentValuesAreEqual && initialValuesAreEqual;
    }
    // The objects cannot be equal since they are not of the same type!
    return NO;
}

@end
