//
//  Bash.m
//  testapp
//
//  Created by Sasha on 1/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bash.h"
#import "ASIHTTPRequest.h"

static sqlite3 *database = nil;
static sqlite3_stmt *check = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *updateStmt = nil;
static sqlite3_stmt *detailStmt = nil;

@interface Bash (Private)
- (void)loadURL:(NSURL *)url;
@end


@implementation Bash

@synthesize bashID, bashInfo, bashDate, bashLink, bashImgFull, bashTumb, isDirty, imgthis, isViewController;
@synthesize thumbnail;
@synthesize delegate;


+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	BashComicsAppDelegate *appDelegate = (BashComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSLog(@"add");
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select bashID, bashdate, bashinfo, bashlink, bashtumb, bashimgfull from bash ORDER BY bashID DESC";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Bash *bashObj = [[Bash alloc] initWithPrimaryKey:primaryKey];
				//bashObj.bashImgFull = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				bashObj.bashImgFull = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				bashObj.bashTumb = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				bashObj.bashLink = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				bashObj.bashInfo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				bashObj.bashDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				
				bashObj.isDirty = NO;
				NSLog(@"add");
				[appDelegate.bashArray addObject:bashObj];
				[bashObj release];
			}
		}
	}
	else
		sqlite3_close(database); 
}

/*+ (void) getInitialFavToDisplay:(NSString *)dbPath {
	
	BashComicsAppDelegate *appDelegate = (BashComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSLog(@"add");
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select bashID, bashdate, bashinfo, bashlink, bashtumb, bashimgfull from bash  Where fav = 'yes' ORDER BY bashID DESC";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Bash *bashObj = [[Bash alloc] initWithPrimaryKey:primaryKey];
				//bashObj.bashImgFull = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				bashObj.bashImgFull = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				bashObj.bashTumb = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				bashObj.bashLink = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				bashObj.bashInfo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				bashObj.bashDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				
				bashObj.isDirty = NO;
				//NSLog(@"add");
				[appDelegate.bashArray addObject:bashObj];
				[bashObj release];
			}
		}
	}
	else
		sqlite3_close(database); 
}
*/

+ (void) finalizeStatements {
	
	if (database) sqlite3_close(database);
	if (check) sqlite3_finalize(check);
	if (addStmt) sqlite3_finalize(addStmt);
	if (updateStmt) sqlite3_finalize(updateStmt);
	if (detailStmt) sqlite3_finalize(detailStmt);
}



- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	bashID = pk;
	
	isViewController = NO;
	return self;
}

