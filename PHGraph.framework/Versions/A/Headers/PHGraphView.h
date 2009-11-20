//
//  PHGraphView.h
//  Graph
//
//  Created by Pierre-Henri Jondot on 30/03/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PHAxis.h"
#import "PHxAxis.h"
#import "PHyAxis.h"
#import "PHAxisSystem.h"
#import "PHGraphObject.h"
#import "PHPoints.h"
#import "PHCurve.h"
#import "PHLineWithCartesianEquation.h"
#import "PHFunctionGraph.h"
#import "PHParametricCurve.h"
#import "PHVectorField.h"

#define PHOnlyDelegate 0
#define PHCompositeZoomAndDrag 1
#define PHDragAndMove 2
#define PHZoomOnSelection 3

@class PHOverlayWindow;

@interface PHGraphView : NSView {
	NSMutableArray *xAxis;
	NSMutableArray *yAxis;
	NSMutableArray *graphObjects;
	NSPoint locationMouseDown;
	NSPoint locationMouseDownInView;
	NSPoint currentLocation;
	PHOverlayWindow *overlayWindow;
	BOOL isDragging;
	int mouseEventsMode;
	IBOutlet id delegate;
	BOOL hasBorder;
	float leftBorder;
	float rightBorder;
	float topBorder;
	float bottomBorder;
	NSRect drawableRect;
	NSTrackingRectTag trackingRect;
}

+ (NSMenu *)defaultMenu;

-(void)addPHxAxis:(PHxAxis*)axis;
-(void)addPHyAxis:(PHyAxis*)axis;
-(void)addPHGraphObject:(PHGraphObject*)object;
-(void)removePHxAxis:(PHxAxis*)axis;
-(void)removePHyAxis:(PHyAxis*)axis;
-(void)removePHGraphObject:(PHGraphObject*)object;
-(BOOL)isDragging;

//direct accessors to the arrays of axis and objects
-(NSMutableArray*)xAxisMutableArray;
-(NSMutableArray*)yAxisMutableArray;
-(NSMutableArray*)graphObjectsMutableArray;
-(void)setXAxisMutableArray:(NSMutableArray*)anArray;
-(void)setYAxisMutableArray:(NSMutableArray*)anArray;
-(void)setGraphObjectsMutableArray:(NSMutableArray*)anArray;

-(void)setMouseEventsMode:(int)mode;
-(void)setDelegate:(id)newDelegate;
-(void)setHasBorder:(BOOL)value;
-(void)setLeftBorder:(float)newLeftBorder rightBorder:(float)newRightBorder
		bottomBorder:(float)newBottomBorder topBorder:(float)newTopBorder;
-(id)delegate;
-(void)copyToPasteboardAsTIFF;
-(void)copyToPasteboardAsPDF;
-(void)copyToPasteboardAsEPS;

@end

@interface NSObject (methodsThatCouldBeDefinedInADelegate)
	-mouseDownAtPoint:(NSPoint)pt;
	-mouseUpAtPoint:(NSPoint)pt;
	-mouseDraggedAtPoint:(NSPoint)pt;
@end