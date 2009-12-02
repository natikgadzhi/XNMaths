//
//  SurfaceDataTest.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "SurfaceDataTest.h"

@implementation SurfaceDataTest

- (void) testCreatesWithCapacity
{
	XNSurfaceData *surface = [XNSurfaceData surfaceWithCapacityX:100 Y:100];
	
	//
	// Dimensions test. 
	STAssertEquals( surface.xPointsCount, 100u, @"Surface dimensions are wrong!");
	STAssertEquals( surface.yPointsCount, 100u, @"Surface dimensions are wrong!");
	
	//
	// Default values test
	STAssertEquals( surface.xData[37], 0.0f, @"Xgrid doesn't have default value of 0, the value was %1.2f", surface.xData[37]);
	STAssertEquals( surface.yData[37], 0.0f, @"Ygrid doesn't have default value of 0, the value was %1.2f", surface.yData[37]);
	STAssertEquals( surface.zData[37][37], 0.0f, @"Zgrid doesn't have default value of 0, the value was %1.2f", surface.zData[37][37]);
	
	//
	// Test value ranges
	STAssertEquals( surface.xRange.min, 0.0f, @"Wrong X range in the empty surface");
	STAssertEquals( surface.xRange.max, 0.0f, @"Wrong X range in the empty surface");
	STAssertEquals( surface.yRange.min, 0.0f, @"Wrong Y range in the empty surface");
	STAssertEquals( surface.yRange.max, 0.0f, @"Wrong Y range in the empty surface");
	STAssertEquals( surface.zRange.min, 0.0f, @"Wrong Z range in the empty surface");
	STAssertEquals( surface.zRange.max, 0.0f, @"Wrong Z range in the empty surface");
}

- (void) testSetsPoint
{
	XNSurfaceData *surface = [XNSurfaceData surfaceWithCapacityX:100 Y:100];
	
	[surface set3DPoint:XNMake3DPoint(1., 2., 3.) atI:0 J:0];
	
	STAssertEquals( surface.xRange.min, 0.0f, @"Wrong X range in the empty surface");
	STAssertEquals( surface.xRange.max, 1.0f, @"Wrong X range in the empty surface");
	STAssertEquals( surface.yRange.min, 0.0f, @"Wrong Y range in the empty surface");
	STAssertEquals( surface.yRange.max, 2.0f, @"Wrong Y range in the empty surface");
	STAssertEquals( surface.zRange.min, 0.0f, @"Wrong Z range in the empty surface");
	STAssertEquals( surface.zRange.max, 3.0f, @"Wrong Z range in the empty surface");
}

- (void) testRetrievesValuesAndPoints
{
	XNSurfaceData *surface = [XNSurfaceData surfaceWithCapacityX:100 Y:100];
	
	[surface set3DPoint:XNMake3DPoint(1., 2., 3.) atI:0 J:0];
	
	STAssertEquals( [surface valueAtI:0 J:0], 3.0f, @"Surface didn't return value correctly");
	STAssertEquals( [surface pointAtI:0 J:0], XNMake3DPoint(1., 2., 3.), @"Surface didn't return point correctly");
}

@end
