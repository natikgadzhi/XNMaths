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
#import "XN2DPoint.h"
#import "plplot.h"

@interface XN2DPlot (Private)
- (void) initializePLplot;
//- (void) setCurrentColor: (NSColor*)color;

- (void) renderPointsWithX: (CGFloat*)x y: (CGFloat*)y  count: (NSUInteger)count color: (NSColor*) color;
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
	// default values 
	labelsDrawn = 0;
	
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
	plscol0(1, 0, 0, 0);
	plcol(1);
	plenv( xRange.min, xRange.max, yRange.min, yRange.max, 1, 1);
	pllab([[NSString stringWithString: @"(x axis)"] cString], [[NSString stringWithString: @"(y axis)"] cString], [title cString]);
	plscol0(1, 1, 0, 0);
}


#pragma mark -
#pragma mark Drawing API

- (void) renderFunction: (XNFunction*)aFunction inRange: (XNFloatRange*)range withColor: (NSColor*)color;
{
	[self renderFunction:aFunction inRange:range withColor:color labeled: aFunction.expression];
}

- (void) renderFunction: (XNFunction*)aFunction inRange: (XNFloatRange*)range withColor: (NSColor*)color width: (NSUInteger)width
{
	[self renderFunction:aFunction inRange:range withColor:color labeled: aFunction.expression width: width];
}

- (void) renderFunction: (XNFunction*)aFunction inRange: (XNFloatRange*) range withColor: (NSColor*)color labeled: (NSString*)label 
{
	[self renderFunction:aFunction inRange:range withColor:color labeled: aFunction.expression width: 1];
}

- (void) renderFunction: (XNFunction*)aFunction inRange: (XNFloatRange*) range withColor: (NSColor*)color labeled: (NSString*)label width: (NSUInteger)width
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
	
	// draw!
	[self renderLine: line color: color width: width];
	
	// label!
	//plptex( xRange.min + 1.0f , yRange.max - 1.0f - labelsDrawn * 0.8f, 1.0f, 0.0f, 1, [label cString] );
	//NSLog(label);
	
	labelsDrawn++;
}

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

- (void) renderLine: (XNLineData *)data color: (NSColor *)color width: (NSUInteger)width
{
	// draw!
	plscol0(15, (NSInteger)([color redComponent]*255), (NSInteger)([color greenComponent]*255), (NSInteger)([color blueComponent]*255));
	plcol(15);
	plwid(width);
	plline(data.pointsCount, data.xData, data.yData);
	
	// back to default width: 
	plwid(1);
}

- (void) renderPointsWithX: (CGFloat*)x y: (CGFloat*)y  count: (NSUInteger)count color: (NSColor*) color
{
	plscol0(15, (NSInteger)([color redComponent]*255), (NSInteger)([color greenComponent]*255), (NSInteger)([color blueComponent]*255));
	plcol(15);
	plpoin(count, x, y, 21);
}

- (void) finalize
{
	plend1();
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	[super dealloc];
}

@end
