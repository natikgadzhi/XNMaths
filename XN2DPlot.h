//
//  XN2DPlot.h
//  XNMaths
//
//  XN2DPlot class.
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XNFloatRange;
@class XNLineData;
@class XNFunction;

@interface XN2DPlot : NSObject {
	
	// show this range
	XNFloatRange *xRange, *yRange;
	
	// with this graph title "XN2DPlot" is default.
	NSString *title;
	
	// and this calculation quality. Points per one float unit (1.0f). 20 is default.
	NSUInteger quality;
}

@property(readonly) NSString *title;
@property(readonly) NSUInteger quality;

#pragma mark -
#pragma mark Class init methods
+ (XN2DPlot*) plot;
+ (XN2DPlot*) plotInRect: (NSRect)rect withTitle: (NSString*)newTitle quality: (NSUInteger)newQuality;

#pragma mark -
#pragma mark Instance init methods
- (XN2DPlot*) init;
- (XN2DPlot*) initInRect: (NSRect)rect withTitle: (NSString*)newTitle quality: (NSUInteger)newQuality;


#pragma mark -
#pragma mark Drawing API
- (void) renderFunction: (XNFunction*)aFunction inRange: (XNFloatRange*) range withColor: (NSColor*)color;

#pragma mark -
#pragma mark Finalize
- (void) finalize;

@end
