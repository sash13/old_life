//
//  RootViewController.h
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ParserDelegate.h"

@class Parser;
@class Bash;

@interface RootViewController : UITableViewController <ParserDelegate> 
{
@private
    Parser *pars;
	BashComicsAppDelegate *appDelegate;
}

@end
