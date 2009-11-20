//
//  Graphable.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 20.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol Graphable

// Calculate the function value for the argument. 
- (NSNumber*) objectValueWithObject: (NSNumber*)a_X;
- (NSNumber*) objectValueWithDouble: (double) a_DoubleX;
- (double) doubleValueWithDouble: (double) a_DoubleX;
	
@end
