//
//  XNSurfaceData.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

//
// Class header 
#import "XNSurfaceData.h"

#import "XNFloatRange.h"
#import "XNFunctionOf2D.h"
#import <Accelerate/Accelerate.h>

#pragma mark -
#pragma mark XNSurfaceData class private category

@interface XNSurfaceData (Private)

- (void) updateRanges;
- (void) validateAccessToI: (NSUInteger) i J: (NSUInteger) j;

@end


#pragma mark -
#pragma mark XNSurfaceData class implementation

@implementation XNSurfaceData

@synthesize xData, yData;
@synthesize zData;
@synthesize xRange, yRange, zRange;
@synthesize xPointsCount, yPointsCount;
@synthesize isDirty;

#pragma mark -
#pragma mark Class init methods

//
// Build a surface with functiomn in rect with quality 

+ (XNSurfaceData *) surfaceWithFunction: (XNFunctionOf2D*) aFunction 
								  xRange: (XNFloatRange*) aXRange 
								  yRange: (XNFloatRange*) aYRange 
							 withQuality: (NSUInteger) lineQuality
{
	return [[[XNSurfaceData alloc] initWithFunction:aFunction xRange:aXRange yRange:aYRange withQuality:lineQuality] autorelease];
}

//
// Create an empty surface with N points

+ (XNSurfaceData *) surfaceWithCapacityX: (NSInteger) newXCapacity Y: (NSInteger) newYCapacity
{
	return [[[XNSurfaceData alloc] initWithCapacityX: newXCapacity Y: newYCapacity] autorelease];
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
	
	xRange = [aXRange retain];
	yRange = [aYRange retain];
	
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

//
// Inits an empty surface with N points

- (XNSurfaceData *) initWithCapacityX: (NSInteger) newXCapacity Y: (NSInteger) newYCapacity
{
	self = [super init];
	
	//
	// Set zero counts
	xPointsCount = newXCapacity;
	yPointsCount = newYCapacity;
	
	//
	// Allocate memory
	xData = calloc(xPointsCount, sizeof(CGFloat));
	yData = calloc(yPointsCount, sizeof(CGFloat));
	plAlloc2dGrid(&zData, xPointsCount, yPointsCount);
	
	//
	// Zero memory
	for( NSUInteger i = 0; i < xPointsCount; i++ ){
		xData[i] = 0.;
	}
	
	for( NSUInteger i = 0; i < yPointsCount; i++ ){
		yData[i] = 0.;
	}
	
	for( NSUInteger i = 0; i < xPointsCount; i++ ){
		for(NSUInteger j = 0; j < yPointsCount; j++ ){
			zData[i][j] = 0.;
		}
	}
	
	[self cleanupRanges];
	return self;
}

#pragma mark -
#pragma mark Instance logic 

- (void) set3DPoint: (XN3DPoint) point atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty
{
	[self validateAccessToI:i J:j];
	
	//
	// Set the point
	xData[i] = point.x;
	yData[j] = point.y;
	zData[i][j] = point.z;
	
	if( !dirty){
		[self cleanupRanges];
	} else {
		isDirty = YES;
	}
	
}

- (void) setArguments2DPoint: (XN2DPoint) point atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty
{
	[self validateAccessToI:i J:j];
	
	//
	// Set the point
	xData[i] = point.x;
	yData[j] = point.y;
	
	if( !dirty){
		[self cleanupRanges];
	} else {
		isDirty = YES;
	}
}

- (void) setValue: (CGFloat) value atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty
{
	[self validateAccessToI:i J:j];
	
	zData[i][j] = value;
	
	if( !dirty){
		[self cleanupRanges];
	} else {
		isDirty = YES;
	}
}

- (CGFloat) valueAtI: (NSUInteger) i J: (NSUInteger) j
{
	[self validateAccessToI:i J:j];
	return zData[i][j];
}

- (XN3DPoint) pointAtI: (NSUInteger) i J: (NSUInteger) j
{
	[self validateAccessToI:i J:j];
	return XNMake3DPoint(xData[i], yData[j], zData[i][j]);
}

#pragma mark -
#pragma mark Private category methods 
- (void) cleanupRanges
{
	// 
	// Release old ranges 
	[xRange release];
	[yRange release];
	[zRange release];
	
	// 
	// Create new ranges
	self->xRange = [[XNFloatRange rangeWithCArray: xData withCapacity: xPointsCount] retain];
	self->yRange = [[XNFloatRange rangeWithCArray: yData withCapacity: yPointsCount] retain];
	
	//
	// Update Z range
	CGFloat zMin, zMax;
	plMinMax2dGrid(zData, xPointsCount, yPointsCount, &zMax, &zMin);
	zRange = [[XNFloatRange rangeWithMin: zMin max: zMax] retain];
	
	isDirty = NO;
}

- (void) validateAccessToI: (NSUInteger) i J: (NSUInteger) j
{
	if( i >= xPointsCount){
		[NSException raise: @"Accessing surface point out of the grid." 
					format: @"Trying to access %d point in X scale, but X scale contains only %d positions", i, xPointsCount];
	}
	
	if( j >= yPointsCount){
		[NSException raise: @"Accessing surface point out of the grid." 
					format: @"Trying to access %d point in Y scale, but Y scale contains only %d positions", j, yPointsCount];		
	}
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
