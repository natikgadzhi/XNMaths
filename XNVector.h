//
//  XNVector.h
//  Assignation 3.2
// 
//  XNVector class
//  N-dimentional vector of CGFloat. 
//
//  Created by Нат Гаджибалаев on 15.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports 

#import <CoreGraphics/CoreGraphics.h>

#pragma mark -
#pragma mark XNVector class interface

@interface XNVector : NSObject {
	//
	// array of float. 
	// dynamically allocated.
	CGFloat *data;
	
	// 
	// vector capacity
	NSUInteger capacity;
}

@property (nonatomic, assign) NSUInteger capacity;

#pragma mark -
#pragma mark Class init methods
+ (XNVector *) vectorWithMutableArray: (NSMutableArray *) vertices;
+ (XNVector *) vectorWithCapacity: (NSUInteger) newCapacity filledWith: (CGFloat *) newCArray;
+ (XNVector *) vectorWithCapacity: (NSUInteger) newCapacity;

#pragma mark -
#pragma mark Instance initialization methods
- (XNVector *) initWithMutableArray: (NSMutableArray *) vertices;
- (XNVector *) initWithCapacity: (NSUInteger) newCapacity filledWith: (CGFloat *) newCArray;
- (XNVector *) initWithCapacity: (NSUInteger) newCapacity;

#pragma mark -
#pragma mark Getters and setters
- (CGFloat) valueAtIndex: (NSUInteger) index;
- (void) setValue: (CGFloat) value atIndex: (NSUInteger) index;

- (XNVector *) substract: (XNVector *) vector;


- (XNVector *) copy;

- (CGFloat) norm;

#pragma mark -
#pragma mark IO
// TODO
// -(void) toCArray: (CGFloat*) array withCapacity: (NSUInteger)arrayCapacity; 

#pragma mark -
#pragma mark Debuging
- (void) printToLog;
@end
