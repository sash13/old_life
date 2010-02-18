//
//  FavView.h
//  BashComics
//
//  Created by Sasha on 2/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BashCellDelegate.h"

@class Bash;
@class ViewController;

@interface FavView : UIViewController <BashCellDelegate> {
	//NSMutableArray	*filteredListContent;
	BashComicsAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	ViewController *viewController;

}

//@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction)dismissAction:(id)sender;
-(void)loadContentForVisibleCells;

@end
