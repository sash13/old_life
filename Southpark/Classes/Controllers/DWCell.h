//
//  DWCell.h
//  Southpark
//
//  Created by Sasha on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SouthparkAppDelegate.h"

@class ASINetworkQueue;
@class DwObjData;

@interface DWCell : UITableViewCell {
	IBOutlet UILabel *label;
	IBOutlet UILabel *link;
	IBOutlet UILabel *sizes;
	IBOutlet UIButton *button;
	IBOutlet UIProgressView *progressIndicator;
	ASINetworkQueue *networkQueue;
	NSTimer * myTimer;
	//Coffee *coffee;
}

@property (nonatomic, assign) IBOutlet UILabel *label;
@property (nonatomic, assign) IBOutlet UILabel *link;
@property (nonatomic, assign) IBOutlet UILabel *sizes;
@property (nonatomic, assign) IBOutlet UIButton *button;
@property (nonatomic, retain) NSTimer * myTimer;
//@property(nonatomic,retain) Coffee *coffee;

- (IBAction)show:(id)sender;
//-(void)myMethod:(NSTimer*)timer;
@end
