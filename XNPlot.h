//
//  XNPlot.h
//  XNMaths
//
//  XNPlot class.
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XNFloatRange;
@class XNLineData;
@class XNFunction;

@interface XNPlot : NSObject {
	XNFloatRange *xRange, *yRange;
	NSUInteger quality;
}

- (XNPlot*) init2D;

- (void) renderFunction: (XNFunction*)aFunction inRange: (XNFloatRange*) range withColor: (NSColor*)color;

- (void) finalize;

@end
