//
//  FlickrCell.m
//  AsyncTable
//
//  Created by Adrian on 3/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FlickrCell.h"
#import "FlickrItem.h"

@implementation FlickrCell

@synthesize item;
@synthesize delegate;

#pragma mark -
#pragma mark Constructor and destructor

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
    {
        self.backgroundColor = [UIColor blackColor];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(110.0, 5.0, 220.0, 12.0)];
        textLabel.font = [UIFont fontWithName:@"American Typewriter" size:12.0];
        textLabel.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:textLabel];
        
        photo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 75.0)];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.clipsToBounds = YES;
        [self.contentView addSubview:photo];
        
		size = [[UILabel alloc] initWithFrame:CGRectMake(153.0, 30.0, 120.0, 10.0)];
        size.font = [UIFont fontWithName:@"American Typewriter" size:12.0];
        size.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:size];
		
        scrollingWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(42.0, 27.0, 20.0, 20.0)];
        scrollingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        scrollingWheel.hidesWhenStopped = YES;
        [scrollingWheel stopAnimating];
        [self.contentView addSubview:scrollingWheel];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)dealloc 
{
    delegate = nil;
    [photo release];
    [textLabel release];
	[size release];
    [item setDelegate:nil];
    [item release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)setItem:(FlickrItem *)newItem
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
			size.text = item.summary;
            NSLog(@"%@", item.thumbnailURL);
            // This is to avoid the item loading the image
            // when this setter is called; we only want that
            // to happen depending on the scrolling of the table
			photo.image = item.thumbnail;
            if ([item hasLoadedThumbnail])
            {
                photo.image = nil;
            }
            else
            {
                photo.image = nil;
            }
        }
    }
}

- (void)toggleImage
{
   // [UIView beginAnimations:nil context:NULL];
   // [UIView setAnimationDuration:0.5];
   // [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:photo cache:YES];
   // [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(animationFinished)];
    
  //  photo.image = item.thumbnail;
    
    //[UIView commitAnimations];
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

#pragma mark -
#pragma mark FlickrItemDelegate methods

- (void)flickrItem:(FlickrItem *)item didLoadThumbnail:(UIImage *)image
{
    photo.image = image;
    [scrollingWheel stopAnimating];
}

- (void)flickrItem:(FlickrItem *)item couldNotLoadImageError:(NSError *)error
{
    // Here we could show a "default" or "placeholder" image...
	//photo.image = nil;
    [scrollingWheel stopAnimating];
}


- (void)animationFinished
{
    if ([delegate respondsToSelector:@selector(flickrCellAnimationFinished:)])
    {
        [delegate flickrCellAnimationFinished:self];
    }
}

-(void)viewDidUnload
{
	photo.image = nil;
}

@end
