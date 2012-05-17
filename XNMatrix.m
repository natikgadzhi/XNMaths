//
//  XNMatrix.m
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import "XNMatrix.h"
#import "XNVector.h"

#pragma mark -
#pragma mark XNMatrix class implementation
@implementation XNMatrix

@synthesize rowsCount;
@synthesize columnsCount;

#pragma mark -
#pragma mark Class init methods
- (XNMatrix *) matrixWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount
{
	return [[[XNMatrix alloc] initWithRows: newRowsCount columns: newColumnsCount] autorelease];
}

- (XNMatrix *) matrixWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount filledWith: ( CGFloat *) newCArray
{
	return [[[XNMatrix alloc] initWithRows: newRowsCount columns: newColumnsCount filledWith: newCArray] autorelease];
}

#pragma mark -
#pragma mark Initialization methods.
- (XNMatrix *) initWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount 
{
	self = [super init];
	
	rowsCount = newRowsCount;
	columnsCount = newColumnsCount;
	
	data = calloc( rowsCount * columnsCount, sizeof(CGFloat));
	
	for( NSUInteger i = 0; i < rowsCount; i++ ){
		for(NSUInteger j = 0; j < columnsCount; j++){
			data[i * columnsCount + j] = 0.0f;
		}
	}
		
	return self; 
}

- (XNMatrix *) initWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount filledWith: ( CGFloat *) newCArray
{
	self = [super init];
	
	rowsCount = newRowsCount;
	columnsCount = newColumnsCount;
	
	data = calloc( rowsCount * columnsCount, sizeof(CGFloat));
	
	for( NSUInteger i = 0; i < rowsCount; i++ ){
		for(NSUInteger j = 0; j < columnsCount; j++){
			data[i * columnsCount + j] = newCArray[i * columnsCount + j];
		}
	}
	
	return self; 
}

#pragma mark -

#pragma mark -
#pragma mark Accessor methods
- (CGFloat) valueAtRow: (NSUInteger)row column: (NSUInteger)column
{
	if( row >= rowsCount || column >= columnsCount ){
		[NSException raise:@"Out of dimensions error." format:@"Trying to get element [%d, %d] of [%d, %d] matrix.", 
		 row, column, rowsCount, columnsCount];
	}
	
	return data[ (row * columnsCount) + column ];
}

- (void) setValue: (CGFloat)value atRow: (NSUInteger)row column: (NSUInteger)column
{
	if( row >= rowsCount || column >= columnsCount ){
		[NSException raise:@"Out of dimensions error." format:@"Trying to set element [%d, %d] of [%d, %d] matrix.", 
			row, column, rowsCount, columnsCount];
	}
	
	data[row * columnsCount + column] = value;
}

#pragma mark -
#pragma mark Object mgmt
- (XNMatrix *) copy
{
	return [[ XNMatrix alloc] initWithRows: rowsCount columns: columnsCount filledWith: data];
}

#pragma mark -
#pragma mark Access columns and rows
- (XNVector *) columnVectorAtIndex: (NSUInteger) index
{
	if(index >= columnsCount){
		[NSException raise:@"Out of dimensions error." format:@"Trying to access  %d column of [%d, %d] matrix.", 
		 index, rowsCount, columnsCount];
	}
	
	CGFloat *columnData = calloc(rowsCount, sizeof(CGFloat));
	
	for( NSUInteger i = 0; i < rowsCount; i++ ){
		columnData[i] = data[i * columnsCount + index];
	}
	
	XNVector* result = [[XNVector alloc] initWithCapacity: rowsCount filledWith: columnData];
    free( columnData );

    return [result autorelease];
}

- (XNVector *) rowVectorAtIndex: (NSUInteger) index
{
	if(index >= rowsCount){
		[NSException raise:@"Out of dimensions error." format:@"Trying to access  %d row of [%d, %d] matrix.", 
		 index, rowsCount, columnsCount];
	}
	
	CGFloat *rowData = calloc(columnsCount, sizeof(CGFloat));
	
	for( NSUInteger j = 0; j < columnsCount; j++ ){
		rowData[j] = data[index * columnsCount + j];
	}
	
	return [[[XNVector alloc] initWithCapacity: columnsCount filledWith: rowData]autorelease];
}

