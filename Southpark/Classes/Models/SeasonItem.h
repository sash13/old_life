//
//  SeasonItem.h
//  Southpark
//
//  Created by Sasha on 9/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeasonItemDelegate.h"

@interface SeasonItem : NSObject 
{
@private
    NSString *title;
    NSString *link;
    NSString *summary;
    NSString *date;
   // NSString *imageURL;
   // NSString *thumbnailURL;
  //  UIImage *thumbnail;
	
    // Why NSObject instead of "id"? Because this way
    // we can ask if it "respondsToSelector:" before invoking
    // any delegate method...
    NSObject<SeasonItemDelegate> *delegate;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *date;
//@property (nonatomic, copy) NSString *imageURL;
//@property (nonatomic, copy) NSString *thumbnailURL;
//@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, assign) NSObject<SeasonItemDelegate> *delegate;

//- (BOOL)hasLoadedThumbnail;

@end
