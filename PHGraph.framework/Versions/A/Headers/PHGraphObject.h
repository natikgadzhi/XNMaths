//
//  PHGraphObject.h
//  Graph
//
//  Created by Pierre-Henri Jondot on 01/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PHxAxis.h"
#import "PHyAxis.h"

@interface PHGraphObject : NSObject {
	PHxAxis *xAxis;
	PHyAxis *yAxis;
	BOOL shouldDraw;
}

-(void)drawWithContext:(CGContextRef)context rect:(NSRect)rect;
-(id)initWithXAxis:(PHxAxis *)aPHxAxis yAxis:(PHyAxis *)aPHyAxis;
-(void)setXAxis:(PHxAxis *)aPHxAxis;
-(void)setYAxis:(PHyAxis *)aPHyAxis;
-(BOOL)isLongToDraw;
-(BOOL)shouldDraw;
-(void)setShouldDraw:(BOOL)flag;

@end
