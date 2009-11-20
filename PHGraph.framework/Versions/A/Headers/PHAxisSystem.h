//
//  PHAxisSystem.h
//  PHGraph
//
//  Created by Pierre-Henri Jondot on 12/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "PHGraphObject.h"


@interface PHAxisSystem : PHGraphObject {
	float width;
}

-(id)initWithXAxis:(PHxAxis *)aPHxAxis yAxis:(PHyAxis *)aPHyAxis;
-(void)setWidth:(float)newWidth;
@end
