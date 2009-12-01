//
//  XN3DPlot.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import "XN3DPlot.h"

#import "XNSurfaceData.h"
#import "XNBox.h"
#import "XNFloatRange.h"
#import "plplot.h"

#pragma mark -
#pragma mark Private category of XN3DPlot
@interface XN3DPlot (Private)

- (void) initializePLPlot;

@end

#pragma mark -
#pragma mark XN3DPlot class implementation

@implementation XN3DPlot

#pragma mark -
#pragma mark Class init methods
+ (XN3DPlot*) plot
{
	return [[XN3DPlot alloc] init];
}

+ (XN3DPlot*) plotWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth title: (NSString*) aTitle
{
	return [[XN3DPlot alloc] initWithBox: aBox altitude: aAltitude azimuth: aAzimuth title: aTitle];
}

#pragma mark -
#pragma mark Instance init methods
- (XN3DPlot*) init
{
	self = [super init];
	XNFloatRange *simpleRange = [XNFloatRange rangeWithMin: -5. max: 5.];
	xRange = [simpleRange copy];
	yRange = [simpleRange copy];
	zRange = [simpleRange copy];
	
	altitude = 33;
	azimuth = 24;
	
	title = @"XN3DPlot";
	
	[self initializePLPlot];
	
	return self;
}

- (XN3DPlot*) initWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth title: (NSString*) aTitle
{
	self = [super init];
	xRange = aBox.xRange;
	yRange = aBox.yRange;
	zRange = aBox.zRange;
	
	altitude = aAltitude;
	azimuth = aAzimuth;
	
	title = [aTitle copy];
	
	[self initializePLPlot];
	
	return self;
}


- (void) initializePLPlot
{
	// Use aquaterm
	plsdev("aqt");
	
	// Use white background
	plscolbg( 255, 255, 255 );
	
	// init
	plinit();
	
	PLFLT i[2], h[2], l[2], s[2];
	
	i[0] = 0.0;		/* left boundary */
	i[1] = 1.0;		/* right boundary */
	
	h[0] = 240; /* blue -> green -> yellow -> */
	h[1] = 0;   /* -> red */
	
	l[0] = 0.6;
	l[1] = 0.6;
	
	s[0] = 0.8;
	s[1] = 0.8;
	
	plscmap1n(256);
	c_plscmap1l(0, 2, i, h, l, s, NULL);
	
	// color magic to make black box
//	plscol0(1, 0, 0, 0);
//	plcol(1);
	
	// a standard viewport
	pladv(0);
	plvpor(0.0, 1.0, 0.0, 0.9);
	
	plwind(-1.0, 1.0, -1.0, 1.2);
	plw3d(1., 1., 1., xRange.min, xRange.max, yRange.min, yRange.max, zRange.min, zRange.max, altitude, azimuth);
	
	plbox3("bnstu", "x axis", 0.0, 0,
		   "bnstu", "y axis", 0.0, 0,
		   "bcdmnstuv", "z axis", 0.0, 4);
	
//	plscol0(1, 1, 0, 0);
}

#pragma mark -
#pragma mark Rendering API
- (void) renderSurface: (XNSurfaceData*)surface
{
	plcol0(2);
	plmesh(surface.xData, surface.yData, surface.zData, surface.xPointsCount, surface.yPointsCount, DRAW_LINEXY);
}

- (void) finalize
{
	plend1();
}

- (void) dealloc
{
	[xRange release];
	[yRange release];
	[zRange release];
	
	[super dealloc];
}

@end
