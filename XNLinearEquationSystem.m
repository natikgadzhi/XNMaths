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

@synthesize iterationsSpent, iterationsLimit;

#pragma mark -
#pragma mark Initialization methods
- (XNLinearEquationSystem *) initWithMatrix: (XNMatrix *)newEquationMatrix
{
	self = [super init];
	
	self->equationMatrix = [newEquationMatrix retain];
	
	self->leftSideMatrix = [newEquationMatrix copy];
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
    NSUInteger rowsCount = [leftSideMatrix rowsCount];
	__CLPK_integer n = (__CLPK_integer)rowsCount;
	
	// nrhs (b columns) 
	__CLPK_integer nrhs = 1;
	
	// matrix representation with diagonals. 
	CGFloat *dl, *d, *du;
	
	// b vector data
	CGFloat *b;
	
	// rows count in b vector
	__CLPK_integer ldb = n;
	
	// kinda return code
	__CLPK_integer info;
	
	// 
	// Init float arrays 
	
	b = calloc(rowsCount, sizeof(CGFloat));
	d = calloc(rowsCount, sizeof(CGFloat));
	
	du = calloc(rowsCount-1, sizeof(CGFloat));
	dl = calloc(rowsCount-1, sizeof(CGFloat));
	
	for( NSUInteger i = 0; i != rowsCount; i++ ){
		b[i] = [rightSideVector valueAtIndex:i];
		d[i] = [leftSideMatrix valueAtRow:i column:i];
	}
	
	for( NSUInteger i = 0; i != (rowsCount-1); i++){
		dl[i] = [leftSideMatrix valueAtRow:i+1 column:i];
		du[i] = [leftSideMatrix valueAtRow:i column:i+1];
	}
	
	//
	// call the routine
#if defined(__LP64__) && __LP64__
    {
        dgtsv_(&n, &nrhs, dl, d, du, b, &ldb, &info);
    }
#else
    {
        sgtsv_(&n, &nrhs, dl, d, du, b, &ldb, &info);
    }
#endif
    
	
	
	if( info != 0){
		[NSException raise:@"Linear equation system sweep LAPACK error." format:@"LAPACK return code: %ld", (long)info];
	}
	
	// 
	// Create a solution vector from lapack output
	XNVector *solution = [[XNVector alloc] initWithCapacity: rowsCount filledWith: b];
	
	//
	// Free resources after lapack routines
	free(d);
	free(b);
	free(du);
	free(dl);
	
	//
	// Autorelease and return solution vector
	return [solution autorelease];
}


- (XNVector *) solveWithMaxIterations: (NSUInteger) aIterationsLimit withPrecision: (CGFloat) precision withFirstApproximation: (XNVector*) firstApproximation allowRelaxation: (BOOL) allowRelaxation
{
	iterationsLimit = aIterationsLimit;
	XNVector *solution = [firstApproximation retain];
	XNVector *oldSolution = nil;
	iterationsSpent = 1;
	
	CGFloat speed = 1.5f;

	while( (iterationsSpent < iterationsLimit) && [[[leftSideMatrix multiplyByVector:solution] substract: rightSideVector] norm] > precision){
		
		oldSolution = [solution copy];
		
		// calculate new solution and place it right into the old one.
		for( NSUInteger i = 0; i < solution.capacity; i++ ){
			CGFloat newValue = [rightSideVector valueAtIndex: i];
			
			for(NSUInteger j = 0; j < [leftSideMatrix columnsCount]; j++ ){
				if( i == j){
					continue;
				}
				newValue -= [leftSideMatrix valueAtRow:i column:j] * [solution valueAtIndex:j];
			}
			
			newValue /=  [leftSideMatrix valueAtRow: i column: i];
			
			[solution setValue:	newValue atIndex:i ];
		}
		
		iterationsSpent++;
		
		if( allowRelaxation ){ 
			for( NSUInteger i = 0; i < solution.capacity; i++ ){
				[ solution setValue: speed * [solution valueAtIndex: i] + (1 - speed)* [oldSolution valueAtIndex: i] atIndex: i];
			}
		}
        [oldSolution release];
	}
	
	return [solution autorelease];
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	[self->equationMatrix release];
    [self->leftSideMatrix release];

	[super dealloc];
}

@end
