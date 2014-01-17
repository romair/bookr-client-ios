//
//  bookrTests.m
//  bookrTests
//
//  Created by Steve Maahs on 06.11.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BookSearchListVC.h"
#import "BookDetailListVC.h"
#import "VersionDetailPreView.h"

#import "SuperBook.h"
#import "Book.h"
#import "Author.h"
#import "ISBN.h"
#import "Thumbnail.h"

@interface bookrTests : XCTestCase
{
    BookSearchListVC *bSLCV;
    BookDetailListVC *bDLVC;
    VersionDetailPreView *vDPV;
    
    SuperBook *superBook;
    Book *book;
    ISBN *isbn;
    ISBN *isbn1;
    ISBN *isbn2;
    Author *author;
    Author *author1;
    Thumbnail *thumbnail;
}
@end

@implementation bookrTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    vDPV = [[VersionDetailPreView alloc] initWithFrame:(CGRect){CGPointZero,{320,564}}];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertTrue (YES, @"hell yeah");
}

- (void)testSecond
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testVersionDetailPreView
{
    XCTAssertNotNil(vDPV, @"VersionDetailPreView isn't initialized!");
}
- (void)testVersionDetailPreViewSlideInAnimation
{
    UIView *superView = [[UIView alloc] init];
    [superView addSubview:vDPV];
    XCTAssertFalse([vDPV hasAnitmation], @"had an Animation");
    [vDPV slideIn];
    XCTAssertTrue([vDPV hasAnitmation], @"ha no animation");
}
- (void)testVersionDetailPreViewSlideOutAnimation
{
    XCTAssertFalse([vDPV hasAnitmation], @"Had an Animation");
    [vDPV slideOut];
    XCTAssertTrue([vDPV hasAnitmation], @"Had No Animation");
}
@end
