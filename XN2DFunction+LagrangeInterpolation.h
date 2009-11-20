//
//  XN2DFunction+LagrangeInterpolation.h
//  Assignation 3
//
//  Created by Нат Гаджибалаев on 12.11.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XN2DFunction.h"

@interface XN2DFunction (LagrangeInterpolation)

- (XN2DFunction*) initLagrangeInterpolationWithPoints: (NSMutableArray*)aPoints;

@end
