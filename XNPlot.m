//
//  XNPlot.m
//  XNMaths
//
//  XNPlot class.
//  Provides methods to plot within Objective-C object notation.
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "XNPlot.h"
#import "XNFunction.h"
#import "XNLineData.h"
#import "XNFloatRange.h"
#import "plplot.h"


@implementation XNPlot

- (XNPlot *) init2D
{
	self = [super init];
	
	xRange = [XNFloatRange rangeWithMin: -1.0f max: 1.0f];
	yRange = [XNFloatRange rangeWithMin: -1.0f max: 1.0f];
	
	quality = 20;
	
	plsdev("aqt");
	plinit();
	plenv( -20.0f, 20.0f, -10.0f, 10.0f, 1, 2);
	
	return self;
}

- (void) renderFunction: (XNFunction*)aFunction inRange: (XNFloatRange*)range withColor: (NSColor*)color;
{
	XNLineData *line = [aFunction createLineDataInRange: range withQuality:quality];
	
	if( xRange.min > range.min){
		xRange.min = range.min;
	}
	
	if( xRange.max < range.max){
		xRange.max = range.max;
	}
	
	if( yRange.min > line.yRange.min ){
		yRange.min = line.yRange.min;
	}
	
	if( yRange.max < line.yRange.max ){
		yRange.max = line.yRange.max;
	}
	
	//pllab([[NSString stringWithString: @"X"] cString], [[NSString stringWithString: @"Y"] cString], [aFunction.expression cString]);
	plscol0(15, (NSInteger)([color redComponent]*255), (NSInteger)([color greenComponent]*255), (NSInteger)([color blueComponent]*255));
	plcol(15);
	plline(line.pointsCount, line.xData, line.yData);
}

- (void) finalize
{
	plend();
}

@end
