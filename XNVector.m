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

#pragma mark -
#pragma mark Imports

#import "XNVector.h"

#pragma mark -
#pragma mark XNVector class implementation

@implementation XNVector

@synthesize capacity;

#pragma mark -
#pragma mark Class init methods

+ (XNVector *) vectorWithMutableArray: (NSMutableArray *) vertices
{
	return [[XNVector alloc] initWithMutableArray: vertices];
}

+ (XNVector *) vectorWithCapacity: (NSUInteger) newCapacity filledWith: (CGFloat *) newCArray
{
	return [[XNVector alloc] initWithCapacity: newCapacity filedWith: newCArray];
}

+ (XNVector *) vectorWithCapacity: (NSUInteger) newCapacity
{
	return [[XNVector alloc] initWithCapacity: newCapacity];
}

#pragma mark -
#pragma mark Instance initialization methods

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
- (XNVector *) initWithMutableArray: (NSMutableArray *) vertices 
{
	self = [self initWithCapacity: vertices.count];
	
	for( NSUInteger i = 0; i < vertices.count; i++){
		[self setValue: [[vertices objectAtIndex: i] floatValue] atIndex: i];
	}
	
	return self;
}

- (XNVector *) substract: (XNVector *) vector
{
	if( capacity != vector.capacity){
		[NSException raise: @"Vector operations error." format: @"Can't substract [%d] vector from [%d] vector.", vector.capacity, capacity];
	}
	
	XNVector *result = [[XNVector alloc] initWithCapacity: capacity];
	
	for( NSInteger i = 0; i < capacity; i++){
		[result setValue: [self valueAtIndex: i] - [vector valueAtIndex: i] atIndex: i];
	}
	
	return [result autorelease];
}


- (CGFloat) norm
{
	CGFloat norm = 0.0f;
	
	for( NSInteger i = 0; i < capacity; i++ ){
		norm += powf([self valueAtIndex: i], 2);
	}
	
	return sqrtf(norm);
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

- (XNVector *) copy
{
	XNVector *copiedVector = [[XNVector alloc] initWithCapacity: capacity];
	
	for( NSInteger i = 0; i < capacity; i++){
		[copiedVector setValue: [self valueAtIndex:i] atIndex: i];
	}
	
	return copiedVector;
}

#pragma mark -
#pragma mark Debuging
- (void) printToLog
{
	NSLog(@"Vector if %d elements", capacity);
	NSMutableString *logFormatForRow = [NSMutableString stringWithCapacity: 30];
	for( NSInteger i = 0; i < capacity; i++ ){
		[logFormatForRow appendString: [NSMutableString stringWithFormat: @"%1.2f, ", data[i]]];
	}
	NSLog(@"[%@]", logFormatForRow);
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
