//
//  XN2DCubicSpline.h
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XNVector.h"
#import "XNMatrix.h"
#import "XNLinearEquationSystem.h"

@interface XN2DCubicSpline : NSObject {
	
}

# pragma mark -
# pragma mark Initialization methods
- (XN2DCubicSpline *) initWithPoints: (NSArray *) aPoints;


# pragma mark -
# pragma mark XNFunction interface methods
- (double) doubleValueWithDouble: (double) a_X;
- (double) doubleValueWIthObject: (NSNumber *) a_X;
- (NSNumber *) objectValueWithDouble: (double) a_X;
- (NSNumber *) objectValueWithObject: (NSNumber *) a_X;


# pragma mark -
# pragma mark Private methods

// TODO: Add some private methods here. 

@end
