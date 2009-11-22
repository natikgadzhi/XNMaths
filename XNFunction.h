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

@property(retain) NSString* expression;

// initialize with an expression! 
- (XNFunction*) initWithExpression: (NSString*) aExpression; 

- (double) doubleValueWithDouble: (double) a_DoubleX; 


@end
