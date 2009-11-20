//
//  PHFunctionGraph.h
//  PHGraph
//
//  Created by Pierre-Henri Jondot on 12/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PHGraphObject.h"


@interface PHFunctionGraph : PHGraphObject {
	double (*externalFunction)(double,int*);
	float width;
	NSColor *cocoaColor;
}

-(id)initWithXAxis:(PHxAxis *)xaxis yAxis:(PHyAxis *)yaxis 
	function:(double (*)(double,int*))newFunction;
-(void)setFunction:(double (*)(double,int*))newFunction;
-(void)setWidth:(float)newWidth;
-(void)setColor:(NSColor*)newColor;
@end
