//
//  SeasonCell.h
//  Southpark
//
//  Created by Sasha on 9/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeasonCellDelegate.h"
#import "SeasonItemDelegate.h"

@class SeasonItem;

@interface SeasonCell : UITableViewCell <SeasonItemDelegate>
{
@private
    UILabel *textLabel;
	UILabel *textdescription;
	UILabel *textcoll;
    SeasonItem *item;
    ///UIImageView *photo;
   // UIActivityIndicatorView *scrollingWheel;
    NSObject<SeasonItemDelegate> *delegate;
}

@property (nonatomic, retain) SeasonItem *item;
@property (nonatomic, assign) NSObject<SeasonItemDelegate> *delegate;

//- (void)loadImage;
//- (void)toggleImage;

@end
