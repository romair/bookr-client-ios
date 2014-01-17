//
//  FirstViewCont.h
//  bookr
//
//  Created by Steve Maahs on 11.12.13.
//  Copyright (c) 2013 WSM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BookrConnection.h"
#import "BookrHelper.h"

@interface BookSearchListVC : UITableViewController <ObjectLoadDelegate,UISearchBarDelegate>
{
    BookrConnection *conn;
    
    Boolean lookForMore;
}
/**
 * SearchbarView
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarView;
/**
 * Die Liste der Objekte die dargestellt werden sollen
 */
@property (strong,nonatomic) NSMutableArray * bookArray;

@end
