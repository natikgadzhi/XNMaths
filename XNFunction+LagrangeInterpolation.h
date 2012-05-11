//
//  XNFunction category to initialize a function as a lagrange interpolation polynome.
//
//  Created by Нат Гаджибалаев on 12.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNFunction.h"

@interface XNFunction (LagrangeInterpolation)

- (XNFunction*) initLagrangeInterpolationWithPoints: (NSMutableArray*)aPoints;

@end
