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

#import <Cocoa/Cocoa.h>

#import "XN2DPlot.h"
#import "XNFunction.h"
#import "XNLineData.h"
#import "XNFloatRange.h"
#import "plplot.h"

@interface XN2DPlot (Private)
- (void) initializePLplot;
@end



@implementation XN2DPlot

@synthesize quality;
@synthesize title;

#pragma mark -
#pragma mark Class init methods
+ (XN2DPlot*) plot
{
	return [[XN2DPlot alloc] init];
}

+ (XN2DPlot*) plotInRect: (NSRect)rect withTitle: (NSString*)newTitle quality: (NSUInteger)newQuality
{
	return [[XN2DPlot alloc] initInRect:rect withTitle:newTitle quality:newQuality];
}


#pragma mark -
#pragma mark Instance init methods
- (XN2DPlot*) init
{
	self = [super init];
	return [self initInRect: NSMakeRect(-10.0f, -5.0f, 20.0f, 10.0f) withTitle:@"XN2DPlot" quality:20];
}

- (XN2DPlot*) initInRect: (NSRect)rect withTitle: (NSString*)newTitle quality: (NSUInteger)newQuality
{
	// set range from rect
	xRange = [XNFloatRange rangeWithMin: rect.origin.x max: (rect.origin.x + rect.size.width)];
	yRange = [XNFloatRange rangeWithMin: rect.origin.y max: (rect.origin.y + rect.size.height)];
	
	// set quality
	quality = newQuality;
	
	// and set title at last.
	title = newTitle;
	
	// perform plinit
	[self initializePLplot];
	
	return self;
}

- (void) initializePLplot
{
	// Use aquaterm
	plsdev("aqt");
	
	// Use white background
	plscolbg( 255, 255, 255 );
	
	// init
	plinit();
	
	// 2d env
	plenv( xRange.min, xRange.max, yRange.min, yRange.max, 1, 1);
	pllab([[NSString stringWithString: @"X"] cString], [[NSString stringWithString: @"Y"] cString], [title cString]);
}


#pragma mark -
#pragma mark Drawing API

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
	
	plscol0(15, (NSInteger)([color redComponent]*255), (NSInteger)([color greenComponent]*255), (NSInteger)([color blueComponent]*255));
	plcol(15);
	plline(line.pointsCount, line.xData, line.yData);
}

- (void) finalize
{
	plend();
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	[super dealloc];
}

@end
