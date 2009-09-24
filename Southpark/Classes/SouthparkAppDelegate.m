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
@synthesize moviePlayer;

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
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePreloadDidFinish:) 
												 name:MPMoviePlayerContentPreloadDidFinishNotification 
											   object:nil];
	
	// Register to receive a notification when the movie has finished playing. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:nil];
	
	// Register to receive a notification when the movie scaling mode has changed. 
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(movieScalingModeDidChange:) 
												 name:MPMoviePlayerScalingModeDidChangeNotification 
											   object:nil];
	
}

-(void)initAndPlayMovie:(NSURL *)movieURL
{
	// Initialize a movie player object with the specified URL
	MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	if (mp)
	{
		// save the movie player object
		self.moviePlayer = mp;
		[mp release];
		
		// Apply the user specified settings to the movie player object
		[self setMoviePlayerUserSettings];
		
		// Play the movie!
		[self.moviePlayer play];
	}
}
-(void)setMoviePlayerUserSettings
{
	// Копирует базу данных из ресурсов приложения в папку Documents на iPhone
	self.moviePlayer.scalingMode = MPMovieScalingModeNone;
	/* 
	 Movie control mode can be one of: MPMovieControlModeDefault, MPMovieControlModeVolumeOnly,
	 MPMovieControlModeHidden.
	 */
	// mMoviePlayer.movieControlMode = appDelegate.controlMode;
	self.moviePlayer.movieControlMode = MPMovieControlModeDefault;
	/*
	 The color of the background area behind the movie can be any UIColor value.
	 */
	self.moviePlayer.backgroundColor = [UIColor blackColor];
}

//  Notification called when the movie finished preloading.
- (void) moviePreloadDidFinish:(NSNotification*)notification
{
	/* 
	 < add your code here >
	 
	 MPMoviePlayerController* moviePlayerObj=[notification object];
	 etc.
	 */
}

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	[playView removeFromSuperview];
    /*     
	 < add your code here >
	 
	 MPMoviePlayerController* moviePlayerObj=[notification object];
	 etc.
	 */
}

//  Notification called when the movie scaling mode has changed.
- (void) movieScalingModeDidChange:(NSNotification*)notification
{
    /* 
	 < add your code here >
	 
	 MPMoviePlayerController* moviePlayerObj=[notification object];
	 etc.
	 */
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

- (void)showPlayView
{
    if (playView == nil)
    {
        playView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        playView.opaque = NO;
        playView.backgroundColor = [UIColor blackColor];
        playView.alpha = 1.0;
		NSLog(@"showPlayView");
        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(142.0, 222.0, 37.0, 37.0)];
        [spinningWheel startAnimating];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [playView addSubview:spinningWheel];
        [spinningWheel release];
    }
    
    [window addSubview:playView];
}

- (void)hidePlayView
{
    [playView removeFromSuperview];
}


- (void)dealloc {
	[controller release];
    [tabBarController release];
	[downloadQueue release];
    [window release];
	
	// remove all movie notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerContentPreloadDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerScalingModeDidChangeNotification
                                                  object:nil];
	// remove notification for touches to overlay view
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:OverlayViewTouchNotification
                                                  object:nil];
	[moviePlayer release]; 
	
    [super dealloc];
}

@end

