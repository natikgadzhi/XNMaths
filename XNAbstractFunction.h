//
//  XNAbstractFunction.h
//  XNMaths
//
//  XNAbstractFunction is a scalar function of any number of arguments
//
//  Created by Нат Гаджибалаев on 23.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class GCMathParser;

#pragma mark -
#pragma mark XNAbstractFunction class interface

@interface XNAbstractFunction : NSObject {
	
	// function expression; 
	NSString *expression;
	
	// arguments dictionary
	NSMutableDictionary *arguments;
	
	// maths parser
	GCMathParser *parser;
}

#pragma mark -
#pragma mark Properties
@property(retain) NSString *expression;
@property(retain) NSMutableDictionary *arguments; 

#pragma mark -
#pragma mark Class initialization
+ (XNAbstractFunction*) functionWithExpression: (NSString*)aExpression;
+ (XNAbstractFunction*) functionWithExpression: (NSString*)aExpression andArguments: (NSArray *)anArgumentNames;

#pragma mark -
#pragma mark Instance inititalization
- (XNAbstractFunction*) initWithExpression: (NSString*)aExpression; 
- (XNAbstractFunction*) initWithExpression: (NSString*)aExpression andArguments: (NSArray *)anArgumentNames;

#pragma mark -
#pragma mark Working with values and arguments

- (void) setValue: (CGFloat) aValue forArgument: (NSString *)anArgumentName;

- (CGFloat) valueWithArguments: (NSDictionary *) anArgumentsDictionary;
- (CGFloat) valueWithCurrentArguments;

@end