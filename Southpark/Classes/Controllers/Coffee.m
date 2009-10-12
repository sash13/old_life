//
//  Coffee.m
//  SQL
//
//  Created by iPhone SDK Articles on 10/26/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "Coffee.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;

@implementation Coffee

@synthesize coffeeID, coffeeName, isDirty, isDetailViewHydrated, Link, Sizes;
//@synthesize Did, Nname, link, isDirty, isDetailViewHydrated;
+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	//SouthparkAppDelegate *appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
	SouthparkAppDelegate *appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select coffeeID, coffeeName, Link, Sizes from coffee";
		//const char *sql = "select Did, name from dwas";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				Coffee *coffeeObj = [[Coffee alloc] initWithPrimaryKey:primaryKey];
				coffeeObj.coffeeName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				//coffeeObj.Nname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				coffeeObj.Link = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				//coffeeObj.Sizes = sqlite3_column_double(selectstmt, 3);
				coffeeObj.Sizes =  [NSDecimalNumber numberWithDouble:sqlite3_column_double(selectstmt, 3)];
				//coffeeObj.Sizes = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				coffeeObj.isDirty = NO;
				//NSLog(@"%@",coffeeObj.Nname);
				[appDelegate.coffeeArray addObject:coffeeObj];
				[coffeeObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
	if(deleteStmt) sqlite3_finalize(deleteStmt);
	if(addStmt) sqlite3_finalize(addStmt);
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	
	[super init];
	coffeeID = pk;
	//Did = pk;
	//NSLog(@"%@",Did);
	isDetailViewHydrated = NO;
	
	return self;
}

/*- (void) deleteCoffee {
	
	if(deleteStmt == nil) {
		//const char *sql = "delete from Coffee where coffeeID = ?";
		const char *sql = "delete from Dwas where Did = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1, Did);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) 
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);
}

- (void) addCoffee {
	
	if(addStmt == nil) {
		//const char *sql = "insert into Coffee(CoffeeName, Price) Values(?, ?)";
		const char *sql = "insert into Dwas(Nname, link) Values(?, ?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	//sqlite3_bind_text(addStmt, 1, [coffeeName UTF8String], -1, SQLITE_TRANSIENT);
	//sqlite3_bind_double(addStmt, 2, [price doubleValue]);
	
	sqlite3_bind_text(addStmt, 1, [Nname UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 2, [link UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		//coffeeID = sqlite3_last_insert_rowid(database);
		Did = sqlite3_last_insert_rowid(database);
	
	//Reset the add statement.
	sqlite3_reset(addStmt);
}

/*- (void) hydrateDetailViewData {
	
	//If the detail view is hydrated then do not get it from the database.
	if(isDetailViewHydrated) return;
	
	if(detailStmt == nil) {
		const char *sql = "Select price from Coffee Where CoffeeID = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_int(detailStmt, 1, coffeeID);
	
	if(SQLITE_DONE != sqlite3_step(detailStmt)) {
		
		//Get the price in a temporary variable.
		NSDecimalNumber *priceDN = [[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(detailStmt, 0)];
		
		//Assign the price. The price value will be copied, since the property is declared with "copy" attribute.
		self.price = priceDN;
		
		//Release the temporary variable. Since we created it using alloc, we have own it.
		[priceDN release];
	}
	else
		NSAssert1(0, @"Error while getting the price of coffee. '%s'", sqlite3_errmsg(database));
	
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;
}

- (void) dealloc {
	
	//[price release];
	//[coffeeName release];
	[link release];
	[Nname release];
	[super dealloc];
}
*/

- (void) deleteCoffee {
	
	if(deleteStmt == nil) {
		const char *sql = "delete from Coffee where coffeeID = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1, coffeeID);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) 
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);
}

- (void) addCoffee {
	
	if(addStmt == nil) {
		const char *sql = "insert into Coffee(CoffeeName, Link, Sizes) Values(?, ?, ?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	//sqlite3_bind_text(addStmt, 3, [Sizes UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [Link UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 1, [coffeeName UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_double(addStmt, 3, [Sizes doubleValue]);
	//sqlite3_bind_double(addStmt, 2, [price doubleValue]);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		coffeeID = sqlite3_last_insert_rowid(database);
	
	//Reset the add statement.
	sqlite3_reset(addStmt);
}

/*- (void) hydrateDetailViewData {
	
	//If the detail view is hydrated then do not get it from the database.
	if(isDetailViewHydrated) return;
	
	if(detailStmt == nil) {
		const char *sql = "Select price from Coffee Where CoffeeID = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_int(detailStmt, 1, coffeeID);
	
	if(SQLITE_DONE != sqlite3_step(detailStmt)) {
		
		//Get the price in a temporary variable.
		NSDecimalNumber *priceDN = [[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(detailStmt, 0)];
		
		//Assign the price. The price value will be copied, since the property is declared with "copy" attribute.
		self.price = priceDN;
		
		//Release the temporary variable. Since we created it using alloc, we have own it.
		[priceDN release];
	}
	else
		NSAssert1(0, @"Error while getting the price of coffee. '%s'", sqlite3_errmsg(database));
	
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;
}
*/
- (void) dealloc {
	[Sizes release];
	[Link release];
	[coffeeName release];
	[super dealloc];
}

@end
