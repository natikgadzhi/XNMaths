//
//  XN2DFunction+LagrangeInterpolation.m
//  Assignation 3
//
//  Created by Нат Гаджибалаев on 12.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XN2DFunction+LagrangeInterpolation.h"


@implementation XN2DFunction (LagrangeInterpolation)

//
// initializes funtion as an approximation. 
- (XN2DFunction*) initLagrangeInterpolationWithPoints: (NSMutableArray*)aPoints
{
		
	// init our expression template. 
	NSMutableString* expressionString = [[NSMutableString alloc] initWithCapacity: 50];
	
	for( NSValue* iValue in aPoints ){
		NSPoint i = [iValue pointValue];
		[expressionString appendString: [NSString stringWithFormat: @"%f*(", i.y ]];
		
		for( NSValue* jValue in aPoints) {
			NSPoint j = [jValue pointValue];
			
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

	self = [[XN2DFunction alloc] initWithExpression: expressionString];
	return self;
}

@end
