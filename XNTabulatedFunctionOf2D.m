//
//  XNTabulatedFunctionOf2D.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

//
// Class header
#import "XNTabulatedFunctionOf2D.h"

// 
// XNMaths
#import "XNSurfaceData.h"
#import "XNFloatRange.h"

#pragma mark -
#pragma mark XNTabulatedFunctionOf2D private category
@interface XNTabulatedFunctionOf2D (Private)

- (void) generateFirstArgumentValues;
- (void) generateSecondArgumentValues;
- (void) generateArgumentsGrid;

@end


#pragma mark -
#pragma mark XNTabulatedFunctionOf2D class implementation

@implementation XNTabulatedFunctionOf2D

@synthesize surface;

#pragma mark -
#pragma mark Class init methods

+ (XNTabulatedFunctionOf2D *) functionWithSurface: (XNSurfaceData *) newSurface
{
	return [[XNTabulatedFunctionOf2D alloc] initWithSurface: newSurface];
}

+ (XNTabulatedFunctionOf2D *) functionWithCapacityI: (NSUInteger) iCount J: (NSUInteger) jCount
{
	return [[XNTabulatedFunctionOf2D alloc] initWithCapacityI:iCount J:jCount];
}



+ (XNTabulatedFunctionOf2D *) functionWithFirstArgumentCapacity: (NSUInteger) iCount 
													  range: (XNFloatRange *) newFirstArgumentRange 
									 secondArgumentCapacity: (NSUInteger) jCount 
													  range: (XNFloatRange *) newSecondArgumentRange
{
	return [[XNTabulatedFunctionOf2D alloc] initWithFirstArgumentCapacity: iCount 
																	range: newFirstArgumentRange 
												   secondArgumentCapacity: jCount 
																	range: newSecondArgumentRange];
}



#pragma mark -
#pragma mark Instance init methods

- (XNTabulatedFunctionOf2D *) initWithSurface: (XNSurfaceData *) newSurface
{
	self = [super init];
	
	surface = [newSurface retain];	
	firstArgumentRange = [XNFloatRange rangeWithMin:0. max:0.];
	secondArgumentRange = [XNFloatRange rangeWithMin:0. max:0.];
	
	return self;
}

- (XNTabulatedFunctionOf2D *) initWithCapacityI: (NSUInteger) iCount J: (NSUInteger) jCount
{
	self = [super init];
	
	surface = [XNSurfaceData surfaceWithCapacityX:iCount Y:jCount];
	firstArgumentRange = [XNFloatRange rangeWithMin:0. max:0.];
	secondArgumentRange = [XNFloatRange rangeWithMin:0. max:0.];
	
	return self;
}

- (XNTabulatedFunctionOf2D *) initWithFirstArgumentCapacity: (NSUInteger) iCount 
													  range: (XNFloatRange *) newFirstArgumentRange 
									 secondArgumentCapacity: (NSUInteger) jCount 
													  range: (XNFloatRange *) newSecondArgumentRange
{
	self = [super init];
	
	//
	// Init empty surface with capacity
	surface = [XNSurfaceData surfaceWithCapacityX:iCount Y:jCount];
	
	//
	// Rerain ranges
	firstArgumentRange = [newFirstArgumentRange retain];
	secondArgumentRange = [newSecondArgumentRange retain];
	
	//
	// Calculate increments
	firstArgumentIncrement = firstArgumentRange.length / (iCount - 1);
	secondArgumentIncrement = secondArgumentRange.length / (jCount -1);
	
	//
	// Calculate values
	[self generateArgumentsGrid];
	
	return self;
}


#pragma mark -
#pragma mark Instnace Logica
- (CGFloat) valueAtI: (NSUInteger) i J: (NSUInteger) j
{
	return [surface valueAtI:i J:j];
}

- (XN3DPoint) pointAtI: (NSUInteger) i J: (NSUInteger) j
{
	return [surface pointAtI:i J:j];
}


- (void) setValue: (CGFloat) value atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty
{
	[surface setValue:value atI:i J:j dirty:dirty];
}

- (void) set3DPoint: (XN3DPoint) point atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty
{
	[surface set3DPoint: point atI:i J:j dirty:dirty];
}


//
// Argument grids 

- (void) setFirstArgumentRange: (XNFloatRange *) range
{
	[firstArgumentRange release];
	firstArgumentRange = [range retain];
	
	firstArgumentIncrement = firstArgumentRange.length / surface.xPointsCount;
}


- (void) setFirstArgumentFrom: (CGFloat) from to: (CGFloat) to
{
	[self setFirstArgumentRange: [XNFloatRange rangeWithMin:from max:to]];
}

- (void) setSecondArgumentRange: (XNFloatRange *) range
{
	[secondArgumentRange release];
	secondArgumentRange= [range retain];
	
	secondArgumentIncrement = secondArgumentRange.length / surface.yPointsCount;
}

- (void) setSecondArgumentFrom: (CGFloat) from to: (CGFloat) to
{
	[self setSecondArgumentRange: [XNFloatRange rangeWithMin:from max:to]];
}

// 
// Fill both argument grids based on arg ranges. 

- (void) generateFirstArgumentValues
{
	for( NSUInteger i = 0; i < surface.xPointsCount; i++){
		surface.xData[i] = firstArgumentRange.min + firstArgumentIncrement * i;
	}
	
	[surface cleanupRanges];
}

- (void) generateSecondArgumentValues
{
	for( NSUInteger i = 0; i < surface.yPointsCount; i++){
		surface.yData[i] = secondArgumentRange.min + secondArgumentIncrement * i;
	}
	
	[surface cleanupRanges];
}

- (void) generateArgumentsGrid
{
	[self generateFirstArgumentValues];
	[self generateSecondArgumentValues];
}


#pragma mark -
#pragma mark Runtime service methods 

- (void) dealloc
{
	[firstArgumentRange release];
	[secondArgumentRange release];
	[surface release];
	[super dealloc];
}

@end
