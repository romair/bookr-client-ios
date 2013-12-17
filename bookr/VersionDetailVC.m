//
//  VersionDetailVC.m
//  bookr
//
//  Created by Steve Maahs on 17.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import "VersionDetailVC.h"

@interface VersionDetailVC ()

@end

@implementation VersionDetailVC

@synthesize book;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_titleLabel setText:[book title]];
    [_subTitleLabel setText:[[book quality] stringValue]];
    NSMutableString *authorString = [NSMutableString string];
    for (Author *author in [book authors]) {
        [authorString appendFormat:@"%@, ",author.name];
    }
    [_authorsLabel setText:authorString];
    [_publischerYearLabel setText:[NSString stringWithFormat:@"%@ (%@)",[book publisher],[book year]]];
    [_textSnippetTextView setText:[book textSnippet]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
