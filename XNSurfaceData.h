//
//  XNSurfaceData.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

// Use our point structures
#import "XN2DPoint.h"
#import "XN3DPoint.h"

//
// Consider these classes
@class XNFloatRange;
@class XNFunctionOf2D;

#pragma mark -
#pragma mark XNSurfaceData class inteface

@interface XNSurfaceData : NSObject {
	
	// Store line datapoints to render it really fast. 
	CGFloat *xData, *yData, **zData;
	
	// Value ranges
	XNFloatRange  *xRange, *yRange, *zRange;
	
	// quality is an recalculation points count per one real unit. quality is used when surfacing from function.
	// count is how many points are actually crated and should be used in other operations. 
	NSUInteger quality, xPointsCount, yPointsCount;
	
	BOOL isDirty;
}

@property(readonly) CGFloat *xData, *yData;
@property(readonly) CGFloat **zData;
@property(readonly) XNFloatRange *xRange, *yRange, *zRange;
@property(readonly) NSUInteger xPointsCount, yPointsCount;
@property(readonly) BOOL isDirty;

#pragma mark -
#pragma mark Class init methods

//
// Build surface with function in rect

// TODO: Write tests
+ (XNSurfaceData *) surfaceWithFunction: (XNFunctionOf2D*) aFunction 
								  xRange: (XNFloatRange*) aXRange 
								  yRange: (XNFloatRange*) aYRange 
							 withQuality: (NSUInteger) lineQuality;

+ (XNSurfaceData *) surfaceWithCapacityX: (NSInteger) newXCapacity Y: (NSInteger) newYCapacity;

#pragma mark -
#pragma mark Instance init methods

// TODO: write tests 

- (XNSurfaceData *) initWithFunction: (XNFunctionOf2D*) aFunction 
							  xRange: (XNFloatRange*) aXRange 
							  yRange: (XNFloatRange*) aYRange 
						 withQuality: (NSUInteger) lineQuality;


- (XNSurfaceData *) initWithCapacityX: (NSInteger) newXCapacity Y: (NSInteger) newYCapacity;

#pragma mark -
#pragma mark Instance logic methods

//
// Setters
- (void) set3DPoint: (XN3DPoint) point atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty;
- (void) setValue: (CGFloat) value atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty;
- (void) setArguments2DPoint: (XN2DPoint) point atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty;

//
// Getters
- (CGFloat) valueAtI: (NSUInteger) i J: (NSUInteger) j;
- (XN3DPoint) pointAtI: (NSUInteger) i J: (NSUInteger) j;

//
// Cleanup after set method calls with dirty = YES
- (void) cleanupRanges;


@end
