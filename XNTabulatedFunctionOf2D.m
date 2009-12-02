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

#pragma mark -
#pragma mark Instance init methods
- (XNTabulatedFunctionOf2D *) initWithSurface: (XNSurfaceData *) newSurface
{
	self = [super init];
	
	surface = [newSurface retain];
	
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


#pragma mark -
#pragma mark Runtime service methods 

- (void) dealloc
{
	[surface release];
	[super dealloc];
}

@end
