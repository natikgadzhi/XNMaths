//
//  XNSurfaceData.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

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
+ (XNSurfaceData *) lineDataWithFunction: (XNFunctionOf2D*)aFunction 
								  xRange: (XNFloatRange*)aXRange 
								  yRange: (XNFloatRange*) aYRange 
							 withQuality: (NSUInteger) lineQuality;

- (XNSurfaceData *) initWithFunction: (XNFunctionOf2D*)aFunction 
							  xRange: (XNFloatRange*)aXRange 
							  yRange: (XNFloatRange*) aYRange 
						 withQuality: (NSUInteger) lineQuality;
@end
