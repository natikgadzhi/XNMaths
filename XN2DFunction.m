//
//  XNFunction.m 
// 
//  Calculus of approximations, Moscow State University of Aviation
//  Assignation 3
//  
//
//  Created by Нат Гаджибалаев on 07.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XN2DFunction.h"


@implementation XN2DFunction

@synthesize expression;

//
// Initialize a new function with a string expression. 
// 
- (XN2DFunction*) initWithExpression: (NSString*) aExpression;
{ 
	self = [super init];
	parser = [[GCMathParser parser] retain];
	expression = [aExpression copy];
	return self;
} 

// deallocate instance
- (void) dealloc
{
	[expression release];
	[parser release];
	[super dealloc];
}

//
// Get function value for one argument. 
//

// object with object
- (NSNumber*) objectValueWithObject: (NSNumber*) a_X 
{
	[parser setSymbolValue: [a_X doubleValue] forKey: @"x" ];
	return [[NSNumber alloc] initWithDouble:[parser evaluate: expression]];
}

// object with double
- (NSNumber*) objectValueWithDouble: (double) a_DoubleX
{
	[parser setSymbolValue: a_DoubleX forKey: @"x"];
	return [[NSNumber alloc] initWithDouble:[parser evaluate: expression]];
}

// double with double
- (double) doubleValueWithDouble: (double) a_DoubleX
{
	[parser setSymbolValue: a_DoubleX forKey: @"x"];
	return [parser evaluate: expression];
}

@end
