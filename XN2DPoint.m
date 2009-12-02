//
//  XN2DPoint.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XN2DPoint.h"

XN2DPoint XNMake2DPoint(CGFloat aX, CGFloat aY)
{
	XN2DPoint point;
	point.x = aX;
	point.y = aY;
	return point;
}
