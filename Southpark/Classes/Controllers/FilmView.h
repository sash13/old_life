//
//  FilmView.h
//  Southpark
//
//  Created by Sasha on 9/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrItemDelegate.h"
#import "SouthparkAppDelegate.h"
@class FlickrItem;

@interface FilmView : UIViewController <FlickrItemDelegate> {
	
	IBOutlet UIImageView *playView;
	IBOutlet UIImageView *goView;
	IBOutlet UILabel *textLabel;
	FlickrItem *item;
		NSDictionary *jsonItem;
	

}
@property (nonatomic, retain) FlickrItem *item;
@property (nonatomic, retain) UIImageView *goView;
@property (nonatomic, retain) NSDictionary *jsonItem;
-(IBAction)play:(id)sender;


@end
