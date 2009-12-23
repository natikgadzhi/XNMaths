//
//  XNTabulatedFunctionOf2DTest.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 02.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNTabulatedFunctionOf2DTest.h"


@implementation XNTabulatedFunctionOf2DTest

- (void) testCreatesAndSetsValue
{
	
}

- (void) testFillesArgumentGrids
{
	
	XNTabulatedFunctionOf2D *func = [[XNTabulatedFunctionOf2D functionWithFirstArgumentCapacity: 10
																						 range: [XNFloatRange rangeWithMin: -5. max: 5. ]
																		secondArgumentCapacity: 10 
																						 range: [XNFloatRange rangeWithMin: -5. max: 5. ] ] retain];
	STAssertEquals( [func.surface pointAtI: 0 J:0], XNMake3DPoint(-5.0f, -5.0f, 0.0f), @"Filled in incorrect.");
	STAssertEquals( [func.surface pointAtI: 9 J:9], XNMake3DPoint(5.0f, 5.0f, 0.0f), @"Filled in incorrect.");
	
	[func release];
}



@end
