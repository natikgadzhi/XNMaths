//
//  XNMatrix.h
//  Assignation 3.2
// 
//  XNMatrix class
//  A Matrix of ids. 
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import <Cocoa/Cocoa.h>
@class XNVector;

#pragma mark -
#pragma	mark XNMatrix class interface

@interface XNMatrix : NSObject {
	NSUInteger rowsCount, columnsCount;
	CGFloat *data;
}

@property NSUInteger rowsCount, columnsCount;

#pragma mark -
#pragma mark Class init methods
- (XNMatrix *) matrixWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount;
- (XNMatrix *) matrixWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount filledWith: ( CGFloat *) newCArray;


#pragma mark -
#pragma mark Initialization methods.
- (XNMatrix *) initWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount;
- (XNMatrix *) initWithRows: (NSUInteger) newRowsCount columns: (NSUInteger) newColumnsCount filledWith: ( CGFloat *) newCArray;

#pragma mark -
#pragma mark Object mgmt
- (XNMatrix *) copy;

#pragma mark -
#pragma mark Accessor methods
- (CGFloat) valueAtRow: (NSUInteger)row column: (NSUInteger)column;
- (void) setValue: (CGFloat)value atRow: (NSUInteger)row column: (NSUInteger)column;

#pragma mark -
#pragma mark Access columns and rows
- (XNVector *) columnVectorAtIndex: (NSUInteger) index;
- (XNVector *) rowVectorAtIndex: (NSUInteger) index;


- (XNVector *) multiplyByVector: (XNVector *) vector;

- (void) removeColumnAtIndex: (NSUInteger) index;
- (void) removeRowAtIndex: (NSUInteger) index;

#pragma mark -
#pragma mark Matrix properties
- (BOOL) isSquare;

#pragma mark -
#pragma mark Debugging
- (void) printToLog;

@end
