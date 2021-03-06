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
@class Coffee;
@class DwObjData;
@class   HTTPServer;
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
	UIView *playView;
	NSMutableArray *coffeeArray;
	NSMutableArray *downloadArray;
	HTTPServer *httpServer;
	NSDictionary *addresses;
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

- (void)showPlayView;
- (void)hidePlayView;


@property (nonatomic, retain) NSMutableArray *coffeeArray;
@property (nonatomic, retain) NSMutableArray *downloadArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

- (void) removeCoffee:(Coffee *)coffeeObj;
- (void) addCoffee:(Coffee *)coffeeObj;

//- (void) removeDw:(DwObjData *)DwObj;
//- (void) addDw:(DwObjData *)DwObj;

- (NSString *)myIPAddress;
@end
