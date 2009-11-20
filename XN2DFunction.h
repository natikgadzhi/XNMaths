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

#import <Cocoa/Cocoa.h>

#import "GCMathParser.h"
#import "Graphable.h"

/* 
 * A math function model. 
 * holds the expression and allows single argument value retrieval. 
 */
@interface XN2DFunction: NSObject <Graphable>
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
- (XN2DFunction*) initWithExpression: (NSString*) aExpression; 



@end
