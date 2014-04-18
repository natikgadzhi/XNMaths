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
	return [[[XNFloatRange alloc] initWithMin:aMin max:aMax] autorelease];
}

+ (XNFloatRange*) rangeWithRange:(NSRange)range
{
	return [[[XNFloatRange alloc] initWithRange:range] autorelease];
}

+ (XNFloatRange*) rangeWithCArray:(CGFloat*)array withCapacity:(NSUInteger)capacity
{
	return [[[XNFloatRange alloc] initWithCArray:array withCapacity:capacity] autorelease];
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

- (XNFloatRange*) initWithCArray:(CGFloat*)array withCapacity:(NSUInteger)capacity
{
	self = [super init];
	
	min = array[0];
	max = array[0];
	
	for( NSUInteger i = 0; i < capacity; i++ ){
		if( array[i] < min ){
			min = array[i];
		}
		
		if( array[i] > max){
			max = array[i];
		}
	}
	
	return self;
}

#pragma mark -
#pragma mark Instance logic

#if defined(__LP64__) && __LP64__
- (CGFloat) length
{
	return fabs(max - min);
}

#else
- (CGFloat) length
{
	return fabsf(max - min);
}
#endif

#pragma mark -
#pragma mark Copying
- (XNFloatRange *) copy
{
	return [[XNFloatRange alloc]initWithMin: min max: max];
}

@end
