//
//  untitled.h
//  BashComics
//
//  Created by Sasha on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


@class Bash;

@protocol BashDelegate

@required
- (void)bash:(Bash *)thumbnail couldNotLoadImageError:(NSError *)error;

@optional
- (void)bash:(Bash *)thumbnail didLoadThumbnail:(UIImage *)image;

@end
