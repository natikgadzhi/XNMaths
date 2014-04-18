//
//  XN3DPoint.h
//  XNMaths
// 
//  XN3DPoint struct
//  Defines point in a three dimentional space
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

typedef struct _XN3DPoint {
	CGFloat x,y,z;
} XN3DPoint;

XN3DPoint XNMake3DPoint(CGFloat aX, CGFloat aY, CGFloat aZ);