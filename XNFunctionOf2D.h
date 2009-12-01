//
//  XNFunctionOf2D.h
//  XNMaths
//
//  XNFunctionOf2D class interface 
//  XNFunctionOf2D is a scalar function of point (x,y) 
//
//  Created by Нат Гаджибалаев on 01.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#pragma mark -
#pragma mark Imports

#import <Cocoa/Cocoa.h>

@class GCMathParser;

#pragma mark -
#pragma mark XNFunctionOf2D class interface

@interface XNFunctionOf2D : NSObject {
	NSString *expression;
	
	NSString *firstArgumentName, *secondArgumentName;
	
	GCMathParser *parser;
}

#pragma mark -
#pragma mark Properties
@property(retain) NSString *expression, *firstArgumentName, *secondArgumentName;

#pragma mark -
#pragma mark Class initialization
+ (XNFunctionOf2D*) functionWithExpression: (NSString*)aExpression;
+ (XNFunctionOf2D*) functionWithExpression: (NSString*)aExpression firstArgument: (NSString*) aFirstArgumentName secondArgument: (NSString*) aSecondArgumentName;

#pragma mark -
#pragma mark Instance inititalization
- (XNFunctionOf2D*) initWithExpression: (NSString*)aExpression; 
- (XNFunctionOf2D*) initWithExpression: (NSString*)aExpression firstArgument: (NSString*) aFirstArgumentName secondArgument: (NSString*) aSecondArgumentName;


#pragma mark -`
#pragma mark Value getters
- (CGFloat) valueWithX: (CGFloat) a_X y: (CGFloat) a_Y; 

@end
