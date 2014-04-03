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
#import "XNMathTypes.hpp"

@implementation XNCubicSpline
{
    CGPoint_vt _approximationPoints;
}

#pragma mark -
#pragma mark Initialization methods

-(void)dealloc
{
    free( a );
    free( b );
    free( c );
    free( d );
    free( h );

    [ super dealloc ];
}

+ (XNCubicSpline *) splineWithPoints: (const CGPoint_vt&) aPoints
{
	return [[[XNCubicSpline alloc] initWithPoints:aPoints]autorelease];
}

- (XNCubicSpline *) initWithPoints: (const CGPoint_vt&) aPoints
{
	self = [super init];

	NSUInteger n = aPoints.size(); 
    NSParameterAssert( n > 2 );


	//
	// Step 1. 
	// Name some variables we will need in the spline. 
    CGFloat_vt vx_( n, 0.f );
    CGFloat_vt vf_( n, 0.f );    
    
	CGFloat* x = &vx_.at( 0 );
    CGFloat* f = &vf_.at( 0 );
	
	// 
	//  The equation matrix
	XNMatrix *equationMatrix = nil;
	
	XNLinearEquationSystem *equationSystem = nil;
	
	// 
	// Step 2. 
	// Initializing and allocating variables and parameters
	// Points count property

    self->_approximationPoints = aPoints;

	//
	// Allocating h with n floats inside, but will use only 
	// n-1 starting not from 0, but from 1. 
	// We will use the same technique for a,b,c,d coefficient arrays.
	// 
	// That's done so to better fit the algorythm, in which
	// h[i] = x[i] - x[i-1].
	h = (CGFloat*)calloc(n-1, sizeof(CGFloat));
	
	a = (CGFloat*)calloc(n-1, sizeof(CGFloat));
	b = (CGFloat*)calloc(n-1, sizeof(CGFloat));
	c = (CGFloat*)calloc(n-1, sizeof(CGFloat));
	d = (CGFloat*)calloc(n-1, sizeof(CGFloat));
	
	//
	// copy X and Y arrays
	for( NSUInteger i = 0; i < n; i++ ){
		x[i] = aPoints[i].x;
		f[i] = aPoints[i].y;
	}
	
	//
	// Fill h array
	for( NSUInteger i = 1; i < n; i++){
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
	
	for( NSUInteger i = 1; i < n-2; i++ ){
		[equationMatrix setValue: h[i-1]
                           atRow: i
                          column: i-1];
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
	
#if defined(__LP64__) && __LP64__
    static const CGFloat oneOverThree = 1./3.;
    static const CGFloat twoOverThree = 2./3.;
#else
    static const CGFloat oneOverThree = 1.f/3.f;
    static const CGFloat twoOverThree = 2.f/3.f;
#endif
    
	for( NSUInteger i = 0; i < n-2; i++ ){
		b[i] = (f[i+1] - f[i])/h[i] - oneOverThree*h[i]*(c[i+1] + 2*c[i]);
		d[i] = (c[i+1] - c[i])/(3*h[i]);
	}

	b[n-2] = (f[n-1] - f[n-2])/h[n-2] - twoOverThree*h[n-2]*c[n-2];
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
    
    xMin = self->_approximationPoints[0].x;
	xMax = self->_approximationPoints[0].x;
	
	for( CGPoint point : self->_approximationPoints )
    {
		if( xMin > point.x ){
			xMin = point.x;
		}
        
		if(xMax < point.x){
			xMax = point.x;
		}
 	}
	
	pointsCount = static_cast<NSUInteger>( (xMax - xMin) * 2 );
	CGFloat step = (xMax - xMin)/static_cast<CGFloat>(pointsCount);
	
	// init data arrays and fill them
	x = (CGFloat*)calloc(pointsCount, sizeof(CGFloat));
	y = (CGFloat*)calloc(pointsCount, sizeof(CGFloat));
	
    static const CGFloat CG_TWO = 2;
    static const CGFloat CG_THREE = 3;
    
    //STODO remove nested cycle
	for(NSUInteger dataIndex = 0; dataIndex < pointsCount; dataIndex++ ){
		CGFloat xValue = xMin + step * dataIndex;
		
		for( NSUInteger i = 1; i < self->_approximationPoints.size(); i++ ){
			if( xValue >= self->_approximationPoints[i-1].x && xValue <= self->_approximationPoints[i].x ){
				CGFloat xFrom = self->_approximationPoints[i-1].x;
				x[dataIndex] = xValue;
				y[dataIndex] =
                    a[i-1] +
                    b[i-1]*(xValue -  xFrom) +
#if defined(__LP64__) && __LP64__
                    c[i-1]*pow((xValue -  xFrom), CG_TWO) +
                    d[i-1]*pow((xValue -  xFrom), CG_THREE);
#else
                    c[i-1]*powf((xValue -  xFrom), CG_TWO) +
                    d[i-1]*powf((xValue -  xFrom), CG_THREE);
#endif
			}
		}
    }
    
	return [XNLineData lineDataWithXData:x yData:y pointsCount:pointsCount];
}

@end
