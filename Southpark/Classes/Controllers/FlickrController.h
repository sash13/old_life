//
//  FlickrController.h
//  AsyncTable
//
//  Created by Adrian on 3/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSDelegate.h"
#import "FlickrCellDelegate.h"
#import "SeasonCellDelegate.h"

@class RSS;
@class SeasonItem;
@interface FlickrController : UITableViewController <RSSDelegate, FlickrCellDelegate, SeasonCellDelegate>
{
@private
    RSS *rss;
    NSArray *flickrItems;
	SeasonItem *item;
   // UINavigationController *navigationController;
}

//@property (nonatomic, readonly) UINavigationController *navigationController;
@property (nonatomic, retain) SeasonItem *item;
- (void)reloadFeed;

@end
