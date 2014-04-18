//
//  XNAbstractFunctionTest.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 23.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNAbstractFunctionTest.h"


@implementation XNAbstractFunctionTest

- (void)testSimpleOperations
{
	XNAbstractFunction *func = [[XNAbstractFunction alloc] initWithExpression: @"x + y + z + t" 
																 andArguments: @[ @"x", @"y", @"z", @"z"] ];

	func.arguments = @{
    @"y" : @( 8. )
    @"z" : @( -2. )
    @"t" : @( 3. )
    };

	STAssertEquals( [func valueWithCurrentArguments], 10.0f, @"Incorrect value");

	[func setValue: 10. forArgument: @"y"];

	STAssertEquals( [func valueWithCurrentArguments], 12.0f, @"Incorrect value");

	STAssertThrows( [func setValue: 123 forArgument: @"smth"], @"Should raise an error when setting unknown argument." );

	[func release];
}
@end
