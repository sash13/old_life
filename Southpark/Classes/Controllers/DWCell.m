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
#import "Coffee.h"
#import "SouthparkAppDelegate.h"
#import "DwObjData.h"
@implementation DWCell

//@synthesize link;
//@synthesize label;
//@synthesize button;
@synthesize myTimer;
@synthesize item;
//@synthesize sizes;
//@synthesize coffee;
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
//    }
//    return self;
//}

- (void)awakeFromNib
{
  //networkQueue = [[ASINetworkQueue alloc] init];
  //progressIndicator.progress = [progressIndicator progress];
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
    {
    networkQueue = [[ASINetworkQueue alloc] init];

    button = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 10.0, 24.0, 24.0)];
    [button setBackgroundImage:[UIImage imageNamed:@"StartDownload.png"] forState:UIControlStateNormal];
    //[button setTitle:@"D" forState:UIControlStateNormal]; 
    [self.contentView addSubview:button];
    
    
sizes = [[UILabel alloc] initWithFrame:CGRectMake(230.0, 10.0, 80.0, 10.0)];
sizes.font = [UIFont fontWithName:@"American Typewriter" size:12.0];
sizes.contentMode = UIViewContentModeScaleToFill;
[self.contentView addSubview:sizes];

label = [[UILabel alloc] initWithFrame:CGRectMake(40.0, 10.0, 100.0, 10.0)];
label.font = [UIFont fontWithName:@"American Typewriter" size:12.0];
label.contentMode = UIViewContentModeScaleToFill;
[self.contentView addSubview:label];

link = [[UILabel alloc] initWithFrame:CGRectMake(153.0, 30.0, 120.0, 10.0)];
link.font = [UIFont fontWithName:@"American Typewriter" size:12.0];
link.contentMode = UIViewContentModeScaleToFill;
[self.contentView addSubview:link];
    
    progressIndicator     = [[[UIProgressView alloc] initWithFrame:CGRectMake(40.0, 10.0, 180.0, 20.0)] autorelease];
    [self.contentView addSubview:progressIndicator];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}


- (IBAction)stop:(id)sender
{
  NSLog(@"stop");
  progressIndicator.progress = 0;
  [networkQueue cancelAllOperations];
}


- (IBAction)show:(id)sender {
  [button addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
  [button setBackgroundImage:[UIImage imageNamed:@"CancelDownload.png"] forState:UIControlStateNormal];

  //id appDelegate = [[UIApplication sharedApplication] delegate];
  //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:label.text  delegate:self cancelButtonTitle:@"button 1" otherButtonTitles: @"button", nil];
  //[alert show];
  //[alert release];
  //SouthparkAppDelegate *appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
  //DwObjData *DwObj = [[DwObjData alloc] init];  //Add the object
  //DwObj.texts = label.text;
  //NSDecimalNumber *myOtherDecimalObj = [[NSDecimalNumber alloc] initWithFloat:[progressIndicator progress]];
  //DwObj.sizes  = myOtherDecimalObj;
  //[appDelegate addDw:DwObj];
  //[DwObj release];
  
  [networkQueue cancelAllOperations];
  [networkQueue setDownloadProgressDelegate:progressIndicator];
  NSLog(@"Value: %f", [progressIndicator progress]);
  
  //[self performSelectorOnMainThread:@selector(updateProgressView) withObject:nil waitUntilDone:NO];
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
  //[request setTemporaryFileDownloadPath:[NSString stringWithFormat:@"/Users/sasha/S/%@.M4V.temp",label.text]];
  //[request setAllowResumeForFileDownloads:YES];
  [request setTemporaryFileDownloadPath:[NSString stringWithFormat:@"/Users/sasha/S/%@.M4V.temp" ,label.text]];
  [request setAllowResumeForFileDownloads:YES];
  [networkQueue addOperation:request];
  
  [networkQueue go];
  

  myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];

  //[appDelegate performSelector:@selector(showHeaderForClassName:) withObject:label.text]; 
}


- (void)requestDone:(ASIHTTPRequest *)request
{
  
[myTimer invalidate]; myTimer = nil;  //NSString *response = [request responseString];
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
  progressIndicator.progress = [progressIndicator progress];

//NSLog(@"one sec %f", [progressIndicator progress]);
  //SouthparkAppDelegate *appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
  
  //Create a Coffee Object.
  //Coffee *coffeeObj = [[Coffee alloc] initWithPrimaryKey:0];
  //NSDecimalNumber *ttt = [progressIndicator progress];
  //SouthparkAppDelegate *appDelegate = (SouthparkAppDelegate *)[[UIApplication sharedApplication] delegate];
  //DwObjData *DwObj = [[DwObjData alloc] init];  //Add the object
  //NSDecimalNumber *myOtherDecimalObj = [[NSDecimalNumber alloc] initWithFloat:[progressIndicator progress]];
  //DwObj.sizes  = myOtherDecimalObj;
  //[appDelegate addDw:DwObj];
  
  NSLog(@"info %f", [progressIndicator progress]);
  //NSDecimalNumber *myOtherDecimalObj = [[NSDecimalNumber alloc] initWithFloat:[progressIndicator progress]];
  //[coffee updateCcc:myOtherDecimalObj];


  
}

-(void) updateProgressView {
  //if (bookLen > 0) 
    progressIndicator.progress = [progressIndicator progress];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}


- (void)dealloc {
  [link release];
  [sizes release];
  [label release];
  [progressIndicator release];
  [button release];
    [item release];
  [networkQueue release];
    [super dealloc];
}

- (void)setItem:(Coffee *)newItem
{
    if (newItem != item)
    {
       // item.delegate = nil;
        [item release];
        item = nil;
        
        item = [newItem retain];
        //[item setDelegate:self];
        
        if (item != nil)
        {
      
            label.text = item.coffeeName;
      link.text = item.Link;
      sizes.text = [item.Sizes stringValue];
      [button addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
      // NSLog(@"%@", item.thumbnailURL);
            // This is to avoid the item loading the image
            // when this setter is called; we only want that
            // to happen depending on the scrolling of the table
      // if ([item hasLoadedThumbnail])
      //  {
      //     photo.image = item.thumbnail;
      // }
      // else
      // {
      //  photo.image = nil;
      // }
        }
    }
}


@end
