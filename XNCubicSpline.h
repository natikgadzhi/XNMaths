//
//  XNCubicSpline.h
// 
//  XNFuntion interpolation witn cubic spline
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XNVector.h"
#import "XNMatrix.h"
#import "XNLinearEquationSystem.h"

@interface XNCubicSpline : NSObject {
	
}

# pragma mark -
# pragma mark Initialization methods
- (XNCubicSpline *) initWithPoints: (NSArray *) aPoints;


# pragma mark -
# pragma mark Value getters
- (double) doubleValueWithDouble: (double) a_DoubleX;


# pragma mark -
# pragma mark Private methods

// TODO: Add some private methods here. 

@end
