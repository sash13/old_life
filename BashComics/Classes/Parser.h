//
//  Parser.h
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import "ParserDelegate.h"


@interface Parser : NSObject {
@private
	TFHpple * xpathParser;
	NSObject<ParserDelegate> *delegate;

}

@property (nonatomic, assign) NSObject<ParserDelegate> *delegate;

-(void)myfu;

@end
