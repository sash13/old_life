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
#import "AdMobDelegateProtocol.h"
#import "AdMobView.h"

@class RSS;

@interface SeasonsController : UITableViewController <RSSDelegate, SeasonCellDelegate, AdMobDelegate>
{
@private
    RSS *rss;
    NSArray *seasonItems;
	// UINavigationController *navigationController;
}

//@property (nonatomic, readonly) UINavigationController *navigationController;

- (void)reloadFeed;

@end

