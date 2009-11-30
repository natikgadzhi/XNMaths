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
	CGFloat data[] = {
		1,2,3,4,
		5,6,7,8,
		9,10,12,12
	};
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: &data ];
	
	STAssertEquals( [matrix valueAtRow: 0 column: 0], 1.0f, @"Value at [1,2] should be equal to 3.0f, but was %f", [matrix valueAtRow: 0 column: 0]);
	STAssertEquals( [matrix valueAtRow: 1 column: 3], 8.0f, @"Value at [1,2] should be equal to 3.0f, but was %f", [matrix valueAtRow: 1 column: 3]);
	STAssertEquals( [matrix valueAtRow: 2 column: 3], 12.0f, @"Value at [1,2] should be equal to 3.0f, but was %f", [matrix valueAtRow: 2 column: 3]);

}

- (void) testAssignsSingleValue
{
	CGFloat data[] = {
		1,2,3,4,
		1,3.5f,3,4,
		1,2,3,4
	};
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: &data ];
	
	[matrix setValue: 10.0f atRow: 2 column: 0];
	
	STAssertEquals( [matrix valueAtRow: 2 column: 0], 10.0f, @"Value at [1,2] should be equal to 10.0f, but was %f", [matrix valueAtRow: 2 column: 0]);
}



- (void) testRetrievesColumnVector
{
	CGFloat data[] = {
		1,2,3,4,
		1,3.5f,3,4,
		1,2,3,4
	};
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: &data ];
	
	XNVector *column = [matrix columnVectorAtIndex:3];
	
	STAssertEquals( [column valueAtIndex:2], [matrix valueAtRow:2 column: 3], @"Value at [1,2] should be equal to 10.0f, but was %f", [column valueAtIndex: 2]);
	
}


- (void) testCopied
{
	CGFloat data[] = {
		2.5f, 2, 3, 4,
		1, 2.5f, 3, 4,
		1, 2, 3, 4
	};
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: &data ];
	XNMatrix *matrixCopy = [matrix copy];
	
	STAssertEquals( [matrix valueAtRow:2 column:3 ], [matrixCopy valueAtRow:2 column:3], @"Copied values should be equal." );
	
	[matrixCopy setValue: 1.0f atRow: 1 column: 1];
	
	STAssertEquals( [matrix valueAtRow:0 column:0 ], 2.5f, @"First matrix should store the old values.");
	STAssertEquals( [matrixCopy valueAtRow:1 column:1 ], 1.0f, @"Copied matrix should be an independent copy.");
}


- (void) testRemovesRow
{
	CGFloat data[] = {
		1.,1.,1.,1.,
		2.,2.,2.,2.,
		3.,3.,3.,3.
	};
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: &data ];
	
	[matrix removeRowAtIndex:1];
	
	STAssertEquals([matrix valueAtRow:1 column:0], 3.0f, @"Existing rows should be moved after one column is deleted");
	STAssertEquals( matrix.rowsCount, 2u, @"Rows count should be recuced." );
}


- (void) testRemovesColumn
{
	CGFloat data[] = {
		1.,2.,3.,4.,
		1.,2.,3.,4.,
		1.,2.,3.,4.
	};
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: &data ];
	
	[matrix removeColumnAtIndex:2];
	
	STAssertEquals([matrix valueAtRow:0 column:2 ], 4.0f, @"Existing columns should be moved after one column is deleted");
	STAssertEquals( matrix.columnsCount, 3u, @"Columns count should be recuced." );
}

- (void) testIsSquare
{
	CGFloat data[] = {
		2.5f, 2, 3,
		1, 2.5f, 3,
		1, 2, 3
	};
	
	XNMatrix *matrix = [[XNMatrix alloc] initWithRows: 3 columns: 3 filledWith: &data ];
	STAssertTrue( [matrix isSquare], @"Matrix 4x4 should respond YES to isSquare selector.");
	
	
	CGFloat newData[] = {
		2.5f, 2, 3, 4,
		1, 2.5f, 3, 4,
		1, 2, 3, 4
	};
	
	matrix = [[XNMatrix alloc] initWithRows: 3 columns: 4 filledWith: &newData ];
	STAssertFalse( [matrix isSquare], @"Matrix 4x4 should respond YES to isSquare selector.");
}

@end
