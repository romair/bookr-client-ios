//
//  VersionDetailPreView.m
//  bookr
//
//  Created by Steve Maahs on 10.01.14.
//  Copyright (c) 2014 WSM. All rights reserved.
//

#import "VersionDetailPreView.h"

@implementation VersionDetailPreView

@synthesize book;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupVersionDetailPreView];
        
    }
    return self;
}
/** Alloc all View Elements of this View*/
-(void)setupVersionDetailPreView
{
    titleLabel          = [[UILabel alloc] init];
    subtitleLabel       = [[UILabel alloc] init];
    publishAndYearLabel = [[UILabel alloc] init];
    authorsLabel        = [[UILabel alloc] init];
    textSnippetView     = [[UITextView alloc] init];
    thumbnail           = [[UIImageView alloc] init];
    
    hasSubtitle = NO;
    
    //init der layer auf dem alles stattfinden wird
}

/** Change Book
  * This Method is for changing the Book in the View.
  * All Elements have to become new Values, if the Book is not the Same
  */
-(void)changeBook:(Book *) newBook
{
    BOOL isSameBook = NO;
    if (book && newBook) {
        if ([[book.isbn isbn13] isEqualToString:[newBook.isbn isbn13]]) {
            isSameBook = YES;
        }
    }
    //Änderungen kommen hier rein falls es unterschiedliche Bücher sind
    if (!isSameBook) {
#warning Bisher nicht implementiert
        //setze neuen Title
        [self refreshTitle];
        //abfrage ob ein subtitle überhaupt vorhanden ist
        [self refreshSubTitle];
        //setze neuen Subtitle
        //setze neuen publisher year
        [self refreshPublisherAndYear];
        //setze neuen autor
        [self refreshAuthor];
        //setze neuen Textsnippet
        [self refreshTextSnippet];
        //setze neuen thumbnail
        [self refreshThumbnail];
    }
}

-(void)refreshTitle
{
    //[[NSString string] si]
    //falls kein Titel existiert????
    // schauen ob der neue String mit gegebenen eigentschaften die breite überschreitet
    // falls ja Titel bei der hälfte der leerzeichen teilen
    // nochmal schauen ob es diesmal reicht -> nein noch dritteln
    //-> ja lines setzen und die size übergeben
    // falls keine existieren ausbpunkten
    //text setzen
}

-(void)refreshSubTitle
{
    //schauen ob ein sbtitle existiert (über variable)
    // ähnlich wie bei refresh titel mit einer geringeren schriftgröße und ein wenig gräulicher
}

-(void)refreshPublisherAndYear
{
    //existenz überprüfen beider parteien
    if (book.publisher && book.year) {
        NSLog(@"Buch besitzt Publisher und Jahr");
    } else if (book.publisher && !book.year) {
        NSLog(@"Buch besitz nur Publisher");
    } else if (!book.publisher && book.year) {
        NSLog(@"Buch besitz nur Jahr");
    } else if (!book.publisher && !book.year) {
        NSLog(@"Buch besitzt werde Publisher noch Jahr");
    }
}

-(void)refreshAuthor
{
    //existenz überprüfen
    //Anzahl der Autoren ermitteln
    //in schleife autore an einen mutable string anfügen und mit komma trennen
}

-(void)refreshTextSnippet
{
    //existenz überprüfen
    //falss nicht erwähnen das kein textsnippet angegebn wurde/ vorhanden
}

-(void)refreshThumbnail
{
    //existenz überprüfen
    //falls nicht vorhanden wird der View zeitweilig entfernt
}

#warning slide in and out
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
