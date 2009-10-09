//
//  DWCell.h
//  Southpark
//
//  Created by Sasha on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASINetworkQueue;

@interface DWCell : UITableViewCell {
	IBOutlet UILabel *label;
	IBOutlet UILabel *link;
	IBOutlet UIButton *button;
	IBOutlet UIProgressView *progressIndicator;
	ASINetworkQueue *networkQueue;
}

@property (nonatomic, assign) IBOutlet UILabel *label;
@property (nonatomic, assign) IBOutlet UILabel *link;
@property (nonatomic, assign) IBOutlet UIButton *button;

- (IBAction)show:(id)sender;

@end
