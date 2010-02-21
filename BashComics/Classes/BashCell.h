//
//  BashCell.h
//  BashComics
//
//  Created by Sasha on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BashCellDelegate.h"
#import "BashDelegate.h"

@class Bash;

@interface BashCell : UITableViewCell <BashDelegate> 
{
@private
	UILabel *textLabel;
	UILabel *dateLabel;
	//UILabel *isNewLabel;
	UIImageView *photo;
	UIActivityIndicatorView *scrollingWheel;
	Bash *item;
	NSObject<BashCellDelegate> *delegate;

}

@property (nonatomic, retain) Bash *item;
@property (nonatomic, assign) NSObject<BashCellDelegate> *delegate;

- (void)loadImage;

@end
