//
//  XNLinearEquationSystemTest.m
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 17.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNLinearEquationSystemTest.h"
#import "XNVector.h"
#import "XNMatrix.h"
#import "XNLinearEquationSystem.h"


@implementation XNLinearEquationSystemTest

- (void) testSolvesWithSweep
{
	CGFloat dataArray[5][6] = {
		{ -6.0f, +6.0f, 0.0f, 0.0f, 0.0f, 30.0f },
		{ 2.0f, 10.0f, -7.0f, 0.0f, 0.0f, -31.0f },
		{ 0.0f, -8.0f, 18.0f, 9.0f, 0.0f, 108.0f },
		{ 0.0f, 0.0f, 6.0f, -17.0f, -6.0f, -114.0f },
		{ 0.0f, 0.0f, 0.0f, 9.0f, 14.0f, 124.0f }
	};
	
	CGFloat **data = calloc(5, sizeof(CGFloat*));
	for(NSUInteger i = 0; i < 5; i++){
		data[i] = &dataArray[i][0];
	}
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 5 columns: 6 filledWith:	data];
	XNLinearEquationSystem* equationSystem = [[XNLinearEquationSystem alloc] initWithMatrix: matrix];
	
	XNVector* solution = [equationSystem sweep];
	
	//-5 0 3 5 7
	STAssertEquals( [solution valueAtIndex:0], -5.0f, @"Solution not found" );
}

@end
