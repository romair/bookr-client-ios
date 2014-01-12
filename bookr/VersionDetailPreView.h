//
//  VersionDetailPreView.h
//  bookr
//
//  Created by Steve Maahs on 10.01.14.
//  Copyright (c) 2014 WSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "Book.h"
#import "ISBN.h"
#import "Author.h"
#import "Thumbnail.h"

@interface VersionDetailPreView : UIView

{
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    UILabel *publishAndYearLabel;
    UILabel *authorsLabel;
    UITextView *textSnippetView;
    UIImageView *thumbnail;
    
    BOOL hasSubtitle;
    BOOL isIphone5;
    //landscape?
}

@property (strong, nonatomic) Book *book;

//View Methods
//-(void)setupView;
-(void)changeBook:(Book *) newBook;

//visible Actions
-(void)slideIn;
-(void)slideOUt;

@end
