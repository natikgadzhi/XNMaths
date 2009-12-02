//
//  XNSurfaceData.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XN2DPoint.h"
#import "XN3DPoint.h"
#import "XNSurfaceData.h"
#import "XNFloatRange.h"
#import "XNFunctionOf2D.h"
#import "plplot.h"


@implementation XNSurfaceData

@synthesize xData, yData;
@synthesize zData;
@synthesize xRange, yRange, zRange;
@synthesize xPointsCount, yPointsCount;

#pragma mark -
#pragma mark Class init methods

//
// Build a surface with functiomn in rect with quality 

+ (XNSurfaceData *) surfaceWithFunction: (XNFunctionOf2D*) aFunction 
								  xRange: (XNFloatRange*) aXRange 
								  yRange: (XNFloatRange*) aYRange 
							 withQuality: (NSUInteger) lineQuality
{
	return [[XNSurfaceData alloc] initWithFunction:aFunction xRange:aXRange yRange:aYRange withQuality:lineQuality];
}


#pragma mark -
#pragma mark Instance init methods 

//
// Build a surface with function in rect with quality.

- (XNSurfaceData *) initWithFunction: (XNFunctionOf2D*) aFunction 
							  xRange: (XNFloatRange*) aXRange 
							  yRange: (XNFloatRange*) aYRange 
						 withQuality: (NSUInteger) lineQuality
{
	self = [super init];
	
	// set new line quality;
	quality = lineQuality;
	
	xRange = aXRange;
	yRange = aYRange;
	
	xPointsCount = quality * (NSInteger)[xRange length];
	yPointsCount = quality * (NSInteger)[yRange length];
	
	// init data containers
	xData = calloc(xPointsCount, sizeof(CGFloat));
	yData = calloc(yPointsCount, sizeof(CGFloat));
	plAlloc2dGrid(&zData, xPointsCount, yPointsCount);

	
	// set up default y range.
	zRange = [XNFloatRange rangeWithMin:[aFunction valueWithX:[xRange min] y:[yRange min]] max:[aFunction valueWithX:[xRange max] y:[yRange max]]];
	
	// calculate data and set min/max values
	for(NSInteger i = 0; i < xPointsCount; i++){
		xData[i] = xRange.min + ([xRange length] / xPointsCount)*i;
	}

	for(NSInteger i = 0; i < yPointsCount; i++){
		yData[i] = yRange.min + ([yRange length] / yPointsCount)*i;
	}
	
	
	for(NSInteger i = 0; i < xPointsCount; i++){
		for(NSUInteger j = 0; j < yPointsCount; j++){
			zData[i][j] = [aFunction valueWithX: xData[i] y: yData[j]];

			if( zData[i][j] < zRange.min ){
				zRange.min = zData[i][j];
			}
			
			if( zData[i][j] > zRange.max ){
				zRange.max = zData[i][j];
			}
		}
	}
	
	return self;
}

#pragma mark -
#pragma mark Instance logic 

// 
// Adds a value to the surface by whole 3 dimensions float values

- (void) addValue: (CGFloat) value forX: (CGFloat) xValue Y: (CGFloat) yValue
{
	
}


// 
// Adds a value to the surface by 2Dpoint 

- (void) addValue: (CGFloat) value for2DPoint: (XN2DPoint) point
{
	
}

// 
// Adds a value to the surface 
- (void) add3DPoint: (XN3DPoint) point
{
	
}



#pragma mark -
#pragma mark Private runtime service methods 

//
// Deallocate instance hook

- (void) dealloc
{
	plFree2dGrid(zData, xPointsCount, yPointsCount);
	free(xData);
	free(yData);
	
	[xRange release];
	[yRange release];
	[zRange release];
	
	[super dealloc];
}

@end
