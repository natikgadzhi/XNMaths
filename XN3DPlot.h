//
//  XN3DPlot.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import <Cocoa/Cocoa.h>
@class XNBox;
@class XNFloatRange;
@class XNSurfaceData;

#pragma mark -
#pragma mark XN3DPlot class interface

@interface XN3DPlot : NSObject {
	XNFloatRange *xRange, *yRange, *zRange;
	NSString *title;
	
	NSUInteger azimuth, altitude;
}

#pragma mark -
#pragma mark Class init methods
+ (XN3DPlot*) plot;
+ (XN3DPlot*) plotWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth title: (NSString*) aTitle;

#pragma mark -
#pragma mark Instance init methods
- (XN3DPlot*) init;
- (XN3DPlot*) initWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth title: (NSString*) aTitle;

#pragma mark -
#pragma mark Rendering API
- (void) renderSurface: (XNSurfaceData*)surface ofColor: (NSColor *)color;

#pragma mark -
#pragma mark Instance methods
- (void) finalize;

@end
