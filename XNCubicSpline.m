//
//  XNCubicSpline.m
//
//  Provices XNCubicSplineInterploation class. 
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNCubicSpline.h"
#import "XNMatrix.h"


@implementation XNCubicSpline

# pragma mark -
# pragma mark Initialization methods

- (XNCubicSpline *) initWithPoints: (NSArray *) aPoints
{
	self = [super init];
	
	//
	// Step 1. 
	// Name some variables we will need in the spline. 
	//
	// These are arrays to store numbers / characteristics. 
	CGFloat *x, *f, *a, *b, *c, *d, *h;
	
	// 
	//  The equation matrix
	XNMatrix *equationMatrix;
	
	XNLinearEquationSystem *equationSystem;
	
	//
	// and this is the count of points supplied. 
	NSUInteger n;
	
	
	// 
	// Step 2. 
	// Initializing and allocating variables and parameters
	// Points count property
	n = aPoints.count; 
	
	//
	// alloc X and Y arrays.
	x = calloc(n, sizeof(CGFloat));
	f = calloc(n, sizeof(CGFloat));
	
	//
	// Allocating h with n floats inside, but will use only 
	// n-1 starting not from 0, but from 1. 
	// We will use the same technique for a,b,c,d coefficient arrays.
	// 
	// That's done so to better fit the algorythm, in which
	// h[i] = x[i] - x[i-1].
	h = calloc(n, sizeof(CGFloat));
	
	//
	// copy X and Y arrays
	for( NSInteger i = 0; i < n; i++ ){
		x[i] = [[aPoints objectAtIndex:i] pointValue].x;
		f[i] = [[aPoints objectAtIndex:i] pointValue].y;
	}
	
	//
	// Fill h array
	for( NSInteger i = 1; i < n; i++){
		h[i] = x[i] - x[i-1];
	}
	
	//
	// Init the matrix 
	equationMatrix = [[XNMatrix alloc] initWithRows: n-1 columns: n];
	
	// 
	// Now fill in some data into the matrix.
	// Take a look deeper: 
	// 1) We start filling it from the corner (0,0), however the first string solves equation to get C2, not C1. 
	// Etc. 
	
	// Set the first row out of the loop
	[equationMatrix	setValue: 2*( h[1] + h[2]) atRow:0 column: 0];
	[equationMatrix	setValue: h[2] atRow:0 column: 1];
	[equationMatrix	setValue: 3*( (f[2]-f[1])/h[2] - (f[1]-f[0])/h[1] ) atRow:0 column: n-1];
	
	for( NSInteger i = 3; i <= n; i++ ){
		[equationMatrix setValue: h[i-1] atRow: i-2 column: i-3];
		[equationMatrix setValue:(2*(h[i-1] + h[i])) atRow:i-2 column:i-2 ];
		[equationMatrix	setValue: h[i] atRow:i-2 column: i-1];
		[equationMatrix	setValue: 3*( (f[2]-f[1])/h[2] - (f[1]-f[0])/h[1] ) atRow:i-2 column: n-1];
 	}
	
	//
	// DEBUG: 
	[equationMatrix printToLog];
	
	equationSystem = [[XNLinearEquationSystem alloc] initWithMatrix:equationMatrix];
	
	XNVector *cVector = [equationSystem sweep];
	
	[cVector printToLog];
	
	// TODO: Save the points array, calculate coeficients..
	
	return self;
}

# pragma mark -
# pragma mark XNFunction interface methods

// Returns double value of spline interpolation function at X point by a double. 
- (double) doubleValueWithDouble: (double) a_X
{
	double value;
	return value; 
}

// Returns double value of spline interpolation function at X point by an NSNumber object. 
- (double) doubleValueWIthObject: (NSNumber *) a_X
{
	double value;
	return value; 
}

// Returns NSNumber * value of spline interpolation function at X point by a double. 
- (NSNumber *) objectValueWithDouble: (double) a_X
{
	NSNumber *valueObject = [NSNumber numberWithDouble: 0.0];
	return valueObject;
}

// Returns NSNumber * value of spline interpolation function at X point by an NSNumber object. 
- (NSNumber *) objectValueWithObject: (NSNumber *) a_X
{
	NSNumber *valueObject = [NSNumber numberWithDouble: 0.0];
	return valueObject;	
}

# pragma mark -
# pragma mark Private methods

@end
