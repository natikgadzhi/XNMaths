//
//  XNLineData.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import "XNFLoatRange.h"
#import "XNLineData.h"
#import "XNFunction.h"

#import <CoreGraphics/CoreGraphics.h>

#pragma mark -
#pragma mark LineData class implementation 

@implementation XNLineData

@synthesize xData, yData;
@synthesize xRange, yRange;
@synthesize quality, pointsCount;

#pragma mark - 
#pragma mark Class init methods 

+ (XNLineData *) lineDataWithFunction: (XNFunction*)aFunction inRange: (XNFloatRange*)range withQuality: (NSUInteger) lineQuality
{
	return [[[XNLineData alloc] initWithFunction:aFunction inRange:range withQuality:lineQuality ]autorelease];
}

+ (XNLineData *) lineDataWithXData: (CGFloat*)x yData:(CGFloat*)y pointsCount: (NSUInteger) count;
{
	return [[[XNLineData alloc] initWithXData: x yData: y pointsCount: count ]autorelease];
}

#pragma mark -
#pragma mark Instance init methods

- (XNLineData *) initWithXData: (CGFloat*)x yData:(CGFloat*)y pointsCount: (NSUInteger) count
{
	self = [super init];
	
	xData = x;
	yData = y;
	pointsCount = count;
	
	self->xRange = [[XNFloatRange rangeWithCArray:xData withCapacity:pointsCount ]retain];
	self->yRange = [[XNFloatRange rangeWithCArray:yData withCapacity:pointsCount ]retain];
	
	quality = (NSUInteger)(xRange.length / pointsCount);
	
	return self;
}

- (XNLineData *)initWithFunction: (XNFunction*)aFunction inRange: (XNFloatRange*)newRange withQuality: (NSUInteger) lineQuality
{
	self = [super init];
	
	// set new line quality;
	quality = lineQuality;
	
	xRange = newRange;
	
	// calculate points count
	CGFloat strechLength = [xRange length];
	NSUInteger unitsCount = (NSUInteger) strechLength;
	pointsCount = quality * unitsCount;
	
	// init data containers
	xData = calloc(pointsCount, sizeof(CGFloat));
	yData = calloc(pointsCount, sizeof(CGFloat));
	
	// set up default y range.
	yRange = [XNFloatRange rangeWithMin:[aFunction valueWithFloat: xRange.min] max:[aFunction valueWithFloat: xRange.min]];
	
	// calculate data and set min/max values
	for(NSUInteger i = 0; i != pointsCount; ++i){
		xData[i] = xRange.min + (strechLength / pointsCount)*i;
		yData[i] = [aFunction valueWithFloat: xData[i]];
		
		if( yData[i] < yRange.min ){
			yRange.min = yData[i];
		}
		
		if( yData[i] > yRange.max ){
			yRange.max = yData[i];
		}
	}
	
	return self;
}

- (void) dealloc
{
	free(xData);
	free(yData);
	
	[xRange release];
	[yRange release];
	
	[super dealloc];
}

@end
