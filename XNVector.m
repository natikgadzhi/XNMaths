//
//  XNVector.m
//  Assignation 3.2
// 
//  XNVector class
//  N-dimentional vector of double.
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNVector.h"


@implementation XNVector

@synthesize capacity;

#pragma mark -
#pragma mark Initialization methods

// Init with just a capacity (really just allocates) 
- (XNVector *) initWithCapacity: (NSUInteger) newCapacity
{
	// init
	self = [super init];
	
	// copy capacity
	capacity = newCapacity;
	
	// allocate data
	data = calloc(capacity, sizeof( CGFloat ));
	
	// clear data
	for( NSUInteger i = 0; i < capacity; i++){
		data[i] = 0;
	}
	
	return self;
}

- (XNVector *) initWithCapacity: (NSUInteger) newCapacity filledWith: (CGFloat *) newCArray
{
	// init
	self = [super init];
	
	// copy capacity
	capacity = newCapacity;
	
	// allocate data
	data = calloc(capacity, sizeof( CGFloat ));
	
	// copy data
	for( NSUInteger i = 0; i < capacity; i++){
		data[i] = newCArray[i];
	}
	
	return self;
}


// Initilize the vector with array of double
- (XNVector *) initWithMutableArray: (NSMutableArray *) newVertices 
{
	self = [self initWithCapacity: newVertices.count];
	
	for( NSUInteger i = 0; i < newVertices.count; i++){
		[self setValue: [[newVertices objectAtIndex: i] floatValue] atIndex: i];
	}
	
	return self;
}

#pragma mark -
#pragma mark Getters and setters

- (CGFloat) valueAtIndex: (NSUInteger) index
{
	if( index >= capacity ){ 
		[NSException raise:@"Trying to get not existing vertice from vector" 
					format:@"Trying to get vertice at index %d", index];
	}
	
	return data[index];
}

- (void) setValue: (CGFloat) value atIndex: (NSUInteger) index
{
	if( index >= capacity ){ 
		[NSException raise:@"Trying to get not existing vertice from vector" 
					format:@"Trying to get vertice at index %d", index];
	}
	
	data[index] = value; 
}

#pragma mark -
#pragma mark Debuging
- (void) printToLog
{
	NSLog(@"Vector if $d elements", capacity);
	NSMutableString *logFormatForRow = [NSMutableString stringWithCapacity: 30];
	for( NSInteger i = 0; i < capacity; i++ ){
		[logFormatForRow appendString: [NSMutableString stringWithFormat: @"%1.2f, ", data[i]]];
	}
	NSLog(@"[%s]", logFormatForRow);
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	// free the vertices array. 
	free(data);
	data = NULL;
	[super dealloc];
}

@end
