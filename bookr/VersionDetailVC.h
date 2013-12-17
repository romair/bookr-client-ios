//
//  VersionDetailVC.h
//  bookr
//
//  Created by Steve Maahs on 17.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Book.h"
#import "Author.h"

@interface VersionDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publischerYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UITextView *textSnippetTextView;

@property (strong,nonatomic) Book * book;

@end
