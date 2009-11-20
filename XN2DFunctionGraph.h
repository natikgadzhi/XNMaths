//
//  XN2DFunctionGraph.h
//  Assignation 3
//
//  Created by Нат Гаджибалаев on 09.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PHGraph/PHGraphObject.h>
#import "Graphable.h"

@interface XN2DFunctionGraph : PHGraphObject {
	
	id <Graphable> mFunction;
	float width;
	NSColor *cocoaColor;
}

-(id)initWithXAxis:(PHxAxis *)xaxis yAxis:(PHyAxis *)yaxis 
		  function: (id <Graphable>) newFunction;

-(void)setFunction: (id <Graphable>)newFunction;
-(void)setWidth:(float)newWidth;
-(void)setColor:(NSColor*)newColor;
@end
