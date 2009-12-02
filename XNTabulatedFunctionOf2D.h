//
//  XNTabulatedFunctionOf2D.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import <Cocoa/Cocoa.h>
#import "XN3DPoint.h"

@class XNSurfaceData;

#pragma mark -
#pragma mark XNTabulatedFunctionOf2D interface

@interface XNTabulatedFunctionOf2D : NSObject {
	XNSurfaceData *surface;
}

@property(retain) XNSurfaceData *surface;

#pragma mark -
#pragma mark Class init methods

+ (XNTabulatedFunctionOf2D*) functionWithSurface: (XNSurfaceData*)aSurface;


#pragma mark -
#pragma mark Instance init methods
- (XNTabulatedFunctionOf2D*) initWithSurface: (XNSurfaceData*)aSurface;

#pragma mark -
#pragma mark Instance logic
- (CGFloat) valueAtI: (NSUInteger) i J: (NSUInteger) j;
- (XN3DPoint) pointAtI: (NSUInteger) i J: (NSUInteger) j;

@end
