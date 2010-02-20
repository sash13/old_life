//
//  Client.h
//  BashComics
//
//  Created by Sasha on 2/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Client : NSObject {
	
	NSInteger ID;
	NSString *names;
	NSString *url;

}

@property (nonatomic, readonly) NSInteger ID;
@property (nonatomic, copy) NSString *names;
@property (nonatomic, copy) NSString *url;

@end
