//
//  RootViewController.h
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ParserDelegate.h"
#import "BashCellDelegate.h"
#import "FavView.h"

@class Parser;
@class Bash;
@class ViewController;

@interface RootViewController : UITableViewController <ParserDelegate, BashCellDelegate> 
{
@private
    Parser *pars;
	BashComicsAppDelegate *appDelegate;
	ViewController *viewController;
	FavView *favView;
	UIToolbar				*toolbar;
}

@property (nonatomic, retain) FavView*  favView;
@property (nonatomic, retain) UIToolbar	*toolbar;
@end
