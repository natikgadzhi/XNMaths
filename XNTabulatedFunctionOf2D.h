//
//  XNTabulatedFunctionOf2D.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import "XN3DPoint.h"

@class XNSurfaceData;
@class XNFloatRange;

#pragma mark -
#pragma mark XNTabulatedFunctionOf2D interface

@interface XNTabulatedFunctionOf2D : NSObject {
	XNSurfaceData *surface;
	
	//
	// arguments are stored as a grids. 
	
	XNFloatRange *firstArgumentRange, *secondArgumentRange;
	
	CGFloat firstArgumentIncrement, secondArgumentIncrement;
}

@property(retain) XNSurfaceData *surface;

#pragma mark -
#pragma mark Class init methods

+ (XNTabulatedFunctionOf2D *) functionWithSurface: (XNSurfaceData*) aSurface;
+ (XNTabulatedFunctionOf2D *) functionWithCapacityI: (NSUInteger) iCount J: (NSUInteger) jCount;
+ (XNTabulatedFunctionOf2D *) functionWithFirstArgumentCapacity: (NSUInteger) iCount 
														  range: (XNFloatRange *) newFirstArgumentRange 
										 secondArgumentCapacity: (NSUInteger) jCount 
														  range: (XNFloatRange *) newSecondArgumentRange;

#pragma mark -
#pragma mark Instance init methods
- (XNTabulatedFunctionOf2D *) initWithSurface: (XNSurfaceData*) aSurface;
- (XNTabulatedFunctionOf2D *) initWithCapacityI: (NSUInteger) iCount J: (NSUInteger) jCount;

- (XNTabulatedFunctionOf2D *) initWithFirstArgumentCapacity: (NSUInteger) iCount 
													  range: (XNFloatRange *) newFirstArgumentRange 
									 secondArgumentCapacity: (NSUInteger) jCount 
													  range: (XNFloatRange *) newSecondArgumentRange;

#pragma mark -
#pragma mark Instance logic
- (CGFloat) valueAtI: (NSUInteger) i J: (NSUInteger) j;
- (XN3DPoint) pointAtI: (NSUInteger) i J: (NSUInteger) j;

- (void) setValue: (CGFloat) value atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty;
- (void) set3DPoint: (XN3DPoint) point atI: (NSUInteger) i J: (NSUInteger) j dirty: (BOOL) dirty;


//
// Argument grids 

- (void) setFirstArgumentRange: (XNFloatRange *) range;
- (void) setFirstArgumentFrom: (CGFloat) from to: (CGFloat) to; 

- (void) setFirstArgumentRange: (XNFloatRange *) range;
- (void) setFirstArgumentFrom: (CGFloat) from to: (CGFloat) to; 

@end
