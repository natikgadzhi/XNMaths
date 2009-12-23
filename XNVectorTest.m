//
//  XNVectorTest.m
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 17.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNVectorTest.h"
#import "XNVector.h"


@implementation XNVectorTest

- (void) testTrue
{
	STAssertTrue( YES, @"is not true" );
}

- (void) testXNVectorCanBeAllocatedAndIsFilledByZeros
{
	NSUInteger testCapacity = 4l;
	
	XNVector *vector = [[XNVector alloc] initWithCapacity:testCapacity];
	
	STAssertEquals(vector.capacity, testCapacity, @"Capacity (%d) of the vector is wrong, should be %d", 
		vector.capacity, testCapacity);
	
	for( NSUInteger i = 0; i < vector.capacity; i++){
		STAssertEquals( [vector valueAtIndex:i], 0.0f, 
			@"Value %f at index %d in the vector seems to be uncleared during init.", 
					   [vector valueAtIndex: i], i);
	}
}

- (void) testXNVectorCanBeCretedWithMutableArray
{
	NSUInteger testCapacity = 4l;
	NSMutableArray *testVertices = [NSMutableArray arrayWithCapacity:testCapacity];
	
	for( NSUInteger i = 0; i < testCapacity; i++){
		[testVertices addObject:[ NSNumber numberWithFloat: (i * 2.5f)]];
	}
	
	XNVector *vector = [[XNVector alloc] initWithMutableArray: testVertices];
	
	STAssertEquals( [vector valueAtIndex:3], 7.5f, @"Value at index 3 should be 7.5, but was %f", [vector valueAtIndex: 3]);
}

- (void) testCanBeFilledInWithInit
{
	CGFloat filledWith[4] = { 0.0f, 1.0f, 4.0f, 3.0f };
	XNVector *vector = [[XNVector alloc] initWithCapacity: 4 filledWith: filledWith];
	
	STAssertEquals( [vector valueAtIndex:3], 3.0f, @"Value at index 3 should be equal to 3.0f, but was %f", [vector valueAtIndex:3] );
}

- (void) testThrowsOnBadIndex
{
	NSUInteger testCapacity = 4l;
	XNVector *vector = [[XNVector alloc] initWithCapacity:testCapacity];
	
	STAssertThrows([vector valueAtIndex: 10], @"Should throw an error when trying to access a vertice out of the dimensions");
	STAssertThrows([vector setValue: 3.0f atIndex: 10], @"Should throw an error when writing a vertice out of the dimensions");
}

- (void) testSetsValue
{
	NSUInteger testCapacity = 4l;
	XNVector *vector = [[XNVector alloc] initWithCapacity:testCapacity];
	[vector setValue: 5.0f atIndex: 1];

	STAssertEquals( [vector valueAtIndex: 1], 5.0f, @"Value should be set correctly, but it's %f, not 5f", [vector valueAtIndex: 1]);
}

- (void) testNorm
{
	CGFloat vectorData[] = { 5, 6, 3, 5, 2, 1 };
	
	XNVector *vector = [[XNVector alloc] initWithCapacity: 6 filledWith: &vectorData];
	
	
	STAssertEquals( [vector norm], 10.0f, @"Wrong vector norm.");
}

// test something more complex.

@end
