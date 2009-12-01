//
//  XNLinearEquationSystem.m
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNLinearEquationSystem.h"
#import <Accelerate/Accelerate.h>


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

//
// sweep
// solves the equation system using lapack's sgtsv routine.
//
- (XNVector *) sweep
{	
	if( ![leftSideMatrix isSquare] ){
		[NSException raise:@"Not a square matrix error." format:@"The left-side equation matrix should be square to use sweep."];
	}
	
	//
	// params preparation
	
	// n
	NSUInteger n = [leftSideMatrix rowsCount];
	
	// nrhs (b columns) 
	NSUInteger nrhs = 1;
	
	// matrix representation with diagonals. 
	CGFloat *dl, *d, *du;
	
	CGFloat *b;
	
	NSUInteger ldb = n;
	
	NSInteger info;
	
	// 
	// Init float arrays 
	
	b = calloc(n, sizeof(CGFloat));
	d = calloc(n, sizeof(CGFloat));
	
	du = calloc(n-1, sizeof(CGFloat));
	dl = calloc(n-1, sizeof(CGFloat));
	
	for( NSUInteger i = 0; i < n; i++ ){
		b[i] = [rightSideVector valueAtIndex:i];
		d[i] = [leftSideMatrix valueAtRow:i column:i];
	}
	
	for( NSUInteger i = 0; i < (n-1); i++){
		dl[i] = [leftSideMatrix valueAtRow:i+1 column:i];
		du[i] = [leftSideMatrix valueAtRow:i column:i+1];
	}
	
	//
	// call the routine
	sgtsv_(&n, &nrhs, dl, d, du, b, &ldb, &info);
	
	XNVector *solution = [[XNVector alloc] initWithCapacity: n filledWith: b];
	
//	XNVector *p = [[XNVector alloc] initWithCapacity: n];
//	XNVector *q = [[XNVector alloc] initWithCapacity: n];
	
//	
//	[p setValue: [leftSideMatrix valueAtRow:0 column:1] / (-[leftSideMatrix valueAtRow:0 column:0]) atIndex: 1];
//	[q setValue: [rightSideVector valueAtIndex:0] / [leftSideMatrix valueAtRow:0 column:0] atIndex:1];
//	
//	for(NSUInteger i = 2; i < n; i++){
//		[p setValue:[leftSideMatrix valueAtRow:i-1 column:i] / 
//		 ( -[leftSideMatrix valueAtRow:i-1 column:i-1] - [leftSideMatrix valueAtRow:i-1 column:i-2] * [p valueAtIndex:i-1]) 
//			atIndex:i ];
//		
//		[q setValue:( [leftSideMatrix valueAtRow:i-1 column:i-2] * [q valueAtIndex:i-1] - [rightSideVector valueAtIndex:i-1] ) /
//					 ( -[leftSideMatrix valueAtRow:i-1 column:i-1] - [leftSideMatrix valueAtRow:i-1 column:i-2]*[p valueAtIndex:i-1] )
//			atIndex:i ];
//	}
//	
//	[solution setValue:[q valueAtIndex:n-1] atIndex:n-1];
//	
//	for( NSInteger i = n-2; i >= 0; i-- ){
//		[solution setValue: ([p valueAtIndex:i+1]*[solution valueAtIndex:i+1] + [q valueAtIndex:i+1]) atIndex: i];
//	}
	
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
