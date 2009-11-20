//
//  XN2DLinearSpline.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 20.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XN2DLinearSpline.h"

XN2DLinearSplineElement XNMake2DLinearSplineElement(CGFloat a, CGFloat b)
{
	XN2DLinearSplineElement element;
	element.a = a;
	element.b = b;
	return element;
};



@implementation XN2DLinearSpline

- (XN2DLinearSpline *) initWithPoints: (NSArray *)aPoints
{
	// initialize self reference.
	self = [super init];
	
	// init approx points
	approximationPoints = [aPoints copy];
	interpolationElements = calloc( aPoints.count, sizeof(XN2DLinearSplineElement ));
	
	for( NSInteger i = 1; i < aPoints.count; i++){
		NSPoint startPoint	= [[aPoints objectAtIndex: i-1] pointValue];
		NSPoint endPoint	= [[aPoints objectAtIndex: i] pointValue];
		
		CGFloat a = (endPoint.y - startPoint.y)/(endPoint.x - startPoint.y);
		CGFloat b = (endPoint.y - startPoint.y)/(endPoint.x - startPoint.y)*startPoint.x + startPoint.y;
		
		interpolationElements[i] = XNMake2DLinearSplineElement(a,b);
	}
	
	return self;
}

#pragma mark -
#pragma mark Graphable methods

- (double) doubleValueWithDouble: (double) a_DoubleX
{
	for(NSInteger i = 1; i < approximationPoints.count; i++){
		NSPoint startPoint = [[approximationPoints objectAtIndex:i-1] pointValue];
		NSPoint endPoint = [[approximationPoints objectAtIndex:i] pointValue];
		
		if( startPoint.x < a_DoubleX && endPoint.x > a_DoubleX ){
			return interpolationElements[i].a * a_DoubleX + interpolationElements[i].b;
		}
	}
	
	return 0;
}

- (NSNumber *) objectValueWithDouble: (double) a_DoubleX
{
	return [NSNumber numberWithDouble: [self doubleValueWithDouble:a_DoubleX]]; 
}

- (NSNumber *) objectValueWithObject: (NSNumber *) a_X
{
	return [self objectValueWithDouble: [a_X doubleValue]];
}


#pragma mark -
#pragma mark Dealloc

- (void) dealloc
{
	free(interpolationElements);
	[super dealloc];
}

@end
