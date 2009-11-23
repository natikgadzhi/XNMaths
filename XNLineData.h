//
//  XNLineData.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XNFloatRange;
@class XNFunction;

@interface XNLineData : NSObject {
	
	// Store line datapoints to render it really fast. 
	CGFloat *xData, *yData;
	
	// Value ranges
	XNFloatRange  *xRange, *yRange;
	
	// quality is an recalculation points count per one real number.
	NSUInteger quality, pointsCount;
}

@property(readonly) CGFloat *xData;
@property(readonly) CGFloat *yData;
@property(readonly) XNFloatRange *xRange, *yRange;
@property(readonly) NSUInteger quality, pointsCount;

- (XNLineData *)initWithFunction: (XNFunction *)aFunction inRange: (XNFloatRange*)newRange withQuality: (NSUInteger) lineQuality;

@end
