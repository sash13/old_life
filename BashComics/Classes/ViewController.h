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
@class Client;


@interface ViewController : UIViewController <UIScrollViewDelegate, TapDetectingImageViewDelegate, UIActionSheetDelegate> {
	
	Bash *item;
	UIScrollView *imageScrollView;
	BashComicsAppDelegate *appDelegate;

	//UIImageView *photoView;
	NSArray *_clients;


}

@property (nonatomic, retain) Bash *item;

-(IBAction)hide:(id)sender;
-(IBAction)open:(id)sender;
-(void)add;

@end

