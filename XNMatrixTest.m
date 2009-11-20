//
//  XNMatrixTest.m
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 17.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNMatrixTest.h"
#import "XNMatrix.h"


@implementation XNMatrixTest

- (void) testCreatesWithCapacitiesAndArrays
{
	CGFloat **data = calloc(3, sizeof(CGFloat*));
	
	for(NSUInteger i = 0; i < 3; i++){
		data[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			data[i][j] = i + j + 0.5f;
		}
	}
	
	
	//CGFloat *dataPtr = &data[0];
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: data ];
	
	STAssertEquals( [matrix valueAtRow: 1 column: 2], 3.5f, @"Value at [1,2] should be equal to 3.0f, but was %f", [matrix valueAtRow: 1 column: 2]);
}

- (void) testAssignsSingleValue
{
	CGFloat **data = calloc(3, sizeof(CGFloat*));
	
	for(NSUInteger i = 0; i < 3; i++){
		data[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			data[i][j] = i*j + 0.5f;
		}
	}
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: data ];
	
	[matrix setValue: 10.0f atRow: 2 column: 0];
	
	STAssertEquals( [matrix valueAtRow: 2 column: 0], 10.0f, @"Value at [1,2] should be equal to 10.0f, but was %f", [matrix valueAtRow: 2 column: 0]);
}



- (void) testRetrievesColumnVector
{
	CGFloat **data = calloc(3, sizeof(CGFloat*));
	
	for(NSUInteger i = 0; i < 3; i++){
		data[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			data[i][j] = i*j + 0.5f;
		}
	}
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: data ];
	
	XNVector *column = [matrix columnVectorAtIndex:3];
	
	STAssertEquals( [column valueAtIndex:2], [matrix valueAtRow:2 column: 3], @"Value at [1,2] should be equal to 10.0f, but was %f", [column valueAtIndex: 2]);
	
}


- (void) testCopied
{
	CGFloat **data = calloc(3, sizeof(CGFloat*));
	
	for(NSUInteger i = 0; i < 3; i++){
		data[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			data[i][j] = i + j + 0.5f;
		}
	}
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: data ];
	XNMatrix *matrixCopy = [matrix copy];
	
	STAssertEquals( [matrix valueAtRow:2 column:3 ], [matrixCopy valueAtRow:2 column:3], @"Copied values should be equal." );
	
	[matrixCopy setValue: 1.0f atRow: 1 column: 1];
	
	STAssertEquals( [matrix valueAtRow:1 column:1 ], 2.5f, @"First matrix should store the old values.");
	STAssertEquals( [matrixCopy valueAtRow:1 column:1 ], 1.0f, @"Copied matrix should be an independent copy.");
}


- (void) testRemovesRow
{
	CGFloat **data = calloc(3, sizeof(CGFloat*));
	
	for(NSUInteger i = 0; i < 3; i++){
		data[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			data[i][j] = i + j + 0.5f;
		}
	}
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: data ];
	
	[matrix removeRowAtIndex:1];
	STAssertEquals([matrix valueAtRow:1 column:2 ], 4.5f, @"Existing rows should be moved after one column is deleted");
	STAssertEquals( matrix.rowsCount, 2u, @"Rows count should be recuced." );
}


- (void) testRemovesColumn
{
	CGFloat **data = calloc(3, sizeof(CGFloat*));
	
	for(NSUInteger i = 0; i < 3; i++){
		data[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			data[i][j] = i + j + 0.5f;
		}
	}
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: data ];
	
	[matrix removeColumnAtIndex:2];
	STAssertEquals([matrix valueAtRow:2 column:2 ], 5.5f, @"Existing columns should be moved after one column is deleted");
	STAssertEquals( matrix.columnsCount, 3u, @"Columns count should be recuced." );
}

- (void) testIsSquare
{
	// test is square
	CGFloat **data = calloc(4, sizeof(CGFloat*));
	for(NSUInteger i = 0; i < 4; i++){
		data[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			data[i][j] = i + j + 0.5f;
		}
	}
	XNMatrix *squareMatrix = [[XNMatrix alloc] initWithRows: 4 columns: 4 filledWith: data ];
	STAssertTrue( [squareMatrix isSquare], @"Matrix 4x4 should respond YES to isSquare selector.");
	
	
	// test is not square
	CGFloat **notSquareData = calloc(3, sizeof(CGFloat*));
	for(NSUInteger i = 0; i < 3; i++){
		notSquareData[i] = calloc(4, sizeof(CGFloat));
		for(NSUInteger j = 0; j < 4; j++){
			notSquareData[i][j] = i + j + 0.5f;
		}
	}
	XNMatrix *notSquareMatrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: notSquareData ];
	STAssertFalse( [notSquareMatrix isSquare], @"Matrix 4x4 should respond YES to isSquare selector.");
}

@end
