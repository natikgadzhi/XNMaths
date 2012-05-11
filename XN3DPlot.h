//
//  XN3DPlot.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

@class XNBox;
@class UIColor;
@class XNFloatRange;
@class XNSurfaceData;

#pragma mark -
#pragma mark XN3DPlot class interface

@interface XN3DPlot : NSObject {
	XNFloatRange *xRange, *yRange, *zRange;
	NSString *label;
	
	NSUInteger azimuth, altitude;
	BOOL isReadyToRender;
}

#pragma mark -
#pragma mark Class init methods
+ (XN3DPlot*) plotWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth label: (NSString*) aTitle;
- (XN3DPlot*) initWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth label: (NSString*) aTitle;

#pragma mark -
#pragma mark Rendering API
- (void) renderSurface: (XNSurfaceData*)surface color: (UIColor *)color;

@end
