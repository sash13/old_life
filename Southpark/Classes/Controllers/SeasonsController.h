//
//  SeasonsController.h
//  Southpark
//
//  Created by Sasha on 9/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSDelegate.h"
#import "SeasonCellDelegate.h"

@class RSS;

@interface SeasonsController : UITableViewController <RSSDelegate, SeasonCellDelegate>
{
@private
    RSS *rss;
    NSArray *seasonItems;
	// UINavigationController *navigationController;
}

//@property (nonatomic, readonly) UINavigationController *navigationController;

- (void)reloadFeed;

@end

