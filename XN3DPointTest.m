//
//  XN3DPointTest.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XN3DPointTest.h"
#import "XN3DPoint.h"


@implementation XN3DPointTest

- (void) testWorks
{
	XN3DPoint point;
	
	point.x = 10;
	point.y = 11;
	point.z = 13;
	
	STAssertEquals( point.x, 10.0f, @"3DPoint coordinate is inaccessible");
	STAssertEquals( point.y, 11.0f, @"3DPoint coordinate is inaccessible");
	STAssertEquals( point.z, 13.0f, @"3DPoint coorbinate is inaccessible");
	
	XN3DPoint createdPoint = XNMake3DPoint(1,2,3);
	
	STAssertEquals( createdPoint.x, 1.0f, @"3DPoint coordinate is inaccessible");
	STAssertEquals( createdPoint.y, 2.0f, @"3DPoint coordinate is inaccessible");
	STAssertEquals( createdPoint.z, 3.0f, @"3DPoint coorbinate is inaccessible");
}

@end
