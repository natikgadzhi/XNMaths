//
//  XNPlotManager.h
//  XNMaths
//
//  Created by Нат Гаджибалаев on 03.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XNPlotManager : NSObject {
	
	NSUInteger rows, cols;
	
	// plots count.
	NSUInteger connectedPlots, maxPlots;
	
	// already initialized?
	BOOL isInitialized;
}

@property NSUInteger rows, cols;
@property(readonly) BOOL isInitialized;
@property(readonly) NSUInteger connectedPlots, maxPlots;

//
// Init

+ (XNPlotManager *) sharedManager;
- (XNPlotManager *) init;

- (NSInteger) addPlot;

- (void) startPlotting;
- (void) endPlotting;

@end
