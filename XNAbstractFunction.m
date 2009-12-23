//
//  XNAbstractFunction.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 23.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNAbstractFunction.h"
#import "GCMathParser.h"

@implementation XNAbstractFunction

//
// Synthesize properties. 
@synthesize expression, arguments;

//
// Class initialization methods.
+ (XNAbstractFunction*) functionWithExpression: (NSString*)aExpression
{
	return [[[XNAbstractFunction alloc] initWithExpression: aExpression] autorelease];
}

+ (XNAbstractFunction*) functionWithExpression: (NSString*)aExpression andArguments: (NSArray *)anArgumentNames
{
	return [[[XNAbstractFunction alloc] initWithExpression: aExpression andArguments: anArgumentNames] autorelease]; 
}

#pragma mark -
#pragma mark Instance inititalization methods

//
// Initialize with just an expression. 
- (XNAbstractFunction*) initWithExpression: (NSString*)aExpression
{
	self = [super init];
	
	// init an expression
	expression = [aExpression copy];
	
	// init the parser
	parser = [[GCMathParser parser] retain];
	
	// init an empty arguments dictionary
	// 3 elements will be ok in most cases. 
	arguments = [[NSMutableDictionary alloc] initWithCapacity: 3];
	
	return self;
}

- (XNAbstractFunction*) initWithExpression: (NSString*)aExpression andArguments: (NSArray *)anArgumentNames
{
	self = [super init];
	
	// init an expression
	expression = [aExpression copy];
	
	// init the parser
	parser = [[GCMathParser parser] retain];
	
	// init an empty arguments dictionary
	arguments = [[NSMutableDictionary alloc] initWithCapacity: [anArgumentNames count]];
	
	// copy the arguments
	for( NSString *argName in anArgumentNames ){
		[arguments setObject: [NSNumber numberWithFloat: 0.] forKey: argName];
	}
	
	return self;
}

#pragma mark -
#pragma mark Working with values and arguments

- (void) setValue: (CGFloat) aValue forArgument: (NSString *)anArgumentName
{
	if( ![[arguments allKeys] containsObject: anArgumentName]){
		[NSException raise: @"XNAbstractFunction unknown argument error." 
					format: @"Argument %@ is unknown in %@ function", anArgumentName, expression];
	}
	
	[arguments setObject: [NSNumber numberWithFloat: aValue] forKey: anArgumentName];
}

- (CGFloat) valueWithArguments: (NSDictionary *) anArgumentsDictionary
{
	[arguments release];
	arguments = [anArgumentsDictionary retain];
	
	return [self valueWithCurrentArguments];
}


- (CGFloat) valueWithCurrentArguments
{
	NSEnumerator *enumerator = [arguments keyEnumerator];
	id key;
	
	while ((key = [enumerator nextObject])) {
		[parser setSymbolValue: [[arguments objectForKey: key] floatValue] forKey:key];
	}
	
	return [parser evaluate:expression];
}


//
// Deallocate instance variables
- (void) dealloc
{
	[expression release];
	[parser release];
	[arguments release];
	[super dealloc];
}

@end
