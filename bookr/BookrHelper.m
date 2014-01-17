//
//  BookrHelper.m
//  bookr
//
//  Created by Steve Maahs on 17.01.14.
//  Copyright (c) 2014 WSM. All rights reserved.
//

#import "BookrHelper.h"

#import "Author.h"

@implementation BookrHelper

+(NSString *)generateStringForAuthors:(NSSet *)authors
{
    NSMutableString * contentString = [NSMutableString string];
    
    if ([[authors anyObject] isKindOfClass:[Author class]]) {
        for (Author *author in authors) {
            [contentString appendFormat:@"%@, ",author.name];
        }
        [contentString deleteCharactersInRange:(NSRange){contentString.length-2,2}];
    } else {
        
    }
    return contentString;
    
}

@end
