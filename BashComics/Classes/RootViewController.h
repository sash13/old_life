//
//  RootViewController.h
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ParserDelegate.h"
#import "BashCellDelegate.h"
#import "FaviView.h"

@class Parser;
@class Bash;
@class ViewController;

@interface RootViewController : UITableViewController <ParserDelegate, BashCellDelegate> 
{
@private
    Parser *pars;
	BashComicsAppDelegate *appDelegate;
	ViewController *viewController;
	FaviView *faviView;
	//UIToolbar				*toolbar;
}

@property (nonatomic, retain) FaviView*  faviView;
//@property (nonatomic, retain) UIToolbar	*toolbar;
@end
