//
//  IOSTallyCounter.h
//  HelloiOS
//
//  Created by David Ladowitz on 3/1/14.
//  Copyright (c) 2014 Little Cat Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOSTallyCounter : NSObject

@property NSString *name;
@property NSInteger currentValue;
@property NSInteger initialValue;

- (id)init;
- (id)initWithName:(NSString *)name initialValue:(NSInteger)initial currentValue:(NSInteger)current;

- (void)incrementValue;
- (void)decrementValue;
- (void)resetValue;

@end
