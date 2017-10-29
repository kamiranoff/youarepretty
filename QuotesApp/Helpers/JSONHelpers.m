//
//  JSONHelpers.m
//  QuotesApp
//
//  Created by Kevin Amiranoff on 29/10/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "JSONHelpers.h"


@interface JSONHelpers()

@end

@implementation JSONHelpers

+ (NSArray *)JSONFromLanguagesFile
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"languages" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


@end
