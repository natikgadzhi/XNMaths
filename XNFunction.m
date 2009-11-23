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
#import "GCMathParser.h"
#import "XNLineData.h"


@implementation XNFunction

@synthesize expression;

#pragma mark -
#pragma mark Class methods init
+ (XNFunction*) functionWithExpression: (NSString*)aExpression
{
	return [[XNFunction alloc] initWithExpression:aExpression];
}

#pragma mark -
#pragma mark Initialization
- (XNFunction*) initWithExpression: (NSString*) aExpression;
{ 
	self = [super init];
	parser = [[GCMathParser parser] retain];
	expression = [aExpression copy];
	return self;
} 

#pragma mark -
#pragma mark Deallocation method
- (void) dealloc
{
	[expression release];
	[parser release];
	[super dealloc];
}

#pragma mark -
#pragma mark Value getters 
- (CGFloat) valueWithFloat: (CGFloat) a_X
{
	//TODO: Optimize this. Read GCMathParser first.
	[parser setSymbolValue: a_X forKey: @"x"];
	return (CGFloat)[parser evaluate: expression];
}

#pragma mark -
#pragma mark Private (data related) 
- (XNLineData *) createLineDataInRange: (XNFloatRange*)range withQuality: (NSUInteger) lineQuality
{
	return [[XNLineData alloc] initWithFunction:self inRange: range withQuality:lineQuality];
}

@end
