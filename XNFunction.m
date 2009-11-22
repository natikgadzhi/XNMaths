//
//  XNFunction.m 
//  
//  Provides XNFunction class implementation. 
//  XNFunction is a one double function of one double argument. 
//  
//  It currently uses (not optimized) GCMathParser to parse string expressions.
// 
//  First created for assignation 3.1 2009. 
//
//  Created by Нат Гаджибалаев on 07.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNFunction.h"


@implementation XNFunction

//
// Properties
@synthesize expression;

#pragma mark -
#pragma mark Initialization

//
// Initialize a new function with a string expression. 
- (XNFunction*) initWithExpression: (NSString*) aExpression;
{ 
	self = [super init];
	parser = [[GCMathParser parser] retain];
	expression = [aExpression copy];
	return self;
} 

#pragma mark -
#pragma mark Deallocation method

// deallocate instance
- (void) dealloc
{
	[expression release];
	[parser release];
	[super dealloc];
}

#pragma mark -
#pragma mark Value getters

// 
// double with double
// Evalutes the expression once again to get the value. 
- (double) doubleValueWithDouble: (double) a_DoubleX
{
	[parser setSymbolValue: a_DoubleX forKey: @"x"];
	return [parser evaluate: expression];
}

@end
