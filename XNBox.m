//
//  XNBox.m
//  XNMaths
//
//  XNBox class implementation
//  XNBox class is a simple geometry boundary. 
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import "XNBox.h"
#import "XNFloatRange.h"

#pragma mark -
#pragma mark XNBox class implementation

@implementation XNBox

@synthesize xRange, yRange, zRange;

#pragma mark -
#pragma mark Class init methods
+ (XNBox*) boxWithRangesX: (XNFloatRange*)aXRange Y: (XNFloatRange*)aYRange Z: (XNFloatRange*)aZRange
{
	return [[XNBox alloc] initWithRangesX:aXRange Y:aYRange Z:aZRange];
}

+ (XNBox*) boxWithXMin: (CGFloat)xMin XMax: (CGFloat)xMax YMin: (CGFloat)yMin YMax: (CGFloat)yMax ZMin: (CGFloat)zMin ZMax: (CGFloat)zMax
{
	return [[XNBox alloc] initWithXMin:xMin XMax:xMax YMin:yMin YMax:yMax ZMin:zMin ZMax:zMax];
}

#pragma mark -
#pragma mark Instance init methods
- (XNBox*) initWithRangesX: (XNFloatRange*)aXRange Y: (XNFloatRange*)aYRange Z: (XNFloatRange*)aZRange
{
	self = [super init];
	
	xRange = [aXRange copy];
	yRange = [aYRange copy];
	zRange = [aZRange copy];
	
	return self;
}

- (XNBox*) initWithXMin: (CGFloat)xMin XMax: (CGFloat)xMax YMin: (CGFloat)yMin YMax: (CGFloat)yMax ZMin: (CGFloat)zMin ZMax: (CGFloat)zMax
{
	self = [super init];
	
	xRange = [XNFloatRange rangeWithMin:xMin max:xMax];
	yRange = [XNFloatRange rangeWithMin:yMin max:yMax];
	zRange = [XNFloatRange rangeWithMin:zMin max:zMax];
	
	return self;
}

#pragma mark -
#pragma mark Instance methods
- (CGFloat) length
{
	return [xRange length];
}
	
	
- (CGFloat) width
{
	return [yRange length];
}

- (CGFloat) height
{
	return [zRange length];
}

- (void) dealloc
{
	[xRange release];
	[yRange release];
	[zRange release];
	[super dealloc];
}

@end
