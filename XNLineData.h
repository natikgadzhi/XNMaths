//
//  XNLineData.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports && classes requirements 

#import <CoreGraphics/CoreGraphics.h>

@class XNFloatRange;
@class XNFunction;

#pragma mark -
#pragma mark XNLIneData class public interface

@interface XNLineData : NSObject {
	
	// Store line datapoints to render it really fast. 
	CGFloat *xData, *yData;
	
	// Value ranges
	XNFloatRange  *xRange, *yRange;
	
	// quality is an recalculation points count per one real number.
	NSUInteger quality, pointsCount;
}

#pragma mark -
#pragma mark XNLineData object public properties declaration

@property(nonatomic, readonly) CGFloat *xData;
@property(nonatomic, readonly) CGFloat *yData;
@property(nonatomic, readonly) XNFloatRange *xRange, *yRange;
@property(nonatomic, readonly) NSUInteger quality, pointsCount;


#pragma mark -
#pragma mark Class init methods
+ (XNLineData *) lineDataWithFunction: (XNFunction*)aFunction inRange: (XNFloatRange*)range withQuality: (NSUInteger) lineQuality;
+ (XNLineData *) lineDataWithXData: (CGFloat*) CF_CONSUMED x  
                             yData: (CGFloat*) CF_CONSUMED y  
                       pointsCount: (NSUInteger) count;

- (XNLineData *) initWithXData: (CGFloat*)x yData:(CGFloat*)y pointsCount: (NSUInteger) count;
- (XNLineData *) initWithFunction: (XNFunction *)aFunction inRange: (XNFloatRange*)newRange withQuality: (NSUInteger) lineQuality;

@end
