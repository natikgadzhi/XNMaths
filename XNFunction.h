//
//  XNFunction.m 
// 
//  XNFunction class. 
//  XNFunction represents a numeric function with a numeric argument.
//
//  Created by Нат Гаджибалаев on 07.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GCMathParser.h"
#import "plplot.h"

@interface XNFunction: NSObject
{	
	// the expression to evalute. 
	NSString* expression;
	
	// parser object. 
	// we need the object to pass the params
	// and than call #evalute method on it. 
	GCMathParser* parser;
}

#pragma mark -
#pragma mark Properties
@property(retain) NSString* expression;

#pragma mark -
#pragma mark Initialization
// initialize with an expression! 
- (XNFunction*) initWithExpression: (NSString*) aExpression; 

#pragma mark -
#pragma mark Value getters
- (double) doubleValueWithDouble: (double) a_DoubleX; 

#pragma mark -
#pragma mark Graphics and plotting related
- (void) render;

@end
