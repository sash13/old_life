//
//  BashComicsAppDelegate.m
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BashComicsAppDelegate.h"
#import "RootViewController.h"
#import "Bash.h"
#import "Client.h"

@implementation BashComicsAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize bashArray;
@synthesize favArray;
@synthesize downloadQueue;

@synthesize twitArray;

+ (BashComicsAppDelegate *)sharedAppDelegate
{
    return (BashComicsAppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	[self copyDatabaseIfNeeded];
	[self createIfNo];
	[self createTumbIfNo];
	
	downloadQueue = [[NSOperationQueue alloc] init];
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.bashArray = tempArray;
	[tempArray release];
	
	
	NSMutableArray *tempArrays = [[NSMutableArray alloc] init];
	self.favArray = tempArrays;
	[tempArrays release];
	
	NSMutableArray *tempArraysi = [[NSMutableArray alloc] init];
	self.twitArray = tempArraysi;
	[tempArraysi release];
	
	[Bash getInitialDataToDisplay:[self getDBPath]];
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	
	[self addToTwitList];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
	[self.bashArray makeObjectsPerformSelector:@selector(saveAllData)];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[self.bashArray makeObjectsPerformSelector:@selector(saveAllData)];
	
	[Bash finalizeStatements];
}

- (void)reload
{
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.bashArray = tempArray;
	[Bash getInitialDataToDisplay:[self getDBPath]];
	
}

-(void)createIfNo {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [self getFile];
	if (![fileManager fileExistsAtPath:path])
		[fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

-(void)createTumbIfNo {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [self getFileTumb];
	if (![fileManager fileExistsAtPath:path])
		[fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	NSLog(@"%@", dbPath);
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Bash.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}	
}

- (NSString *) getDBPath {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"Bash.sqlite"];
}

- (NSString *) getFile {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"files"];
}

- (NSString *) getFileTumb {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"tumb"];
}

- (void) addBash:(Bash *)bashObj {
	
	[bashObj addBash];
	
	
	[bashArray addObject:bashObj];
}

- (void)showView
{
    if (View == nil)
    {
        View = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        View.opaque = NO;
        View.backgroundColor = [UIColor darkGrayColor];
        View.alpha = 0.5;
		
        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(142.0, 222.0, 37.0, 37.0)];
        [spinningWheel startAnimating];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [View addSubview:spinningWheel];
        [spinningWheel release];
    }
    
    [window addSubview:View];
}

- (BOOL)isAvailable:(NSString *)urls
{

    NSString *stringURL = [NSString stringWithFormat:urls, @"test"];
    NSURL *url = [NSURL URLWithString:stringURL];
    return [[UIApplication sharedApplication] canOpenURL:url];
}

-(void)addToTwitList {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"TwitterClients" ofType:@"plist"];
    NSArray *clients = [NSArray arrayWithContentsOfFile:path];
	//NSString *name;
	//NSString *template;
	for (NSDictionary *dict in clients)
    {
       // name = [dict objectForKey:@"name"];
		//template = [dict objectForKey:@"template"];
		//cliObj.names = name;
		//cliObj.url = template;
		Client *cliObj = [[Client alloc]  initWithPrimaryKey:0];
		cliObj.names = [dict objectForKey:@"name"];
		cliObj.url = [dict objectForKey:@"template"];
		
		if ([self isAvailable:cliObj.url]) {
			NSLog(@"%@", cliObj.names);
			[twitArray addObject:cliObj];
			
		}



    }
	NSLog(@"%d", [twitArray count]);
}

- (void)hideView
{
    [View removeFromSuperview];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[twitArray release];
	[downloadQueue release];
	[bashArray release];
	[favArray release];
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

