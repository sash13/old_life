//
//  DwObjData.h
//  Southpark
//
//  Created by Sasha on 10/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DwObjData : NSObject {

	NSString *texts;
	NSDecimalNumber *sizes;
}

@property (nonatomic, copy) NSString *texts;
@property (nonatomic, copy) NSDecimalNumber *sizes;
@end
