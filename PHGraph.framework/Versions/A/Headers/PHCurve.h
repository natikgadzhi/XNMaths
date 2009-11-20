//
//  PHCurve.h
//  Graph
//
//  Created by Pierre-Henri Jondot on 02/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PHGraphObject.h"

#define PHStraight 0
#define PHDashed33 1
#define PHDashed8212 2

@interface PHCurve : PHGraphObject	{
	double *xData, *yData;
	int numberOfPoints;
	float width;
	int style;
	NSColor *cocoaColor;
}

-(id)initWithXData:(double*)xd yData:(double*)yd numberOfPoints:(int)np
		xAxis:(PHxAxis*)xaxis yAxis:(PHyAxis*)yaxis;
		
-(void)setWidth:(float)newWidth;
-(void)setStyle:(int)newStyle;
-(void)setNumberOfPoints:(int)newNumberOfPoints;
-(void)setColor:(NSColor*)newColor;

@end