- (void) check {
	
	
	
	if(check == nil) {
		const char *sql = "Select bashImgFull from Bash Where bashID = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &check, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	
	//sqlite3_bind_int(detailStmt, 1, coffeeID);
	sqlite3_bind_text(check, 1, [bashImgFull UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(check)) {
		
		//Get the price in a temporary variable.
		//NSDecimalNumber *priceDN = [[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(check, 0)];
		NSString *imgThis = [NSString stringWithUTF8String:(char *)sqlite3_column_text(check, 0)];
		//Assign the price. The price value will be copied, since the property is declared with "copy" attribute.
		self.imgthis = imgThis;
		
		//Release the temporary variable. Since we created it using alloc, we have own it.
		[imgThis release];
	}
	else
		NSAssert1(0, @"Error while getting the price of coffee. '%s'", sqlite3_errmsg(database));
	
	//Reset the detail statement.
	sqlite3_reset(check);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
}



- (void) addBash {
	
	//NSLog(@"%@", bashInfo);
	if(addStmt == nil) {
		const char *sql = "insert into Bash(bashInfo, bashDate, bashLink, bashImgFull, bashTumb) Values(?, ?, ?, ?, ?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_text(addStmt, 1, [bashInfo UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [bashDate UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 3, [bashLink UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 4, [bashImgFull UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 5, [bashTumb UTF8String], -1, SQLITE_TRANSIENT);
	
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		bashID = sqlite3_last_insert_rowid(database);
	
	//Reset the add statement.
	sqlite3_reset(addStmt);
}


-(void)viewControllerData
{
	//If the detail view is hydrated then do not get it from the database.
	if(isViewController) return;
	
	if(detailStmt == nil) {
		const char *sql = "Select bashImgFull from Bash Where BashID = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_int(detailStmt, 1, bashID);
	
	if(SQLITE_DONE != sqlite3_step(detailStmt)) {
		
           self.bashImgFull = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 5)];
	}
	else
		NSAssert1(0, @"Error while getting the price of coffee. '%s'", sqlite3_errmsg(database));
	
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isViewController = YES;
	
}
/*
 - (void) deleteCoffee {
 
 if(deleteStmt == nil) {
 const char *sql = "delete from Bash where bashID = ?";
 if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
 NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
 }
 
 //When binding parameters, index starts from 1 and not zero.
 sqlite3_bind_int(deleteStmt, 1, bashID);
 
 if (SQLITE_DONE != sqlite3_step(deleteStmt)) 
 NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
 
 sqlite3_reset(deleteStmt);
 }*/


- (void) saveAllData {
	
	if(isDirty) {
		
		if(updateStmt == nil) {
			const char *sql = "update Bash Set bashInfo = ?, bashDate = ?, bashLink = ?, bashImgFull = ?,bashTumb = ?, Where bashID = ?";
			if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK) 
				NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}
		
		//sqlite3_bind_text(updateStmt, 1, [coffeeName UTF8String], -1, SQLITE_TRANSIENT);
		//sqlite3_bind_double(updateStmt, 2, [price doubleValue]);
		
		sqlite3_bind_text(updateStmt, 1, [bashInfo UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(updateStmt, 2, [bashDate UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(updateStmt, 3, [bashLink UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(updateStmt, 4, [bashImgFull UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(updateStmt, 5, [bashTumb UTF8String], -1, SQLITE_TRANSIENT);
		
		
		sqlite3_bind_int(updateStmt, 6, bashID);
		
		if(SQLITE_DONE != sqlite3_step(updateStmt))
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		
		sqlite3_reset(updateStmt);
		
		isDirty = NO;
	}
	
	//Reclaim all memory here.
	[bashInfo release];
	bashInfo = nil;
	[bashDate release];
	bashDate = nil;
	[bashLink release];
	bashLink = nil;
	[bashImgFull release];
	bashImgFull = nil;
	[bashTumb release];
	bashTumb = nil;
	[imgthis release];
	imgthis = nil;
	[thumbnail release];
	thumbnail = nil;
	
	isViewController = NO;

}

#pragma mark -
#pragma mark Public methods

- (BOOL)hasLoadedThumbnail
{
    return (thumbnail != nil);
}

#pragma mark -
#pragma mark Overridden setters

- (UIImage *)thumbnail
{
    if (thumbnail == nil)
    {
		//NSLog(@"%@", self.bashTumb);
        NSURL *url = [NSURL URLWithString:self.bashTumb];
		//NSLog(@"%@",url);
	    [self loadURL:url];
    }
    return thumbnail;
}

- (NSString *) yesOrNo:(NSString *)string {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	//documentsDir = [documentsDir stringByAppendingPathComponent:@"tumb/"];
	NSString *newDocumentsDir = [documentsDir stringByAppendingPathComponent:@"tumb/"];

	return [newDocumentsDir stringByAppendingPathComponent:string];
}

/*- (NSString *) docDirs {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];

	return documentsDir;
}
*/

#pragma mark -
#pragma mark ASIHTTPRequest delegate methods

- (void)requestDone:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
    UIImage *remoteImage = [[UIImage alloc] initWithData:data];
    self.thumbnail = remoteImage;
    if ([delegate respondsToSelector:@selector(bash:didLoadThumbnail:)])
    {
        [delegate bash:self didLoadThumbnail:self.thumbnail];
    }
    [remoteImage release];
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if ([delegate respondsToSelector:@selector(bash:couldNotLoadImageError:)])
    {
        [delegate bash:self couldNotLoadImageError:error];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)loadURL:(NSURL *)url
{
	NSArray *listItems = [self.bashTumb componentsSeparatedByString:@"/"];
	NSString *MybashTumb = [listItems lastObject];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
	NSString *dbPath = [self yesOrNo:MybashTumb];
	//NSString *docDir = [self docDirs];
	
	//NSLog(@"%@", dbPath);
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	if(!success) {
		
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
	[request setDownloadDestinationPath:dbPath];
    NSOperationQueue *queue = [BashComicsAppDelegate sharedAppDelegate].downloadQueue;
    [queue addOperation:request];
    [request release];  
	}
	else {
		//NSLog(@"%@", dbPath);
		UIImage *remoteImage = [[UIImage alloc] initWithContentsOfFile:dbPath];
		self.thumbnail = remoteImage;
		if ([delegate respondsToSelector:@selector(bash:didLoadThumbnail:)])
		{
			[delegate bash:self didLoadThumbnail:self.thumbnail];
		}
		[remoteImage release];
	}

}



- (void) dealloc {
	delegate = nil;
	[thumbnail release];
	[bashInfo release];
	[imgthis release];
	[bashDate release];
	[bashLink release];
	[bashImgFull release];
	[bashTumb release];
	[super dealloc];
}

@end
