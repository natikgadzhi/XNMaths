//
//  PHPoints.h
//  Graph
//
//  Created by Pierre-Henri Jondot on 01/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PHGraphObject.h"

//Symbols predefined

#define PHCrossx 1
#define PHCrossplus 2
#define PHCircle 4
#define PHDiamond 8
#define PHImpulse 16

@interface PHPoints : PHGraphObject {
	double *xData, *yData;
	int numberOfPoints;
	float size;
	float width;
	int style;
	NSColor *cocoaColor;
}

-(id)initWithXData:(double*)xd yData:(double*)yd numberOfPoints:(int)np
		xAxis:(PHxAxis*)xaxis yAxis:(PHyAxis*)yaxis;
		
-(void)setSize:(float)newSize;
-(void)setWidth:(float)newWidth;
-(void)setStyle:(int)newStyle;
-(void)setNumberOfPoints:(int)newNumberOfPoints;
-(void)setColor:(NSColor*)newColor;
	
@end
