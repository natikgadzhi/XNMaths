//
//  XN2DFunction+NewtonInterpolation.m
//  Assignation 3
//
//  Created by Нат Гаджибалаев on 13.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XN2DFunction+NewtonInterpolation.h"


@implementation XN2DFunction(NewtonInterpolation)

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
	
	return ( [XN2DFunction finiteDiffWithPoints:aPointsWithoutLast] - [XN2DFunction finiteDiffWithPoints:aPointsWithoutFirst] ) / 
		( [[aPoints objectAtIndex:0] pointValue].x - [[aPoints lastObject] pointValue].x);
}

// Initialize newton interpolation with points
- (XN2DFunction*) initNewtonInterpolationWithPoints: (NSMutableArray*) aPoints
{
	NSUInteger iteration = 1;
	NSMutableString* expressionString = [NSMutableString stringWithCapacity: 50];
	
	for( NSValue* iValue in aPoints)
	{
		NSPoint i = [iValue pointValue];
		NSMutableArray* pointsForDiff = [[aPoints subarrayWithRange: NSMakeRange(0, iteration)] mutableCopy];
		
		[expressionString appendString:[NSString stringWithFormat: @"%f", [XN2DFunction finiteDiffWithPoints: pointsForDiff]]];
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
	NSLog( expressionString );
	self = [[XN2DFunction alloc] initWithExpression: expressionString];
	return self;
}

@end
