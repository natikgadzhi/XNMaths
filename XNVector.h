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

#import <Cocoa/Cocoa.h>


@interface XNVector : NSObject {
	// real data storage
	CGFloat *data;
	NSUInteger capacity;
}

@property NSUInteger capacity;

#pragma mark -
#pragma mark Initialization methods
- (XNVector *) initWithMutableArray: (NSMutableArray *) newVertices;
- (XNVector *) initWithCapacity: (NSUInteger) newCapacity filledWith: (CGFloat *) newCArray;
- (XNVector *) initWithCapacity: (NSUInteger) newCapacity;

#pragma mark -
#pragma mark Getters and setters
- (CGFloat) valueAtIndex: (NSUInteger) index;
- (void) setValue: (CGFloat) value atIndex: (NSUInteger) index;

#pragma mark -
#pragma mark Debuging
- (void) printToLog;
@end
