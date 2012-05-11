//
//  XNFunction+LagrangeInterpolation.m
//
//  Provides XNFuntion as a lagrange polynome initialization category implementation. 
//  Creates an expression. 
//  
//  Accuracy is a constant. 
//
//  Created by Нат Гаджибалаев on 12.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNFunction+LagrangeInterpolation.h"

#import <UIKit/UIKit.h>

@implementation XNFunction (LagrangeInterpolation)

//
// initializes funtion as an approximation. 
- (XNFunction*) initLagrangeInterpolationWithPoints: (NSMutableArray*)aPoints
{
		
	// init our expression template. 
	NSMutableString* expressionString = [[NSMutableString alloc] initWithCapacity: 50];
	
	for( NSValue* iValue in aPoints ){
		CGPoint i = [iValue CGPointValue];
		[expressionString appendString: [NSString stringWithFormat: @"%f*(", i.y ]];
		
		for( NSValue* jValue in aPoints) {
			CGPoint j = [jValue CGPointValue];
			
			if( i.x == j.x )
			{ 
				continue;
			}
			
			[expressionString appendString: [NSString stringWithFormat: @"((x - %f)/(%f - %f))*", 
											 j.x, i.x, j.x ]];
		}
		
		[expressionString appendString: @"1 ) + "];

	}
	[expressionString appendString:	@"0"];

	self = [[XNFunction alloc] initWithExpression: expressionString];
	return self;
}

@end
