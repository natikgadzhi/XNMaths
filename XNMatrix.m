//
//  XNMatrix.m
//  Assignation 3.2
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNMatrix.h"


@implementation XNMatrix

@synthesize rowsCount;
@synthesize columnsCount;

#pragma mark -
#pragma mark Initialization methods.
- (XNMatrix *) initWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount 
{
	self = [super init];
	
	rowsCount = newRowsCount;
	columnsCount = newColumnsCount;
	
	data = calloc( rowsCount, sizeof(CGFloat*));
	
	for( NSUInteger i = 0; i < rowsCount; i++ ){
		data[i] = calloc( columnsCount, sizeof(CGFloat));
		
		for(NSUInteger j = 0; j < columnsCount; j++){
			data[i][j] = 0.0f;
		}
	}
		
	return self; 
}

- (XNMatrix *) initWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount filledWith: ( CGFloat **) newCArray
{
	self = [super init];
	
	rowsCount = newRowsCount;
	columnsCount = newColumnsCount;
	
	data = calloc( rowsCount, sizeof(CGFloat*));
	
	for( NSUInteger i = 0; i < rowsCount; i++ ){
		data[i] = calloc( columnsCount, sizeof(CGFloat));
		
		for(NSUInteger j = 0; j < columnsCount; j++){
			data[i][j] = newCArray[i][j];
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
	
	return data[row][column];
}

- (void) setValue: (CGFloat)value atRow: (NSUInteger)row column: (NSUInteger)column
{
	if( row >= rowsCount || column >= columnsCount ){
		[NSException raise:@"Out of dimensions error." format:@"Trying to set element [%d, %d] of [%d, %d] matrix.", 
			row, column, rowsCount, columnsCount];
	}
	
	data[row][column] = value;
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
		columnData[i] = data[i][index];
	}
	
	return [[XNVector alloc] initWithCapacity: rowsCount filledWith: columnData];
}

- (XNVector *) rowVectorAtIndex: (NSUInteger) index
{
	if(index >= rowsCount){
		[NSException raise:@"Out of dimensions error." format:@"Trying to access  %d row of [%d, %d] matrix.", 
		 index, rowsCount, columnsCount];
	}
	
	CGFloat *rowData = calloc(columnsCount, sizeof(CGFloat));
	
	for( NSUInteger j = 0; j < columnsCount; j++ ){
		rowData[j] = data[index][j];
	}
	
	return [[XNVector alloc] initWithCapacity: columnsCount filledWith: rowData];
}

- (void) removeColumnAtIndex: (NSUInteger) index
{
	if( index >= columnsCount){
		[NSException raise:@"Out of dimensions error." format:@"Trying to access  %d column of [%d, %d] matrix.", 
		 index, rowsCount, columnsCount];
	}
	
	if( columnsCount == 1){
		[NSException raise: @"Can't remove row error." format: @"Can't remove a column in a single-column matrix."];
	}
	
	for( NSUInteger i = 0; i < rowsCount; i++ ){
		// create a shorter row
		CGFloat* dataRow = calloc(columnsCount - 1, sizeof(CGFloat));
		// copy a part of the row before removed column
		for( NSUInteger j = 0; j < index; j++ ){
			dataRow[j] = data[i][j];
		}
		
		// copy a part of the row after the column
		for( NSUInteger j = index; j < columnsCount - 1; j++ ){
			dataRow[j] = data[i][j + 1];
		}
		
		free(data[i]);
		data[i] = dataRow;
	}
	columnsCount--;
}

- (void) removeRowAtIndex: (NSUInteger) index
{
	if(index >= rowsCount){
		[NSException raise:@"Out of dimensions error." format:@"Trying to access  %d row of [%d, %d] matrix.", 
		 index, rowsCount, columnsCount];
	}
	
	if( rowsCount == 1){
		[NSException raise: @"Can't remove row error." format: @"Can't remove a row in a single-row matrix."];
	}
	
	for( NSUInteger i = index + 1; i < rowsCount; i++ ){
		data[i-1] = data[i];
	}
	
	free(data[rowsCount - 1]);
	data[rowsCount - 1] = NULL;
	rowsCount--;
}

#pragma mark -
#pragma mark Matrix properties
- (BOOL) isSquare
{
	return (columnsCount == rowsCount);
}


#pragma mark -
#pragma mark Debugging
- (void) printToLog
{
	NSLog(@"Matrix of %d on %d elements.", rowsCount, columnsCount );
	
	for(NSInteger i = 0; i < rowsCount; i++ ){
		NSMutableString *logFormatForRow = [NSMutableString stringWithCapacity: 30];
		for( NSInteger j = 0; j < columnsCount; j++ ){
			[logFormatForRow appendString: [NSMutableString stringWithFormat: @"%1.2f, ", data[i][j]]];
		}
		NSLog(@"[%@]", logFormatForRow);
	}
}


#pragma mark -
#pragma mark Dealloc
- (void) dealloc
{
	for( NSUInteger i = 0; i < rowsCount; i++ ){
		free(data[i]);
		data[i] = NULL;
	}
	free(data);
	
	[super dealloc];
}

@end
