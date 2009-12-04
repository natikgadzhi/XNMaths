//
//  XN2DPlot.m
//  XNMaths
//
//  XN2DPlot class.
//  Provides methods to plot within Objective-C object notation.
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//


//
// Import it's own header
#import "XN2DPlot.h"

//
// Import what was marked with @class
#import "XNFunction.h"
#import "XNLineData.h"
#import "XNFloatRange.h"
#import "XNPlotManager.h"

//
// Import PLPlot
#import "plplot.h"


@implementation XN2DPlot

#pragma mark -
#pragma mark Class init methods

+ (XN2DPlot*) plotInRect: (NSRect)rect label: (NSString*)newTitle quality: (NSUInteger)newQuality
{
	return [[XN2DPlot alloc] initInRect:rect label:newTitle quality:newQuality];
}

- (XN2DPlot*) initInRect: (NSRect)rect label: (NSString*)newTitle quality: (NSUInteger)newQuality
{
	
	// set range from rect
	xRange = [XNFloatRange rangeWithMin: rect.origin.x max: (rect.origin.x + rect.size.width)];
	yRange = [XNFloatRange rangeWithMin: rect.origin.y max: (rect.origin.y + rect.size.height)];
	
	// set quality
	quality = newQuality;
	
	// and set title at last.
	label = newTitle;
	
	// connect to manager and start it.
	if([[XNPlotManager sharedManager] addPlot]){
		isReadyToRender = YES;
	} else {
		[NSException raise: @"XNPlotManager error." 
					 format: @"XNPlotManager refused to register the plot. It servs %d plots already.", [XNPlotManager sharedManager].connectedPlots];
	};
	
	// now use plplot routines
//	pladv(0);
//	plvpor(0.05, 0.95, 0.05, 0.95);
//	plwind(xRange.min, xRange.max, yRange.min, yRange.max);
//	plbox("bn", 0, 0, "bn", 0, 0);
	
	plenv(xRange.min, xRange.max, yRange.min, yRange.max, 0, 1);
	pllab("(x axis)", "(y axis)", [label UTF8String]);
	
	return self;
}

#pragma mark -
#pragma mark Drawing API

//
//// FUNCTION
// 

- (void) renderFunction: (XNFunction*)aFunction range: (XNFloatRange*)range color: (NSColor*)color width: (NSUInteger)width
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
	
	[self renderLine: line 
			   color: color 
			   width: width];
}

//
//// POINTS
//

- (void) renderPoint: (XN2DPoint)point color: (NSColor*) color
{
	CGFloat* x = calloc(1, sizeof(CGFloat));
	CGFloat* y = calloc(1, sizeof(CGFloat));
	
	x[0] = point.x;
	y[0] = point.y;
	
	[self renderPointsWithX:x y:y count:1 color:color];
	
	free(x);
	free(y);
}


- (void) renderPoints: (NSArray*) arrayOfPoints color:(NSColor*) color
{
	CGFloat* x = calloc(arrayOfPoints.count, sizeof(CGFloat));
	CGFloat* y = calloc(arrayOfPoints.count, sizeof(CGFloat));
	
	for( NSUInteger i = 0; i < arrayOfPoints.count; i++){
		x[i] = [[arrayOfPoints objectAtIndex:i] pointValue].x;
		y[i] = [[arrayOfPoints objectAtIndex:i] pointValue].y;
	}
	
	[self renderPointsWithX:x y:y count:arrayOfPoints.count color:color];
	
	free(x);
	free(y);
}

- (void) renderPointsWithX: (CGFloat*)x y: (CGFloat*)y  count: (NSUInteger)count color: (NSColor*) color
{
	plscol0(15, (NSInteger)([color redComponent]*255), (NSInteger)([color greenComponent]*255), (NSInteger)([color blueComponent]*255));
	plcol(15);
	plpoin(count, x, y, 21);
	plcol(1);
}


//
//// LINE
//

- (void) renderLine: (XNLineData *)data color: (NSColor *)color width: (NSUInteger)width
{
	// draw!
//	pladv(screenNumber);
	plscol0(15, (NSInteger)([color redComponent]*255), (NSInteger)([color greenComponent]*255), (NSInteger)([color blueComponent]*255));
	plcol(15);
	plwid(width);
	plline(data.pointsCount, data.xData, data.yData);
	
	// back to default width: 
	plwid(1);
	plcol(1);
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	[xRange release];
	[yRange release];
	
	[super dealloc];
}

@end
