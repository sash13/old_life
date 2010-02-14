//
//  BashCell.m
//  BashComics
//
//  Created by Sasha on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BashCell.h"
#import "Bash.h"

@implementation BashCell

@synthesize item;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
    {
        self.backgroundColor = [UIColor blackColor];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 1.0, 290.0, 20.0)];
        textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
        textLabel.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:textLabel];
		
		dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 21.0, 290.0, 10.0)];
        dateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:9.0];
		dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:dateLabel];
		
		photo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.clipsToBounds = YES;
        [self.contentView addSubview:photo];
        
        scrollingWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(14.0, 14.0, 11.0, 11.0)];
        scrollingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        scrollingWheel.hidesWhenStopped = YES;
        [scrollingWheel stopAnimating];
        [self.contentView addSubview:scrollingWheel];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

#pragma mark -
#pragma mark Public methods

- (void)setItem:(Bash *)newItem
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
            textLabel.text = item.bashInfo;
            dateLabel.text = item.bashDate;
            // This is to avoid the item loading the image
            // when this setter is called; we only want that
            // to happen depending on the scrolling of the table
            if ([item hasLoadedThumbnail])
            {
                photo.image = item.thumbnail;
            }
            else
            {
                photo.image = nil;
            }
        }
    }
}

- (void)loadImage
{
    // The getter in the FlickrItem class is overloaded...!
    // If the image is not yet downloaded, it returns nil and 
    // begins the asynchronous downloading of the image.
    UIImage *image = item.thumbnail;
    if (image == nil)
    {
        [scrollingWheel startAnimating];
    }
    photo.image = image;
}

-(void)bash:(Bash *)thumbnail didLoadThumbnail:(UIImage *)image
{
	photo.image = image;
    [scrollingWheel stopAnimating];
}

-(void)bash:(Bash *)thumbnail couldNotLoadImageError:(NSError *)error
{
	[scrollingWheel stopAnimating];
}

- (void)dealloc {
	delegate = nil;
	[photo release];
	[dateLabel release];
    [textLabel release];
    [item setDelegate:nil];
    [item release];
    [super dealloc];
}


@end
