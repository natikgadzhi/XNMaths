//
//  PHColor.h
//  PHGraph
//
//  Created by Pierre-Henri Jondot on 19/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
// PHColor is just a category on NSColor adding a conversion to 
// CGColorRef

#import <Cocoa/Cocoa.h>

@interface NSColor (PHColor)
	-(CGColorRef)toCGColorRef;
@end
