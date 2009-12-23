//
//  XNFunctionOf2D.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import "XNFunctionOf2D.h"
#import "GCMathParser.h"

#pragma mark -
#pragma mark XNFunctionOf2D class implementation

@implementation XNFunctionOf2D

@synthesize expression, firstArgumentName, secondArgumentName;

#pragma mark -
#pragma mark Class initialization
+ (XNFunctionOf2D*) functionWithExpression: (NSString*)aExpression
{
	return [[[XNFunctionOf2D alloc] initWithExpression:aExpression] autorelease];
}

+ (XNFunctionOf2D*) functionWithExpression: (NSString*)aExpression firstArgument: (NSString*) aFirstArgumentName secondArgument: (NSString*) aSecondArgumentName
{
	return [[[XNFunctionOf2D alloc] initWithExpression:aExpression firstArgument: aFirstArgumentName secondArgument: aSecondArgumentName] autorelease];
}

#pragma mark -
#pragma mark Instance inititalization
- (XNFunctionOf2D*) initWithExpression: (NSString*)aExpression
{
	self = [super init];
	parser = [[GCMathParser parser] retain];
	expression = [aExpression copy];
	
	// default argument names 
	firstArgumentName = @"x";
	secondArgumentName = @"y";
	
	return self;	
}

- (XNFunctionOf2D*) initWithExpression: (NSString*)aExpression firstArgument: (NSString*) aFirstArgumentName secondArgument: (NSString*) aSecondArgumentName
{
	self = [super init];
	parser = [[GCMathParser parser] retain];
	expression = [aExpression copy];
	
	firstArgumentName = [aFirstArgumentName	copy];
	secondArgumentName = [aSecondArgumentName copy];
	
	return self;	
}


#pragma mark -
#pragma mark Value getters
- (CGFloat) valueWithX: (CGFloat) a_X y: (CGFloat) a_Y
{
	//TODO: Optimize this. Read GCMathParser first.
	[parser setSymbolValue: a_X forKey: firstArgumentName];
	[parser setSymbolValue: a_Y forKey: secondArgumentName];
	return (CGFloat)[parser evaluate: expression];
}

#pragma mark -
#pragma mark Deallocation method
- (void) dealloc
{
	[expression release];
	[parser release];
	[super dealloc];
}

@end
