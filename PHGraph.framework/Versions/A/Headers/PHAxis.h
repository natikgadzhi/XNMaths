//
//  PHAxis.h
//  Graph
//
//  Created by Pierre-Henri Jondot on 30/03/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define PHEPSILON 1e-5
#ifndef CFGFloat
#define CGFloat float
#endif

//Some flags that can be combined (except for the two last ones)
#define PHShowGrid 1
#define PHShowGraduationAtLeft 2
#define PHShowGraduationAtBottom 2
#define PHShowGraduationAtRight 4
#define PHShowGraduationAtTop 4
#define PHIsLog 8
#define PHSmall 16
#define PHBig 32

@interface PHAxis : NSObject {
	double minimum, maximum;
	double minimumRetained, maximumRetained;
//	NSString *caption;
	int style;
	float width;
	NSColor *cocoaColor;
	NSMutableDictionary *attributes;
	BOOL drawOutside;
	BOOL predefinedMajorTickWidth;
	double majorTickWidth;
	int minorTicksNumber;
}

-(id)initWithStyle:(int)the_style;
-(void)setMinimum: (double)newMinimum maximum:(double)newMaximum;
-(void)zoomWithMinimum:(float)newMinimum maximum:(float)newMaximum;
-(NSMutableArray*)majorTickMarks;
-(NSMutableArray*)minorTickMarks;
-(void)saveValues;
-(void)moveByFactor:(double)factor;
-(double)majorTickWidth;
-(void)calculateMajorTickWidth;
-(void)zoomin;
-(void)zoomout;
-(double)minimum;
-(double)maximum;
-(int)style;
-(void)setStyle:(int)newStyle;
-(void)setColor:(NSColor*)newColor;
-(NSColor*)color;
//returns the double value of x position relative to the view
-(double)convertValue:(float)x;
//-(void)setCaption:(NSString*)newCaption;
-(void)setDrawOutside:(BOOL)value;
-(NSMutableDictionary*)attributes;
-(void)setMajorTickWidth:(double)newValue;
-(void)unsetMajorTickWidth;
-(void)setMinorTicksNumber:(int)newValue;
-(void)setWidth:(float)newWidth;

@end
