//
//  NSString+trim.m
//
//  Public Domain
//

#import "NSString+trim.h"

@implementation NSString (trim)

+ (NSString *)trim:(NSString *)original {
	NSMutableString * copy = [original mutableCopy];
	return [NSString stringWithString:[copy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

@end