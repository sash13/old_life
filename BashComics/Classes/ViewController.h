//
//  ViewController.h
//  BashComics
//
//  Created by Sasha on 2/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapDetectingImageView.h"

@class Bash;


@interface ViewController : UIViewController <UIScrollViewDelegate, TapDetectingImageViewDelegate> {
	
	Bash *item;
	UIScrollView *imageScrollView;
	BashComicsAppDelegate *appDelegate;


}

@property (nonatomic, retain) Bash *item;

-(IBAction)hide:(id)sender;
-(IBAction)open:(id)sender;
@end

