//
//  XNSurfaceData.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XN2DPoint.h"
#import "XN3DPoint.h"

@class XNFloatRange;
@class XNFunctionOf2D;

@interface XNSurfaceData : NSObject {
	
	// Store line datapoints to render it really fast. 
	CGFloat *xData, *yData, **zData;
	
	// Value ranges
	XNFloatRange  *xRange, *yRange, *zRange;
	
	// quality is an recalculation points count per one real number.
	NSUInteger quality, xPointsCount, yPointsCount;
}

@property(readonly) CGFloat *xData, *yData;
@property(readonly) CGFloat **zData;
@property(readonly) XNFloatRange *xRange, *yRange, *zRange;
@property(readonly) NSUInteger xPointsCount, yPointsCount;

#pragma mark -
#pragma mark Class init methods

//
// Build surface with function in rect

+ (XNSurfaceData *) surfaceWithFunction: (XNFunctionOf2D*) aFunction 
								  xRange: (XNFloatRange*) aXRange 
								  yRange: (XNFloatRange*) aYRange 
							 withQuality: (NSUInteger) lineQuality;

#pragma mark -
#pragma mark Instance init methods

- (XNSurfaceData *) initWithFunction: (XNFunctionOf2D*) aFunction 
							  xRange: (XNFloatRange*) aXRange 
							  yRange: (XNFloatRange*) aYRange 
						 withQuality: (NSUInteger) lineQuality;

#pragma mark -
#pragma mark Instance logic methods

- (void) addValue: (CGFloat) value forX: (CGFloat) xValue Y: (CGFloat) yValue;
- (void) addValue: (CGFloat) value for2DPoint: (XN2DPoint) point;
- (void) add3DPoint: (XN3DPoint) point;

@end
