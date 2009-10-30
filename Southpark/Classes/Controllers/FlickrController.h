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
//#import "FlickrItemDelegate.h"

@class RSS;
//@class SeasonItem;
@interface FlickrController : UITableViewController <RSSDelegate, FlickrCellDelegate>
{
@private
    RSS *rss;
    NSArray *flickrItems;
	NSString *selecteds;
	//SeasonItem *itemk;
   // UINavigationController *navigationController;
}

//@property (nonatomic, readonly) UINavigationController *navigationController;
//@property (nonatomic, retain) SeasonItem *itemk;
@property (nonatomic, retain) NSString *selecteds;
- (void)reloadFeed;

@end
