//
//  bookrHelperTests.m
//  bookr
//
//  Created by Steve Maahs on 17.01.14.
//  Copyright (c) 2014 WSM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>

#import "BookrHelper.h"

#import "Author.h"

@interface bookrHelperTests : XCTestCase
{
    NSManagedObjectContext *moContext;
    
    NSSet *authors;
    
    Author *author;
    Author *author1;
}
@end

@implementation bookrHelperTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    
    moContext = [[NSManagedObjectContext alloc] init];
    
    NSPersistentStoreCoordinator *persistantStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Book" withExtension:@"momd"]]];
    [moContext setPersistentStoreCoordinator:persistantStoreCoordinator];
    
    author = [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:moContext];
    author1 = [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:moContext];
    
    [author setName:@"author"];
    [author1 setName:@"author1"];
    
    authors = [NSSet setWithObjects:author,author1, nil];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testGenerateAuthorsString
{
   
    NSString *testString1 =[BookrHelper generateStringForAuthors:[NSSet setWithObject:author]];
    NSString *testString2 = [BookrHelper generateStringForAuthors:authors];
    
    if (![testString1 isEqualToString:@"author"]) {
        XCTFail(@"Generate Authors fails with one Author! >%@<",testString1);
    }
    
    if (!([testString2 isEqualToString:@"author, author1"] || [testString2 isEqualToString:@"author1, author"])) {
        XCTFail(@"Generate Authors fails with more Authors! >%@<",testString2);
    }
}

@end
