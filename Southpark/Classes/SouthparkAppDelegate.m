//
//  SouthparkAppDelegate.m
//  Southpark
//
//  Created by Sasha on 9/12/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SouthparkAppDelegate.h"
#import "FlickrController.h"
#import "RSS.h"
@implementation SouthparkAppDelegate

//@synthesize window;
//@synthesize tabBarController;
@synthesize downloadQueue;

+ (SouthparkAppDelegate *)sharedAppDelegate
{
    return (SouthparkAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    downloadQueue = [[NSOperationQueue alloc] init];
	controller = [[FlickrController alloc] init];
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
	//[window makeKeyAndVisible];
   // [controller reloadFeed];
}


- (void)showLoadingView
{
    if (loadingView == nil)
    {
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        loadingView.opaque = NO;
        loadingView.backgroundColor = [UIColor darkGrayColor];
        loadingView.alpha = 0.5;
		
        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(142.0, 222.0, 37.0, 37.0)];
        [spinningWheel startAnimating];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [loadingView addSubview:spinningWheel];
        [spinningWheel release];
    }
    
    [window addSubview:loadingView];
}

- (void)hideLoadingView
{
    [loadingView removeFromSuperview];
}


- (void)dealloc {
	[controller release];
    [tabBarController release];
	[downloadQueue release];
    [window release];
    [super dealloc];
}

@end

