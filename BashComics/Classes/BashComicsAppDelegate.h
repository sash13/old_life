//
//  BashComicsAppDelegate.h
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@class Bash;

@interface BashComicsAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSMutableArray *bashArray;
	UIView *View;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *bashArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
- (void)reload;

- (void) addBash:(Bash *)bashObj;

- (void)showView;
- (void)hideView;

@end

