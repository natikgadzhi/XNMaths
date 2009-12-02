//
//  XN3DPoint.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XN3DPoint.h"

XN3DPoint XNMake3DPoint(CGFloat aX, CGFloat aY, CGFloat aZ)
{
	XN3DPoint point;
	
	point.x = aX;
	point.y = aY;
	point.z = aZ;
	
	return point;
}