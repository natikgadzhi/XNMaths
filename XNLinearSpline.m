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
	return [[XNLinearSpline alloc] initWithPoints: aPoints];
}

- (XNLinearSpline *) initWithPoints: (NSArray *)aPoints
{
	// initialize self reference.
	self = [super init];
	
	// init approx points
	approximationPoints = [aPoints copy];

	// TODO: Fixme. It doesn't work fine for me.

//	interpolationElements = calloc( aPoints.count, sizeof(XNLinearSplineElement ));
//	
//	for( NSInteger i = 1; i < aPoints.count; i++){
//		NSPoint startPoint	= [[aPoints objectAtIndex: i-1] pointValue];
//		NSPoint endPoint	= [[aPoints objectAtIndex: i] pointValue];
//		
//		CGFloat a = (endPoint.y - startPoint.y)/(endPoint.x - startPoint.y);
//		CGFloat b = (endPoint.y - startPoint.y)/(endPoint.x - startPoint.y)*startPoint.x + startPoint.y;
//		
//		interpolationElements[i] = XNMakeLinearSplineElement(a,b);
//	}
	
	return self;
}

#pragma mark -
#pragma mark Value getters

- (float) valueWithFloat: (CGFloat) a_X
{
	for(NSInteger i = 1; i < approximationPoints.count; i++){
		NSPoint startPoint = [[approximationPoints objectAtIndex:i-1] pointValue];
		NSPoint endPoint = [[approximationPoints objectAtIndex:i] pointValue];
		
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
		x[i] = [[approximationPoints objectAtIndex:i] pointValue].x;
		y[i] = [[approximationPoints objectAtIndex:i] pointValue].y;
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
