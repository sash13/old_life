//
//  Client.m
//  BashComics
//
//  Created by Sasha on 2/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Client.h"


@implementation Client

@synthesize ID, names, url;

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	ID = pk;
	
	return self;
}

- (void)send:(NSString *)text
{
    if (names != nil)
    {
        NSString *message = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
                                                                                (CFStringRef)text,
                                                                                NULL, 
                                                                                (CFStringRef)@";/?:@&=+$,", 
                                                                                kCFStringEncodingUTF8);
        
        NSString *stringURL = [NSString stringWithFormat:url, message];
        [message release];
        NSURL *urls = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:urls];    
    }
}

- (void) dealloc {
	//[ID release];
	[url release];
	[names release];

	[super dealloc];
}
@end
