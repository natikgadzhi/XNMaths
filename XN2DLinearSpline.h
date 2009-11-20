//
//  XN2DLinearSpline.h
//  XNMaths
// 
//  2DLinearSpline
//  Interpolates a 2D function in some points array with a linear spline.
// 
//
//  Created by Нат Гаджибалаев on 20.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Graphable.h"

// Struct that incapsulates interpolation element. 
// 
typedef struct {
	CGFloat a,b;
} XN2DLinearSplineElement;

// Make interpolation element
//
XN2DLinearSplineElement XNMake2DLinearSplineElement(CGFloat a, CGFloat b);


@interface XN2DLinearSpline : NSObject <Graphable> {
	NSArray *approximationPoints; 
	
	XN2DLinearSplineElement *interpolationElements;
}

//
// Initialize with approx points
- (XN2DLinearSpline *) initWithPoints: (NSArray *)aPoints;

@end
