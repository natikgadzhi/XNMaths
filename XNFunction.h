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

@class GCMathParser;
@class XNFloatRange;
@class XNLineData;

@interface XNFunction: NSObject
{	
	// the expression to evalute. 
	NSString *expression;
	
	// parser object. 
	// we need the object to pass the params
	// and than call #evalute method on it. 
	GCMathParser *parser;
}

#pragma mark -
#pragma mark Properties
@property(retain) NSString *expression;

#pragma mark -
#pragma mark Class initialization
+ (XNFunction*) functionWithExpression: (NSString*)aExpression;

#pragma mark -
#pragma mark Instance inititalization
- (XNFunction*) initWithExpression: (NSString*)aExpression; 

#pragma mark -`
#pragma mark Value getters
- (CGFloat) valueWithFloat: (CGFloat) a_X; 

#pragma mark -
#pragma mark Private (data related) 
- (XNLineData *) createLineDataInRange: (XNFloatRange*)range withQuality: (NSUInteger) lineQuality;
@end
