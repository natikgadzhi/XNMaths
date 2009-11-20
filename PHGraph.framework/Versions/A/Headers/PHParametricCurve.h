//
//  PHParametricCurve.h
//  PHGraph
//
//  Created by Pierre-Henri Jondot on 15/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PHGraphObject.h"

#ifndef PHEPSILON
#define PHEPSILON 1e-5
#endif


@interface PHParametricCurve : PHGraphObject {
	int (*externalFunction)(double,double*,double*);
	double tmin,tmax;
	int minimumNumberOfPoints;
	int adaptive;
	float width;
	NSColor *cocoaColor;
}

-(id)initWithXAxis:(PHxAxis*)xaxis yAxis:(PHyAxis*)yaxis
	function:(int (*)(double,double*,double*))aFunction
	tmin:(double)valueTmin tmax:(double)valueTmax;
	
-(void)setFunction:(int (*)(double,double*,double*))newFunction;
-(void)setTmin:(double)newTmin;
-(void)setTmax:(double)newTmax;
-(void)setTmin:(double)newTmin tmax:(double)newTmax;
-(void)setWidth:(float)newWidth;
-(void)setMinimumNumberOfPoints:(int)npoints;
-(void)setAdaptive:(int)maxSubdivision;
-(void)setColor:(NSColor*)newColor;

@end
