//
//  XNRange.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 24.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNFloatRange.h"

@implementation XNFloatRange

@synthesize min, max;

#pragma mark -
#pragma mark Class initializers
+ (XNFloatRange*) rangeWithMin:(CGFloat)aMin max:(CGFloat)aMax
{
	return [[XNFloatRange alloc] initWithMin:aMin max:aMax];
}

+ (XNFloatRange*) rangeWithRange:(NSRange)range
{
	return [[XNFloatRange alloc] initWithRange:range];
}

#pragma mark -
#pragma mark Instance initializers
- (XNFloatRange*) initWithMin:(CGFloat)aMin max:(CGFloat)aMax
{
	self = [super init];
	min = aMin;
	max = aMax;
	
	return self;
}

- (XNFloatRange*) initWithRange:(NSRange)range
{
	self = [super init];
	min = (CGFloat)(range.location);
	max = (CGFloat)(range.length);
	
	return self;
}

#pragma mark -
#pragma mark Instance logic
- (CGFloat) length
{
	return abs(max - min);
}

@end
