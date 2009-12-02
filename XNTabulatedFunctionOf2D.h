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

@class XNSurfaceData;

#pragma mark -
#pragma mark XNTabulatedFunctionOf2D interface

@interface XNTabulatedFunctionOf2D : NSObject {
	XNSurfaceData *surface;
}

+ (XNTabulatedFunctionOf2D*) functionWithSurface: (XNSurfaceData*)aSurface;

- (XNTabulatedFunctionOf2D*) initWithSurface: (XNSurfaceData*)aSurface;

@end
