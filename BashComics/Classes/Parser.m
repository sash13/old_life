//
//  Parser.m
//  BashComics
//
//  Created by Sasha on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Parser.h"
#import "ASIHTTPRequest.h"
#import "Bash.h"


@implementation Parser

@synthesize delegate;


-(void)myfu
{
	BashComicsAppDelegate *appDelegate = (BashComicsAppDelegate *)[[UIApplication sharedApplication] delegate];
	//Bash *bashObj = [[Bash alloc] initWithPrimaryKey:0];
	int manyyes = [appDelegate.bashArray count];
	//Bash *myObj;
	//if (manyyes) {
	//	myObj = [appDelegate.bashArray objectAtIndex:manyyes-1];
	//}
	int error = 0;
	
	Bash *myObj = [appDelegate.bashArray objectAtIndex:0];
	
	//Bash *myObjs = [appDelegate.bashArray objectAtIndex:manyyes];
	//Bash *bashObj = [appDelegate.bashArray objectAtIndex:1];
	//NSString *olele = [appDelegate.bashArray objectAtIndex:manyyes-1];
	//NSLog(@"Это %@", bashObj.bashDate);
	
	Bash *bashObj = [[Bash alloc] initWithPrimaryKey:0];
	int i = 2;
	int iss;
	NSString *myurl;
	TFHppleElement *imgfullE;
	TFHppleElement *dateE;
	TFHppleElement *tumbE;
	TFHppleElement *infoE;
	TFHppleElement *nextE;
    TFHppleElement *prevE;
	
	NSString *imgfullC; 
	NSString *dateC;
	NSString *tumbC;
	NSString *infoC;
	NSString *nextC;
	NSString *prevC;
	
	
	//myurl = @"http://bash.org.ru/comics/20100129";
	//if (myObj.bashLink) {
	myurl = [NSString stringWithFormat:@"%@", myObj.bashLink];
	//}
	//else {
	//myurl = @"http://bash.org.ru/comics/20070803";
	//}
	
	//NSLog(@"%@",myObj.bashLink);
	//NSMutableArray *myArray = [NSMutableArray array];
	
	while (i > 1) {
		
		/*[imgfullE release];
		 [dateE release];
		 [tumbE release];
		 [infoE release];
		 [nextE release];
		 [prevE release];*/
		
		/*[imgfullC release];
		 [dateC release];
		 [tumbC release];
		 [infoC release];
		 [nextC release];
		 [prevC release];*/
		
		//NSLog(@"%@",myurl);
		NSURL *url = [NSURL URLWithString:myurl];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request startSynchronous];
		NSError *error = [request error];
		if (!error) {
			NSData *data = [request responseData];
			//NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"index5.html"];
			//NSData *data = [[NSData alloc] initWithContentsOfFile:defaultDBPath];
			
			// Create parser
			xpathParser = [[TFHpple alloc] initWithHTMLData:data];
			//NSArray * elements = [xpathParser search:@"//div[@class='s']//h3"];
			//NSArray * elementsi = [xpathParser search:@"//div[@class='s']//h1"];
			NSArray * imgfull = [xpathParser search:@"//img[@id='cm_strip']/@src"];
			NSArray * date = [xpathParser search:@"//div[@id='cm_navi']//td[@class='active']"];
			NSArray * tumb = [xpathParser search:@"//div[@id='cm_navi']//td[@class='active']//img//@src"];
			NSArray * info = [xpathParser search:@"//div[@id='cm_boiler']//a"];
			
			NSArray * prev = [xpathParser search:@"//div[@id='cm_navi']//td[@class='navi']//a//@href"];
			//Get all the cells of the 2nd row of the 3rd table 
			//NSArray *elements  = [xpathParser search:@"//table[3]/tr[2]/td"];
			
			
			// Access the first cell
			//TFHppleElement *element = [elements objectAtIndex:1];
			imgfullE = [imgfull objectAtIndex:0];
			dateE = [date objectAtIndex:0];
			tumbE = [tumb objectAtIndex:0];
			infoE = [info objectAtIndex:0];
			//TFHppleElement *prevE = [prev objectAtIndex:2];
			//TFHppleElement *nextE = [prev objectAtIndex:0];
			iss = [prev count];
			//NSLog(@"%@", info);
			imgfullC = [imgfullE content];  
			dateC = [dateE content]; 
			tumbC = [tumbE content]; 
			infoC = [infoE content];
			NSArray *listItems = [infoC componentsSeparatedByString:@" "];
			infoC = [listItems lastObject];
			
			
			
			if (iss > 3) {
				nextE = [prev objectAtIndex:4];
				nextC = [nextE content];
				prevE = [prev objectAtIndex:3];
				prevC = [prevE content]; 
				
				//const char* cString = [infoC cStringUsingEncoding:NSUTF8StringEncoding]; 
				//NSString *infoCn = [[NSString alloc] initWithBytes:cString
				//				 length:strlen(cString)
				//	   encoding:NSUTF8StringEncoding];
				//NSString *infoCn = [infoC UTF8String];
				//NSLog(@"%@",myurl);
				//NSLog(@"%i yes", iss);
				
				//////////////////////////////////////////////////////////////////////////////
				//Bash *bashObj = [[Bash alloc] initWithPrimaryKey:0];
				if ([dateC isEqualToString:myObj.bashDate]) {
					NSLog(@"ends");
				}
				
				else {
					NSLog(@"%@ %@",dateC, myObj.bashDate);
				bashObj.bashLink = myurl;
				bashObj.bashImgFull = imgfullC;
				bashObj.bashTumb = tumbC;
				bashObj.bashDate = dateC;
				bashObj.bashInfo = infoC;
				
				[appDelegate addBash:bashObj];
				}
				//////////////////////////////////////////////////////////////////////////////
				myurl = [NSString stringWithFormat:@"http://bash.org.ru%@",nextC];
				
				NSLog(@"imgfull:%@ date:%@  tumb: %@ prev: %@ next: %@_%@",imgfullC,dateC,tumbC,prevC,nextC,infoC);
				
			}
			else {
				
				
				
				// infoC = [[NSString alloc] initWithBytes:file
				//								 length:strlen(file)
				//							   encoding:NSUTF8StringEncoding];
				
				nextE = [prev objectAtIndex:2];
				prevE = [prev objectAtIndex:2];
				nextC = [nextE content];
				prevC = [prevE content]; 
				
				//NSLog(@"%@ no %@ %@ %@ %@ %@", nextC,imgfullC,dateC,tumbC,infoC,prevC);
				//NSLog(@"imgfull:%@ date:%@  tumb: %@ prev: %@ next: %@  %@",imgfullC,dateC,tumbC,prevC,nextC,infoC);
				
				//////////////////////////////////////////////////////////////////////////////
				//Bash *bashObj = [[Bash alloc] initWithPrimaryKey:0];
				if ([dateC isEqualToString:myObj.bashDate]) {
					NSLog(@"ends");
				}
				
				else {
					NSLog(@"%@ %@",dateC, myObj.bashDate);
					bashObj.bashLink = myurl;
					bashObj.bashImgFull = imgfullC;
					bashObj.bashTumb = tumbC;
					bashObj.bashDate = dateC;
					//bashObj.bashInfo = [NSString stringWithCString:infoC encoding:NSWindowsCP1251StringEncoding];
					//bashObj.bashInfo = [NSString initWithBytes:infoC length:strlen(infoC) encoding:NSWindowsCP1251StringEncoding];
					//bashObj.bashInfo = [[[NSString alloc] initWithBytes:[infoC bytes] length:[infoC length] 
					//						encoding:NSUTF8StringEncoding] autorelease];
					bashObj.bashInfo = infoC;
					[appDelegate addBash:bashObj];
					NSLog(@"imgfull:%@ date:%@  tumb: %@ prev: %@ next: %@  %@",imgfullC,dateC,tumbC,prevC,nextC,infoC);
				}
				//NSLog(@"imgfull:%@ date:%@  tumb: %@ prev: %@ next: %@  %@",imgfullC,dateC,tumbC,prevC,nextC,infoC);
				
				
				//////////////////////////////////////////////////////////////////////////////
				[appDelegate reload];
				if (nextC == prevC) {
					NSLog(@"end");
					i--;
					
				}else {
					NSLog(@"next");
				}
				
				
			}
			
			
			
			/* if ([prev objectAtIndex:3]) {
			 TFHppleElement *nextE = [prev objectAtIndex:3];
			 }
			 else {
			 TFHppleElement *nextE = [prev objectAtIndex:0];
			 }*/
			
			
			
			// Get the text within the cell tag
			
			
			
			/*
			 NSArray *words = [content componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			 NSEnumerator *en = [words objectEnumerator];
			 NSString *word;
			 NSMutableArray *ssl = [[NSMutableArray alloc] initWithCapacity:1];
			 while(word = [en nextObject])
			 {
			 if([word hasPrefix:@"http://"])
			 {
			 NSLog(@"%@",word);
			 [ssl addObject:word];
			 
			 }
			 
			 }
			 
			 NSString *match = [ssl objectAtIndex:0];
			 */
			//NSLog(@"imgfull:%@ date:%@  tumb: %@ prev: %@ next: %@",imgfullC,dateC,tumbC,prevC,nextC);
			[data release];
			//[date release];
			//[imgfull release];
			//[tumb release];
			//[info release];
			//[prev release];
			
			
		}
		else {
			NSLog(@"error");
			++error;
		}
		//NSLog(@"%@",myurl);
	}
	NSLog(@"error2");
	manyyes = [appDelegate.bashArray count];
	
	NSLog(@"%i",manyyes);
	if (error > 0) {
		[delegate update:self myError:@"error"];
	}else {
		[delegate update:self successfully:@"Ok"];
	}

}

- (void)dealloc {
	[xpathParser release];
    [super dealloc];
}

@end
