//
//  SouthparkAppDelegate.h
//  Southpark
//
//  Created by Sasha on 9/12/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMovieViewController.h"

@class FlickrController;
@interface SouthparkAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
@private
	IBOutlet UIWindow *window;
	IBOutlet UITabBarController *tabBarController;
    //UIWindow *window;
    //UITabBarController *tabBarController;
	FlickrController *controller;
	NSOperationQueue *downloadQueue;
	MPMoviePlayerController *moviePlayer;
    UIView *loadingView;
}

//@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) NSOperationQueue *downloadQueue;
@property (readwrite, retain) MPMoviePlayerController *moviePlayer;
-(void)initAndPlayMovie:(NSURL *)movieURL;
-(void)setMoviePlayerUserSettings;
+ (SouthparkAppDelegate *)sharedAppDelegate;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
