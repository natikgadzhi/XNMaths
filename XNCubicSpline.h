//
//  XNCubicSpline.h
// 
//  XNFuntion interpolation witn cubic spline
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import <CoreGraphics/CoreGraphics.h>

#include <vector>

@class XNLineData;

// any classes? 

#pragma mark -
#pragma mark XNCubicSpline class interface

@interface XNCubicSpline : NSObject {
	CGFloat *a, *b, *c, *d, *h;
}

#pragma mark -
#pragma mark Initialization methods
+ (XNCubicSpline *) splineWithPoints: (const std::vector< CGPoint >&) aPoints;

- (XNCubicSpline *) initWithPoints: (const std::vector< CGPoint >&) aPoints;

#pragma mark -
#pragma mark Other methods
- (XNLineData *) lineData;

@end
