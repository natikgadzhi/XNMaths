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

#import <Cocoa/Cocoa.h>

#pragma mark -
#pragma mark XNLInearSplineElement structure. 

// Struct that incapsulates interpolation element. 
// 
typedef struct {
	CGFloat a,b;
} XNLinearSplineElement;

// Make interpolation element
//
XNLinearSplineElement XNMakeLinearSplineElement(CGFloat a, CGFloat b);


#pragma mark -
#pragma mark XNLinearSpline interface

@interface XNLinearSpline : NSObject {
	NSArray *approximationPoints; 
	
	XNLinearSplineElement *interpolationElements;
}

//
// Initialize with approx points
- (XNLinearSpline *) initWithPoints: (NSArray *)aPoints;

@end
