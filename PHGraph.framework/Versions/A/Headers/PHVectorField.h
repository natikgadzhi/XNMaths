//
//  PHVectorField.h
//  GraphTest
//
//  Created by Pierre-Henri Jondot on 16/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PHGraphObject.h"

@interface PHVectorField : PHGraphObject {
	int (*externalFunction)(double,double,double*,double*);
	int xGrid,yGrid;
	int style;
	float width;
	NSColor *cocoaColor;
	BOOL multiColor;
	void (*colorFunction)(double,double,float*,float*,float*,float*);
}

-(id)initWithXAxis:(PHxAxis*)xaxis yAxis:(PHyAxis*)yaxis
		  function:(int (*)(double,double,double*,double*))aFunction;

-(void)setFunction:(int (*)(double,double,double*,double*))newFunction;
-(void)setColorFunction:(void (*)(double,double,float*,float*,float*,float*))newFunction;
-(void)setColor:(NSColor *)newColor;
-(void)setXGrid:(int)newXgrid yGrid:(int)newYgrid;
-(void)setWidth:(float)newWidth;

@end
