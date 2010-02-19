//
//  FaviView.h
//  BashComics
//
//  Created by Sasha on 2/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BashCellDelegate.h"

@class Bash;
@class ViewController;

@interface FaviView : UITableViewController {
	
	BashComicsAppDelegate *appDelegate;
	ViewController *viewController;

}

-(void)loadContentForVisibleCells;
-(void)leaveEditMode;
-(void)enterEditMode;

@end
