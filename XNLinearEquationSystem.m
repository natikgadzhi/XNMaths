//
//  XNLinearEquationSystem.m
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNLinearEquationSystem.h"


@implementation XNLinearEquationSystem

#pragma mark -
#pragma mark Initialization methods
- (XNLinearEquationSystem *) initWithMatrix: (XNMatrix *)newEquationMatrix
{
	self = [super init];
	
	equationMatrix = newEquationMatrix;
	
	leftSideMatrix = [newEquationMatrix copy];
	[leftSideMatrix removeColumnAtIndex: (leftSideMatrix.columnsCount - 1)];
	
	rightSideVector = [newEquationMatrix columnVectorAtIndex:(newEquationMatrix.columnsCount - 1)];
	
	return self;
}

- (XNVector *) sweep
{	
	if( ![leftSideMatrix isSquare] ){
		[NSException raise:@"Not a square matrix error." format:@"The left-side equation matrix should be square to use sweep."];
	}
	
	NSUInteger n = [leftSideMatrix rowsCount];
	
	XNVector *p = [[XNVector alloc] initWithCapacity: n];
	XNVector *q = [[XNVector alloc] initWithCapacity: n];
	XNVector *solution = [[XNVector alloc] initWithCapacity: n];
	
	[p setValue: [leftSideMatrix valueAtRow:0 column:1] / (-[leftSideMatrix valueAtRow:0 column:0]) atIndex: 1];
	[q setValue: [rightSideVector valueAtIndex:0] / [leftSideMatrix valueAtRow:0 column:0] atIndex:1];
	
	for(NSUInteger i = 2; i < n; i++){
		[p setValue:[leftSideMatrix valueAtRow:i-1 column:i] / 
		 ( -[leftSideMatrix valueAtRow:i-1 column:i-1] - [leftSideMatrix valueAtRow:i-1 column:i-2] * [p valueAtIndex:i-1]) 
			atIndex:i ];
		
		[q setValue:( [leftSideMatrix valueAtRow:i-1 column:i-2] * [q valueAtIndex:i-1] - [rightSideVector valueAtIndex:i-1] ) /
					 ( -[leftSideMatrix valueAtRow:i-1 column:i-1] - [leftSideMatrix valueAtRow:i-1 column:i-2]*[p valueAtIndex:i-1] )
			atIndex:i ];
	}
	
	[solution setValue:[q valueAtIndex:n-1] atIndex:n-1];
	
	for( NSInteger i = n-2; i >= 0; i-- ){
		[solution setValue: ([p valueAtIndex:i+1]*[solution valueAtIndex:i+1] + [q valueAtIndex:i+1]) atIndex: i];
	}
	
//	for( NSUInteger i = 0; i < solution.capacity; i++ ){
//		[solution setValue: floorf([solution valueAtIndex: i]) atIndex: i];
//	}
	
	return solution;
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	[equationMatrix dealloc];
	[super dealloc];
}

@end
