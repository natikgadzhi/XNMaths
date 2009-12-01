//
//  XNBox.h
//  XNMaths
//
//  XNBox class interface
//  Geometry boundary class
//  
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import <Cocoa/Cocoa.h>

@class XNFloatRange;


#pragma mark -
#pragma mark XNBox class interface 

@interface XNBox : NSObject {
	XNFloatRange *xRange, *yRange, *zRange;
	
}

@property(copy) XNFloatRange *xRange, *yRange, *zRange;

#pragma mark -
#pragma mark Class init methods
+ (XNBox*) boxWithRangesX: (XNFloatRange*)aXRange Y: (XNFloatRange*)aYRange Z: (XNFloatRange*)aZRange;
+ (XNBox*) boxWithXMin: (CGFloat)xMin XMax: (CGFloat)xMax YMin: (CGFloat)yMin YMax: (CGFloat)yMax ZMin: (CGFloat)zMin ZMax: (CGFloat)zMax;

#pragma mark -
#pragma mark Instance init methods
- (XNBox*) initWithRangesX: (XNFloatRange*)aXRange Y: (XNFloatRange*)aYRange Z: (XNFloatRange*)aZRange;
- (XNBox*) initWithXMin: (CGFloat)xMin XMax: (CGFloat)xMax YMin: (CGFloat)yMin YMax: (CGFloat)yMax ZMin: (CGFloat)zMin ZMax: (CGFloat)zMax;

#pragma mark -
#pragma mark Instance methods
- (CGFloat) length;
- (CGFloat) width;
- (CGFloat) height; 

@end
