//
//  XNLinearSpline.h
//  XNMaths
// 
//  LinearSpline class interface.
//  LinearSpline element structure.
// 
//  Created by Нат Гаджибалаев on 20.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

@class XNLineData;

#pragma mark -
#pragma mark XNLInearSplineElement structure. 

//
// Struct that incapsulates interpolation element. 
// 
typedef struct {
	CGFloat a,b;
} XNLinearSplineElement;

//
// Creates new XNLinearInterpolationElement.
//
XNLinearSplineElement XNMakeLinearSplineElement(CGFloat a, CGFloat b);


#pragma mark -
#pragma mark XNLinearSpline interface

@interface XNLinearSpline : NSObject {
	NSArray *approximationPoints; 
	
	XNLinearSplineElement *interpolationElements;
}

+ (XNLinearSpline *) splineWithPoints: (NSArray *)aPoints;

//
// Initialize with approx points
- (XNLinearSpline *) initWithPoints: (NSArray *)aPoints;

#pragma mark -
#pragma mark Data
- (XNLineData*) lineData;

@end