//
// removeColumnAtIndex: 
// Removes a column by index from the matrix. 
//
- (void) removeColumnAtIndex: (NSUInteger) index
{
	if( index >= columnsCount){
		[NSException raise:@"Out of dimensions error." format:@"Trying to access  %d column of [%d, %d] matrix.", 
		 index, rowsCount, columnsCount];
	}
	
	if( columnsCount == 1){
		[NSException raise: @"Can't remove row error." format: @"Can't remove a column in a single-column matrix."];
	}
	
	CGFloat *newData = calloc(rowsCount * (columnsCount - 1), sizeof(CGFloat));
	
	for( NSUInteger j = 0; j < index; j++ ){
		for( NSUInteger i = 0; i < rowsCount; i++ ){
			newData[(i * (columnsCount - 1)) + j] = data[(i * columnsCount) + j];
		}
	}
	
	for( NSUInteger j = index + 1; j < columnsCount; j++ ){
		for( NSUInteger i = 0; i < rowsCount; i++ ){
			newData[(i * (columnsCount-1)) + (j - 1)] = data[(i * columnsCount) + j];
		}
	}
	
	free(data);
	data = newData;
	columnsCount--;
}

//
// removeRowAtIndex: 
// Removes a row from the matrix. 
// 
- (void) removeRowAtIndex: (NSUInteger) index
{
	if(index >= rowsCount){
		[NSException raise:@"Out of dimensions error." format:@"Trying to access  %d row of [%d, %d] matrix.", 
		 index, rowsCount, columnsCount];
	}
	
	if( rowsCount == 1){
		[NSException raise: @"Can't remove row error." format: @"Can't remove a row in a single-row matrix."];
	}
	
	//
	// We can't just remove ane row since memory allocation is done at once. 
	// We'll create a new data array and release the one that exists now. 
	
	CGFloat *newData = calloc( (rowsCount - 1) * columnsCount, sizeof(CGFloat));
	
	// 
	// Copy data before the removed row
	for( NSUInteger i = 0; i < index; i++ ){
		for( NSUInteger j = 0; j < columnsCount; j++ ){
			newData[ (i * columnsCount) + j] = data[ (i * columnsCount) + j];
		}
	}
	
	//
	// Copy data after the removed row
	for( NSUInteger i = index + 1; i < rowsCount; i++ ){
		for( NSUInteger j = 0; j < columnsCount; j++ ){
			newData[ ((i - 1) * columnsCount) + j] = data[ (i * columnsCount) + j];
		}
	}
	
	free(data);
	data = newData;
	rowsCount--;
}

#pragma mark -
#pragma mark Matrix properties
- (BOOL) isSquare
{
	return (columnsCount == rowsCount);
}


- (XNVector *) multiplyByVector: (XNVector *) vector
{
	if( vector.capacity != columnsCount ){
		[NSException raise: @"Matrix multiplication error." format: @"Can't multiply %d-dimentional vector with %d x %d matrix.", 
		 vector.capacity, 
		 columnsCount, 
		 rowsCount];
	}
	
	XNVector *newVector = [[XNVector alloc] initWithCapacity: rowsCount];
	
	for( NSInteger i = 0; i < rowsCount; i++){
		
		CGFloat newValue = 0.;
		
		for( NSInteger j = 0; j < columnsCount; j++){
			newValue += [self valueAtRow: i column: j] * [vector valueAtIndex: j];
		}
		
		[newVector setValue: newValue atIndex: i];
	}
	
	return [newVector autorelease];
}


#pragma mark -
#pragma mark Debugging
- (void) printToLog
{
	NSLog(@"Matrix of %d on %d elements.", rowsCount, columnsCount );
	
	for(NSInteger i = 0; i < rowsCount; i++ ){
		NSMutableString *logFormatForRow = [NSMutableString stringWithCapacity: 30];
		for( NSInteger j = 0; j < columnsCount; j++ ){
			//NSLog(@"%d x %d => %f", (i * columnsCount), j, data[(i * columnsCount) + j]);
			[logFormatForRow appendString: [NSMutableString stringWithFormat: @"%1.3f, ", data[(i * columnsCount) + j]]];
		}
		NSLog(@"[%@]", logFormatForRow);
	}
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	free(data);
	
	[super dealloc];
}

@end
