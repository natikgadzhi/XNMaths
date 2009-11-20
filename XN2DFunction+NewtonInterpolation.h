//
//  XN2DFunction+NewtonInterpolation.h
//  Assignation 3
//
//  Created by Нат Гаджибалаев on 13.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XN2DFunction.h"


@interface XN2DFunction (NewtonInterpolation)

- (XN2DFunction*) initNewtonInterpolationWithPoints: (NSMutableArray*) aPoints;


// private helper method: f(x0,x1,x...n);
// 
+ (double) finiteDiffWithPoints: (NSMutableArray*) aPoints;

@end
