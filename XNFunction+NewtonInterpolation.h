//
//  XNFunction+NewtonInterpolation.h
//
//  XNFunction newton interpolation polynome initializer method category. 
//
//  Created by Нат Гаджибалаев on 13.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNFunction.h"


@interface XNFunction (NewtonInterpolation)

- (XNFunction*) initNewtonInterpolationWithPoints: (NSMutableArray*) aPoints;


//
// private helper method: f(x0,x1,x...n);
+ (double) finiteDiffWithPoints: (NSMutableArray*) aPoints;

@end
