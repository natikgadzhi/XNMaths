//
//  XNPlotManager.m
//  XNMaths
//
//  Created by Нат Гаджибалаев on 03.12.09.
//  Copyright 2009 Нат Гаджибалаев. All rights reserved.
//

#import "XNPlotManager.h"

//
// Singletone implementation 
static XNPlotManager *sharedManager = nil;

@implementation XNPlotManager

//
// Synthesize properties
@synthesize maxPlots, connectedPlots, isInitialized;

+ (XNPlotManager *) sharedManager {
	@synchronized(self) {
		if(sharedManager == nil){
			[[self alloc] init];
		}
	}
	return sharedManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if(sharedManager == nil)  {
			sharedManager = [super allocWithZone:zone];
			return sharedManager;
		}
	}
	return nil;
}
- (id)copyWithZone:(NSZone *)zone {
	return self;
}
- (id)retain {
	return self;
}
- (unsigned)retainCount {
	return UINT_MAX; //denotes an object that cannot be released
}
- (oneway void)release {
	// never release
}
- (id)autorelease {
	return self;
}

//
// Init methods 

- (XNPlotManager *) init {
	self = [super init];
	cols = 1;
	rows = 1;
	isInitialized = NO;
	
	maxPlots = 1;
	connectedPlots = 0;
	
	return self;
}

//
// Properties

- (NSUInteger) cols {
	return cols;
}

- (void) setCols: (NSUInteger) iCols {
	if( isInitialized ){
		[NSException raise:@"XNPlotManager exception." format:@"Trying to set cols after plotting was started."];
	} else {
		cols = iCols;
		maxPlots = rows * cols;
	}
}

- (NSUInteger) rows {
	return rows;
}

- (void) setRows: (NSUInteger) iRows {
	if( isInitialized ){
		[NSException raise:@"XNPlotManager exception." format:@"Trying to set rows after plotting was started."];
	} else {
		rows = iRows;
		maxPlots = rows * cols;
	}
}


//
// Control methods

- (BOOL) addPlot {
	if( ( connectedPlots < maxPlots ) && isInitialized ) {
		connectedPlots++;
		return YES;
	}
	
	return NO;
}

- (void) startPlotting {
	if(!isInitialized){
		plscolbg(255,255,255);
		plscol0(1, 0, 0, 0);
		plstart("aqt", cols, rows);
	}
	
	isInitialized = YES;
}

- (void) endPlotting {
	plend1();
	connectedPlots = 0;
	isInitialized = NO;
}

//
// Memory mgmt

- (void) dealloc {
	[super dealloc];
}

@end
