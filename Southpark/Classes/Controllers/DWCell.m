//
//  DWCell.m
//  Southpark
//
//  Created by Sasha on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DWCell.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@implementation DWCell

@synthesize link;
@synthesize label;
@synthesize button;
@synthesize myTimer;
@synthesize sizes;
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
//    }
//    return self;
//}

- (void)awakeFromNib
{
	networkQueue = [[ASINetworkQueue alloc] init];
}

- (IBAction)show:(id)sender {
	id appDelegate = [[UIApplication sharedApplication] delegate];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:label.text  delegate:self cancelButtonTitle:@"button 1" otherButtonTitles: @"button", nil];
	[alert show];
	[alert release];
	
	
	[networkQueue cancelAllOperations];
	[networkQueue setDownloadProgressDelegate:progressIndicator];
	NSLog(@"Value: %f", [progressIndicator progress]);
	

	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setShowAccurateProgress:YES];
	[networkQueue setDelegate:self];
	
	/*if (![self queue]) {
		[self setQueue:[[[NSOperationQueue alloc] init] autorelease]];
	}
	
	NSURL *url = [NSURL URLWithString:link.text];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	[[self queue] addOperation:request]; //queue is an NSOperationQueue
	*/
	
	ASIHTTPRequest *request;
	request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:link.text]] autorelease];
	//NSString *patch = [NSString stringWithFormat:@"/Users/sasha/S/%@.M4V" ,label.text];
	[request setDownloadDestinationPath:[NSString stringWithFormat:@"/Users/sasha/S/%@.M4V" ,label.text]];
	//[request setTemporaryFileDownloadPath:[NSString stringWithFormat:@"/Users/sasha/S/%@.M4V.temp" ,label.text]];
	//[request setAllowResumeForFileDownloads:YES];
	[networkQueue addOperation:request];
	
	[networkQueue go];
	

	myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];

	//[appDelegate performSelector:@selector(showHeaderForClassName:) withObject:label.text];	
}


- (void)requestDone:(ASIHTTPRequest *)request
{
	
[myTimer invalidate]; myTimer = nil;	//NSString *response = [request responseString];
	NSData *response = [request responseData];
	NSLog(@"ok");
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
	[myTimer invalidate]; 
	myTimer = nil;
	NSError *error = [request error];
	NSLog(@"bad %@", error);
}

	
- (void)onTimer:(NSTimer *)timer {
NSLog(@"one sec %f", [progressIndicator progress]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}


- (void)dealloc {
	[networkQueue release];
    [super dealloc];
}


@end
