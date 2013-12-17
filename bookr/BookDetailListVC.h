//
//  BookDetailListVC.h
//  bookr
//
//  Created by Steve Maahs on 16.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BookrConnection.h"
#import "VersionDetailVC.h"

#import "Book.h"
#import "ISBN.h"


@interface BookDetailListVC : UITableViewController <ObjectLoadDelegate>

@property (strong, nonatomic)SuperBook * superBook;
@property (strong, nonatomic)BookrConnection * conn;

@property (strong, nonatomic)NSMutableArray * versions;

@end
