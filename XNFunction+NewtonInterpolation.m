//
//  XN2DFunction+NewtonInterpolation.m
//
//  Provides XNFunction newton interpolation category. 
//  A method to init a function as a newton polynome with an array of points.
//  
//  First used in Assignation 3.1 2009
//
//  Created by Нат Гаджибалаев on 13.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNFunction+NewtonInterpolation.h"


@implementation XNFunction (NewtonInterpolation)

#pragma mark -
#pragma mark Private calss methods

//
// calculate finite differencial of values 
+ (double) finiteDiffWithPoints: (NSMutableArray*) aPoints
{
	if( [aPoints count] == 1 )
	{
		return [[aPoints objectAtIndex:0] pointValue].y;
	}
	
	// create another arrays
	NSMutableArray *aPointsWithoutLast = [aPoints mutableCopy];
	[aPointsWithoutLast removeLastObject];
	
	NSMutableArray *aPointsWithoutFirst = [aPoints mutableCopy];
	[aPointsWithoutFirst removeObjectAtIndex:0];
	
	return ( [XNFunction finiteDiffWithPoints:aPointsWithoutLast] - [XNFunction finiteDiffWithPoints:aPointsWithoutFirst] ) / 
		( [[aPoints objectAtIndex:0] pointValue].x - [[aPoints lastObject] pointValue].x);
}

//
// Initialize newton interpolation with points
- (XNFunction*) initNewtonInterpolationWithPoints: (NSMutableArray*) aPoints
{
	NSUInteger iteration = 1;
	NSMutableString* expressionString = [NSMutableString stringWithCapacity: 50];
	
	for( NSValue* iValue in aPoints)
	{
		NSPoint i = [iValue pointValue];
		NSMutableArray* pointsForDiff = [[aPoints subarrayWithRange: NSMakeRange(0, iteration)] mutableCopy];
		
		[expressionString appendString:[NSString stringWithFormat: @"%f", [XNFunction finiteDiffWithPoints: pointsForDiff]]];
		NSMutableString* productString = [NSMutableString stringWithCapacity:10];

		for( NSValue* jValue in pointsForDiff)
		{
						
			NSPoint j = [jValue pointValue];
			
			if( i.x == j.x){
				continue;
			}
			
			[productString appendString: [NSString stringWithFormat: @"(x-%f)*", j.x] ];
		}
		[productString appendString: @"1"];
		
		
		[expressionString appendString: [NSString stringWithFormat: @"*(%@)", productString]];
		
		[expressionString appendString:[NSString stringWithFormat: @"+"]];
		iteration++;
	}
	
	[expressionString appendString: @"0"];
	
	self = [[XNFunction alloc] initWithExpression: expressionString];
	return self;
}

@end
