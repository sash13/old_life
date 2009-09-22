//
//  SeasonCell.m
//  Southpark
//
//  Created by Sasha on 9/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SeasonCell.h"
#import "SeasonItem.h"

@implementation SeasonCell

@synthesize item;
@synthesize delegate;

#pragma mark -
#pragma mark Constructor and destructor

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
    {
        self.backgroundColor = [UIColor blackColor];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(230.0, 10.0, 80.0, 10.0)];
        textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:14.0];
        textLabel.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:textLabel];
        
		textdescription = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 100.0, 10.0)];
        textdescription.font = [UIFont fontWithName:@"Courier-Bold" size:14.0];
        textdescription.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:textdescription];
		
		textcoll = [[UILabel alloc] initWithFrame:CGRectMake(153.0, 30.0, 120.0, 10.0)];
        textcoll.font = [UIFont fontWithName:@"Courier-Bold" size:14.0];
        textcoll.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:textcoll];
		
       // photo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 75.0, 75.0)];
        //photo.contentMode = UIViewContentModeScaleAspectFill;
        //photo.clipsToBounds = YES;
       // [self.contentView addSubview:photo];
        
       // scrollingWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(27.0, 27.0, 20.0, 20.0)];
       // scrollingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
       // scrollingWheel.hidesWhenStopped = YES;
      //  [scrollingWheel stopAnimating];
       // [self.contentView addSubview:scrollingWheel];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)dealloc 
{
   // delegate = nil;
   // [photo release];
    [textLabel release];
	[textdescription release];
	[textcoll release];
    [item setDelegate:nil];
    [item release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)setItem:(SeasonItem *)newItem
{
    if (newItem != item)
    {
        item.delegate = nil;
        [item release];
        item = nil;
        
        item = [newItem retain];
        [item setDelegate:self];
        
        if (item != nil)
        {
            textLabel.text = item.title;
			textdescription.text = item.summary;
			textcoll.text = [NSString stringWithFormat:@"Episodes %@", item.date];
           // NSLog(@"%@", item.thumbnailURL);
            // This is to avoid the item loading the image
            // when this setter is called; we only want that
            // to happen depending on the scrolling of the table
           // if ([item hasLoadedThumbnail])
          //  {
           //     photo.image = item.thumbnail;
           // }
           // else
           // {
              //  photo.image = nil;
           // }
        }
    }
}



@end