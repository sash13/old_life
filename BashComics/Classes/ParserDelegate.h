//
//  ParserDelegate.h
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Parser;

@protocol ParserDelegate

@required
- (void)update:(Parser *)feed successfully:(NSString *)successMsg;
- (void)update:(Parser *)feed myError:(NSString *)errorMsg;

@end
