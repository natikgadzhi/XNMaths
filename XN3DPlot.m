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
#import "XNPlotManager.h"
#import "plplot.h"

#pragma mark -
#pragma mark XN3DPlot class implementation

@implementation XN3DPlot

#pragma mark -
#pragma mark Class init methods
+ (XN3DPlot*) plotWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth label: (NSString*) aTitle
{
	return [[XN3DPlot alloc] initWithBox: aBox altitude: aAltitude azimuth: aAzimuth label: aTitle];
}

- (XN3DPlot*) initWithBox: (XNBox*) aBox altitude: (NSInteger) aAltitude azimuth: (NSInteger) aAzimuth label: (NSString*) aTitle
{
	self = [super init];
	
	isReadyToRender = NO;
	
	xRange = aBox.xRange;
	yRange = aBox.yRange;
	zRange = aBox.zRange;
	
	altitude = aAltitude;
	azimuth = aAzimuth;
	
	label = [aTitle copy];
	
	// connect to manager and start it.
	if([[XNPlotManager sharedManager] addPlot]){
		isReadyToRender = YES;
	} else {
		[NSException raise: @"XNPlotManager error." 
					format: @"XNPlotManager refused to register the plot. It servs %d plots already.", [XNPlotManager sharedManager].connectedPlots];
	};

	// a standard viewport
	pladv(0);
	plvpor(0.0, 1.0, 0.0, 0.9);
	
	plwind(-1.0, 1.0, -1.0, 1.2);
	
	plw3d(1., 1., 1., xRange.min, xRange.max, yRange.min, yRange.max, zRange.min, zRange.max, altitude, azimuth);
	
	plbox3("bnstu", "x axis", 0.0, 0,
		   "bnstu", "y axis", 0.0, 0,
		   "bcdmnstuv", "z axis", 0.0, 4);
	
	plmtex("t", 1.0, 0.5, 0.5, [label UTF8String]);
	
	return self;
}

#pragma mark -
#pragma mark Rendering API
- (void) renderSurface: (XNSurfaceData*)surface color: (NSColor *)color;
{
	plscol0( 15, [color redComponent] * 255, [color greenComponent] * 255, [color blueComponent] * 255);
	plcol0(15);
	plmesh(surface.xData, surface.yData, surface.zData, surface.xPointsCount, surface.yPointsCount, DRAW_LINEXY);
	
	plcol0(1);
}

- (void) dealloc
{
	[xRange release];
	[yRange release];
	[zRange release];
	
	[super dealloc];
}

@end
