//
//  XNCubicSpline.m
//
//  Provices XNCubicSplineInterploation class. 
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNCubicSpline.h"
#import "XNVector.h"
#import "XNMatrix.h"
#import "XNLineData.h"
#import "XNLinearEquationSystem.h"

#import <UIKit/UIKit.h>

@implementation XNCubicSpline

#pragma mark -
#pragma mark Initialization methods

+ (XNCubicSpline *) splineWithPoints: (NSArray *) aPoints
{
	return [[[XNCubicSpline alloc] initWithPoints:aPoints]autorelease];
}

- (XNCubicSpline *) initWithPoints: (NSArray *) aPoints
{
	self = [super init];
	
	//
	// Step 1. 
	// Name some variables we will need in the spline. 
	CGFloat *x, *f;
	
	// 
	//  The equation matrix
	XNMatrix *equationMatrix;
	
	XNLinearEquationSystem *equationSystem;
	
	NSUInteger n; 
	
	// 
	// Step 2. 
	// Initializing and allocating variables and parameters
	// Points count property
	n = aPoints.count; 
	
	approximationPoints = [aPoints retain];
	
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
	h = calloc(n-1, sizeof(CGFloat));
	
	a = calloc(n-1, sizeof(CGFloat));
	b = calloc(n-1, sizeof(CGFloat));
	c = calloc(n-1, sizeof(CGFloat));
	d = calloc(n-1, sizeof(CGFloat));
	
	//
	// copy X and Y arrays
	for( NSInteger i = 0; i < n; i++ ){
		x[i] = [[aPoints objectAtIndex:i] CGPointValue].x;
		f[i] = [[aPoints objectAtIndex:i] CGPointValue].y;
	}
	
	//
	// Fill h array
	for( NSInteger i = 1; i < n; i++){
		h[i-1] = x[i] - x[i-1];
	}
	
	//
	// Init the matrix 
	equationMatrix = [[[XNMatrix alloc] initWithRows: n-2 columns: n-1]autorelease];
	
	// 
	// Now fill in some data into the matrix.
	// Take a look deeper: 
	// 1) We start filling it from the corner (0,0), however the first string solves equation to get C2, not C1. 
	// Etc. 
	
	// Set the first row out of the loop
	[equationMatrix	setValue: 2*( h[0] + h[1]) atRow:0 column: 0];
	[equationMatrix	setValue: h[1] atRow:0 column: 1];
	[equationMatrix	setValue: 3*( (f[2]-f[1])/h[1] - (f[1]-f[0])/h[0] ) atRow:0 column: n-2];
	
	for( NSInteger i = 1; i < n-2; i++ ){
		[equationMatrix setValue: h[i-1] atRow: i column: i-1];
		[equationMatrix setValue: (2*(h[i-1] + h[i])) atRow:i column:i ];
		[equationMatrix	setValue: h[i] atRow:i column: i+1];
		
		[equationMatrix	setValue: 3*( (f[i+2]-f[i+1])/h[i+1] - (f[i+1]-f[i])/h[i] ) atRow:i column: n-2];
 	}
	
	equationSystem = [[[XNLinearEquationSystem alloc] initWithMatrix:equationMatrix]autorelease];
	
	XNVector *cVector = [equationSystem sweep];
	
	//
	// setting values... 
	// 
	
	//
	// c0 is always 0.
	c[0] = 0;
	
	//
	// set C values. 
	for( NSUInteger i = 1; i < n-1; i++ ){
		c[i] = [cVector valueAtIndex: i-1];
	}
	
	// 
	// set values for a-d
	for( NSUInteger i = 0; i < n-1; i++ ){
		a[i] = f[i];
	}
	
	for( NSUInteger i = 0; i < n-2; i++ ){
		b[i] = (f[i+1] - f[i])/h[i] - (1./3.)*h[i]*(c[i+1] + 2*c[i]);
		d[i] = (c[i+1] - c[i])/(3*h[i]);
	}
	
	b[n-2] = (f[n-1] - f[n-2])/h[n-2] - (2./3.)*h[n-2]*c[n-2];
	d[n-2] = -c[n-2]/(3*h[n-2]);
	
	return self;
}

- (XNLineData *) lineData
{
	// data
	CGFloat *x, *y;
	
	// count of points in data arrays
	NSUInteger pointsCount = 0;
	
	// range of datapoints.
	CGFloat xMin, xMax; 
	
	xMin = [[approximationPoints objectAtIndex:0] CGPointValue].x;
	xMax = [[approximationPoints objectAtIndex:0] CGPointValue].x;
	
	for(NSValue *pointObject in approximationPoints){
		CGPoint point = [pointObject CGPointValue];
		
		if( xMin > point.x ){
			xMin = point.x;
		}
		
		if(xMax < point.x){
			xMax = point.x;
		}
 	}
	
	pointsCount = (int)(xMax - xMin) * 100;
	CGFloat step = (xMax - xMin)/(float)pointsCount;
	
	// init data arrays and fill them
	x = calloc(pointsCount, sizeof(CGFloat));
	y = calloc(pointsCount, sizeof(CGFloat));
	
	for(NSUInteger dataIndex = 0; dataIndex < pointsCount; dataIndex++ ){
		CGFloat xValue = xMin + step * dataIndex;
		
		for( NSUInteger i = 1; i < approximationPoints.count; i++ ){
			if( xValue >= [[approximationPoints objectAtIndex: i-1] CGPointValue].x && xValue <= [[approximationPoints objectAtIndex: i] CGPointValue].x ){
				CGFloat xFrom = [[approximationPoints objectAtIndex: i-1] CGPointValue].x;
				x[dataIndex] = xValue;
				y[dataIndex] = a[i-1] + b[i-1]*(xValue -  xFrom) + c[i-1]*pow((xValue -  xFrom), 2) + d[i-1]*pow((xValue -  xFrom), 3);
			}
		}
		
		//NSLog(@"calculating point %d at %f with value %f", dataIndex, x[dataIndex], y[dataIndex]);
	}
	
	NSLog(@"%d points total from x = %f to %f with step %f", pointsCount, xMin, xMax, step);
	
	return [XNLineData lineDataWithXData:x yData:y pointsCount:pointsCount];
}


@end
