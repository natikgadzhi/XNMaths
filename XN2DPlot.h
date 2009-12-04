//
//  XN2DPlot.h
//  XNMaths
//
//  XN2DPlot class.
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import <Cocoa/Cocoa.h>
#import "XN2DPoint.h"

@class XNFloatRange;
@class XNLineData;
@class XNFunction;
@class XNPlotManager;

#pragma mark -
#pragma mark XN2DPlot interface

@interface XN2DPlot : NSObject {
	
	// show this range
	XNFloatRange *xRange, *yRange;
	
	// label to draw 
	NSString *label;
	
	// quality of functions
	NSUInteger quality;
	
	// ready to accept render calls? 
	BOOL isReadyToRender;
}

#pragma mark -
#pragma mark Init methods
+ (XN2DPlot*) plotInRect: (NSRect)rect label: (NSString*)newTitle quality: (NSUInteger)newQuality;
- (XN2DPlot*) initInRect: (NSRect)rect label: (NSString*)newTitle quality: (NSUInteger)newQuality;

#pragma mark -
#pragma mark Drawing API
- (void) renderFunction: (XNFunction *) aFunction range: (XNFloatRange *) range color: (NSColor *) color width: (NSUInteger) width;

- (void) renderPoint: (XN2DPoint) point color: (NSColor*)color;
- (void) renderPoints: (NSArray*) arrayOfPoints color: (NSColor*)color;
- (void) renderPointsWithX: (CGFloat*)x y: (CGFloat*)y  count: (NSUInteger)count color: (NSColor*) color;

- (void) renderLine: (XNLineData *)lineData color: (NSColor *) color width: (NSUInteger) width;

@end
