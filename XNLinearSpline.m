//
//  XNLinearSpline.m
//  XNMaths
//
//  XNLinearSplineElements functions (builders)
//  
//  XNLinearSpline implementation
//  Interpolates a 2D function in some points array with a linear spline.
//  
//
//  Created by Нат Гаджибалаев on 20.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNLinearSpline.h"
#import "XNLineData.h"

#import <UIKit/UIKit.h>

#pragma mark -
#pragma	mark Spline interploation element data 

//
// Make spline element.
XNLinearSplineElement XNMakeLinearSplineElement(CGFloat a, CGFloat b)
{
	XNLinearSplineElement element;
	element.a = a;
	element.b = b;
	return element;
};

#pragma mark -
#pragma mark Spline class implementation.

@implementation XNLinearSpline

+ (XNLinearSpline *) splineWithPoints: (NSArray *)aPoints
{
	return [[[XNLinearSpline alloc] initWithPoints: aPoints]autorelease];
}

- (XNLinearSpline *) initWithPoints: (NSArray *)aPoints
{
	// initialize self reference.
	self = [super init];
	
	// init approx points
	approximationPoints = [aPoints copy];
	
	return self;
}

#pragma mark -
#pragma mark Value getters

- (float) valueWithFloat: (CGFloat) a_X
{
	for(NSInteger i = 1; i < approximationPoints.count; i++){
		CGPoint startPoint = [[approximationPoints objectAtIndex:i-1] CGPointValue];
		CGPoint endPoint = [[approximationPoints objectAtIndex:i] CGPointValue];
		
		if( startPoint.x < a_X && endPoint.x > a_X ){
			return interpolationElements[i].a * a_X + interpolationElements[i].b;
		}
	}
	
	return 0;
}

- (XNLineData*) lineData
{
	CGFloat* x = calloc(approximationPoints.count, sizeof(CGFloat));
	CGFloat* y = calloc(approximationPoints.count, sizeof(CGFloat));
	
	for( NSUInteger i = 0; i < approximationPoints.count; i++ ){
		x[i] = [[approximationPoints objectAtIndex:i] CGPointValue].x;
		y[i] = [[approximationPoints objectAtIndex:i] CGPointValue].y;
	}
	
	return [XNLineData lineDataWithXData:x yData:y pointsCount:approximationPoints.count];
}

#pragma mark -
#pragma mark Dealloc

- (void) dealloc
{
	free(interpolationElements);
	
	[approximationPoints release];
	[super dealloc];
}

@end
