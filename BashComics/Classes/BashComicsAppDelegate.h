//
//  BashComicsAppDelegate.h
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@class Bash;
@class Client;

@interface BashComicsAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSMutableArray *bashArray;
	NSMutableArray *favArray;
	NSMutableArray *twitArray;
	UIView *View;
	NSOperationQueue *downloadQueue;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *bashArray;
@property (nonatomic, retain) NSMutableArray *favArray;
@property (nonatomic, retain) NSMutableArray *twitArray;

@property (nonatomic, retain) NSOperationQueue *downloadQueue;

+ (BashComicsAppDelegate *)sharedAppDelegate;

- (void) copyDatabaseIfNeeded;
- (void) addToTwitList;
- (BOOL)isAvailable:(NSString *)urls;

- (NSString *) getDBPath;

- (void) createIfNo;
- (NSString *) getFile;

- (void) createTumbIfNo;
- (NSString *) getFileTumb;

- (void)reload;

- (void) addBash:(Bash *)bashObj;

- (void)showView;
- (void)hideView;

@end

