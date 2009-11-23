//
//  XNLineData.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 23.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNFLoatRange.h"
#import "XNLineData.h"
#import "XNFunction.h"

@implementation XNLineData

@synthesize xData, yData;
@synthesize xRange, yRange;
@synthesize quality, pointsCount;

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
	for(NSInteger i = 0; i < pointsCount; i++){
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
