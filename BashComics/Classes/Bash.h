//
//  Bash.h
//  testapp
//
//  Created by Sasha on 1/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "BashDelegate.h"

@interface Bash : NSObject {
	NSInteger bashID;
	NSString *bashLink;
	NSString *bashImgFull;
	NSString *bashTumb;
	NSString *bashDate;
	NSString *bashInfo;
	NSString *imgthis;
	NSString *isNew;
	BOOL isDirty;
	UIImage *thumbnail;
	BOOL isViewController;
	NSObject<BashDelegate> *delegate;

}
@property (nonatomic, readonly) NSInteger bashID;
@property (nonatomic, copy) NSString *bashLink;
@property (nonatomic, copy) NSString *bashImgFull;
@property (nonatomic, copy) NSString *bashTumb;
@property (nonatomic, copy) NSString *bashDate;
@property (nonatomic, copy) NSString *bashInfo;
@property (nonatomic, copy) NSString *imgthis;
@property (nonatomic, copy) NSString *isNew;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isViewController;

@property (nonatomic, assign) NSObject<BashDelegate> *delegate;

+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) getInitialFavToDisplay:(NSString *)dbPath;

+ (void) finalizeStatements;

- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) check;
- (void) addBash;
- (void) saveAllData;
- (void) viewControllerData;

- (BOOL)hasLoadedThumbnail;

@end
