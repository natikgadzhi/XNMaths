//
//  XNRange.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 24.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XNFloatRange : NSObject
{
	CGFloat min, max;
}

@property CGFloat min, max;

#pragma mark -
#pragma mark Class initializers
+ (XNFloatRange*) rangeWithMin:(CGFloat)aMin max:(CGFloat)aMax; 
+ (XNFloatRange*) rangeWithRange:(NSRange)range;
+ (XNFloatRange*) rangeWithCArray:(CGFloat*)array withCapacity:(NSUInteger)capacity;

#pragma mark -
#pragma mark Instance initializers
- (XNFloatRange*) initWithMin: (CGFloat) aMin max: (CGFloat) aMax;
- (XNFloatRange*) initWithRange:(NSRange)range;
- (XNFloatRange*) initWithCArray:(CGFloat*)array withCapacity:(NSUInteger)capacity;

#pragma mark -
#pragma mark Instance logic
- (CGFloat) length;

#pragma mark -
#pragma mark Copying
- (XNFloatRange *) copy;

@end