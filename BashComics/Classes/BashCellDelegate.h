//
//  BashCellDelegate.h
//  BashComics
//
//  Created by Sasha on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//



@class BashCell;

@protocol BashCellDelegate

@required
- (void)bashCellAnimationFinished:(BashCell *)cell;

@end
