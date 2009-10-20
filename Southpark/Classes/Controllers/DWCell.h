//
//  DWCell.h
//  Southpark
//
//  Created by Sasha on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SouthparkAppDelegate.h"
#import "Coffee.h"

@class ASINetworkQueue;
@class Coffee;

@interface DWCell : UITableViewCell {
	@private
	//IBOutlet UILabel *label;
	//IBOutlet UILabel *link;
	//IBOutlet UILabel *sizes;
	//IBOutlet UIButton *button;
	//IBOutlet UIProgressView *progressIndicator;
	UILabel *label;
	UILabel *link;
	UILabel *sizes;
	UIButton *button;
	UIProgressView *progressIndicator;
	ASINetworkQueue *networkQueue;
	NSTimer * myTimer;
	Coffee *item;
	//Coffee *coffee;
}

//@property (nonatomic, assign) UILabel *label;
//@property (nonatomic, assign) UILabel *link;
//@property (nonatomic, assign) UILabel *sizes;
//@property (nonatomic, assign) UIButton *button;
@property (nonatomic, retain) NSTimer * myTimer;
@property(nonatomic,retain) Coffee *item;
- (IBAction)stop:(id)sender;
- (IBAction)show:(id)sender;
//-(void)myMethod:(NSTimer*)timer;
@end
