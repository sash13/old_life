//
//  DwObjData.m
//  Southpark
//
//  Created by Sasha on 10/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DwObjData.h"


@implementation DwObjData

@synthesize texts, sizes;

- (void) dealloc {
	[texts release];
	[sizes release];
	[super dealloc];
}

@end
