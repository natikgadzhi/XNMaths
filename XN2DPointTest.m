//
//  XN2DPointTest.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XN2DPointTest.h"
#import "XN2DPoint.h"


@implementation XN2DPointTest

- (void) testCreatedAndBehavesOK
{
	XN2DPoint point;
	
	point.x = 1.;
	point.y = 1.;
	
	STAssertEquals( point.x, 1.0f, @"Point coordinate is inaccessible");
	STAssertEquals( point.y, 1.0f, @"Point coorbinate is inaccessible");
	
	
	point = XNMake2DPoint(10, 11);

	STAssertEquals( point.x, 10.0f, @"Point coordinate is inaccessible");
	STAssertEquals( point.y, 11.0f, @"Point coorbinate is inaccessible");
}

@end
