//
//  VersionDetailPreView.m
//  bookr
//
//  Created by Steve Maahs on 10.01.14.
//  Copyright (c) 2014 WSM. All rights reserved.
//

#import "VersionDetailPreView.h"

NSString *const VDPUsedFontName = @"HelveticaNeue";

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
    snippetTextView     = [[UITextView alloc] init];
    thumbnail           = [[UIImageView alloc] init];
    
    publishAndYearInfL  = [[UILabel alloc] init];
    snippetTextInfL     = [[UILabel alloc] init];
    authorInfL          = [[UILabel alloc] init];
    
    hasSubtitle = NO;
    
    //init der layer auf dem alles stattfinden wird
    backround = [CALayer layer];
    [backround setFrame:(CGRect){{0,64},{320,504}}];
    [backround setBackgroundColor:[UIColor blackColor].CGColor];
    [backround setOpacity:0.60];
    [[self layer] addSublayer:backround];
    
    sheetBackground = [[UIView alloc] initWithFrame:(CGRect){{10,25+64},{300,469}}];
    [sheetBackground setBackgroundColor:[UIColor colorWithWhite:0.98 alpha:1]];
    [[sheetBackground layer] setCornerRadius:2.5];
    [self addSubview:sheetBackground];
    
    seperator = [CALayer layer];
    [seperator setFrame:(CGRect){{25,0},{250,1}}];
    [seperator setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1].CGColor];
    [[sheetBackground layer] addSublayer:seperator];
    
    disMissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [disMissButton setTitle:@"close" forState:UIControlStateNormal];
    CGSize buttonTitleSize = [[disMissButton titleForState:UIControlStateNormal] boundingRectWithSize:(CGSize){100,30} options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont fontWithName:VDPUsedFontName size:[UIFont buttonFontSize]]} context:nil].size;
    buttonTitleSize = (CGSize){ceilf(buttonTitleSize.width+20),ceilf(buttonTitleSize.height+20)};
    [disMissButton setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [disMissButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [disMissButton setFrame:(CGRect){{sheetBackground.frame.size.width-(buttonTitleSize.width+25),sheetBackground.frame
        .size.height-(buttonTitleSize.height+25)},buttonTitleSize}];
    [disMissButton addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
    
    [titleLabel setFont:[UIFont fontWithName:VDPUsedFontName size:20]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [snippetTextView setBackgroundColor:[UIColor clearColor]];
    
    [self setupInfoWithLable:publishAndYearInfL string:@"Publisher (Year)"];
    [self setupInfoWithLable:snippetTextInfL string:@"Text Snippet"];
    [self setupInfoWithLable:authorInfL string:@"Autoren"];
    
    [sheetBackground addSubview:titleLabel];
    [sheetBackground addSubview:subtitleLabel];
    [sheetBackground addSubview:publishAndYearInfL];
    [sheetBackground addSubview:publishAndYearLabel];
    [sheetBackground addSubview:authorInfL];
    [sheetBackground addSubview:authorsLabel];
    [sheetBackground addSubview:snippetTextInfL];
    [sheetBackground addSubview:snippetTextView];
    [sheetBackground addSubview:thumbnail];
    [sheetBackground addSubview:disMissButton];
}

-(void)setupInfoWithLable:(UILabel *)label string:(NSString *)string
{
    [label setFont:[UIFont fontWithName:VDPUsedFontName size:12]];
    [label setTextColor:[UIColor lightGrayColor]];
    [label setText:string];
    
    [label setFrame:(CGRect){{0,25},[self calcLabelSize:string withFontSize:[label.font pointSize]]}];
}

-(CGSize)calcLabelSize:(NSString *)string withFontSize:(CGFloat)fontSize
{
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:VDPUsedFontName size:fontSize]}];
    size = (CGSize){ceilf(size.width),ceilf(size.height)};
    return size;
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
#warning test impl
    book = newBook;
    
    //Änderungen kommen hier rein falls es unterschiedliche Bücher sind
    if (!isSameBook) {
#warning Bisher nicht implementiert
        //setze neuen Title
        [self refreshTitle];
        //setze neuen Subtitle
        [self refreshSubTitle];
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
    NSString *title;
    if (book.title) {
        title = book.title;
    }
    //text setzen
    [titleLabel setText:title];
    
    // schauen ob der neue String mit gegebenen eigentschaften die breite überschreitet

    [titleLabel setNumberOfLines:3];

    //falls kein Titel existiert????
    
    // falls ja Titel bei der hälfte der leerzeichen teilen
    // nochmal schauen ob es diesmal reicht -> nein noch dritteln
    //-> ja lines setzen und die size übergeben
    // falls keine existieren ausbpunkten
    
    NSDictionary *stringAtt = @{NSFontAttributeName:[UIFont fontWithName:VDPUsedFontName size:20]};
    CGSize textBox = [title boundingRectWithSize:(CGSize){280,75} options:NSStringDrawingUsesLineFragmentOrigin attributes:stringAtt context:nil].size;
    CGRect titleLabelFrame = (CGRect){{10,10},{280,ceilf(textBox.height)}};
    
    [titleLabel setFrame:titleLabelFrame];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0];
    [seperator setFrame:(CGRect){{25,titleLabelFrame.origin.y+titleLabelFrame.size.height+10},{250,1}}];
    [CATransaction commit];
}

-(void)refreshSubTitle
{
    //schauen ob ein sbtitle existiert (über variable)
    // ähnlich wie bei refresh titel mit einer geringeren schriftgröße und ein wenig gräulicher
    CGFloat titleYEnd = seperator.frame.origin.y + seperator.frame.size.height;
    
    if (book.subtitle.length != 0) {
        
    } else {
        
        [subtitleLabel setFrame:(CGRect){{25,titleYEnd+10},CGSizeZero}];
    }
    
}

-(void)refreshPublisherAndYear
{
    //existenz überprüfen beider parteien
    CGFloat subtitleYEnd = subtitleLabel.frame.origin.y + subtitleLabel.frame.size.height;
    CGFloat isSubtitle = subtitleLabel.frame.size.height == 0 ? -10 : 0;
    
    NSMutableString *infoString = [NSMutableString string];
    NSMutableString *contentString = [NSMutableString string];
    BOOL hasPublisher = NO;
    
    if (book.publisher.length != 0) {
        [infoString appendString:@"Publisher"];
        [contentString appendString:book.publisher];
        hasPublisher = YES;
    }
    if (book.year.length != 0) {
#warning vllt doch ein if
        [infoString appendFormat:hasPublisher ? @" (Year)" : @"Year"];
        [contentString appendFormat:hasPublisher ? @" (%@)" : @"%@",book.year];
    }
    [publishAndYearInfL setText:infoString];
    [publishAndYearInfL setFrame:(CGRect){{25,subtitleYEnd+isSubtitle+10},CGSizeZero}];
    [publishAndYearInfL sizeToFit];
    
    CGSize pubAYearSize = [contentString boundingRectWithSize:(CGSize){250,50} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: publishAndYearLabel.font} context:nil].size;
    CGRect pubAYearFrame = (CGRect){{25,publishAndYearInfL.frame.origin.y+publishAndYearInfL.frame.size.height},{ceilf(pubAYearSize.width),ceilf(pubAYearSize.height)}};
    [publishAndYearLabel setText:contentString];
    [publishAndYearLabel setNumberOfLines:2];
    
    //NSLog(@"systemfon für label %f",[UIFont ]);
    [publishAndYearLabel setFrame:pubAYearFrame];

    //[publishAndYearInfL setText:@""];
    //[self setInfoLableSize:publishAndYearInfL WithOrigin:(CGPoint){25,subtitleYEnd}];
    //[publishAndYearInfL setFrame:(CGRect){{25,subtitleLabel.frame.origin.y+subtitleLabel.frame.size.height},publishAndYearInfL.frame.size}];
}

-(void)refreshAuthor
{
    CGFloat publisherYEnd = publishAndYearLabel.frame.origin.y + publishAndYearLabel.frame.size.height;
    CGFloat isPublisher = publishAndYearLabel.frame.size.height == 0 ? -10 : 0;
    
    NSString *infoString;
    NSMutableString *contentString = [NSMutableString string];
    
    //existenz überprüfen
    //Anzahl der Autoren ermitteln
    //in schleife autore an einen mutable string anfügen und mit komma trennen
    if ([book.authors count] == 1) {
        infoString = @"Author";
        [contentString appendString:[(Author *)[book.authors anyObject] name]];
    } else if ([book.authors count] > 1){
        infoString = @"Authors";
        for (Author *author in book.authors) {
            [contentString appendFormat:@"%@, ",author.name];
        }
        [contentString deleteCharactersInRange:(NSRange){contentString.length-3,2}];
    } else {
        infoString = @"";
    }
    
    [authorInfL setText:infoString];
    [authorInfL setFrame:(CGRect){{25,publisherYEnd+isPublisher+10},CGSizeZero}];
    [authorInfL sizeToFit];
    
    CGSize authorSize = [contentString boundingRectWithSize:(CGSize){250,50} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [authorsLabel font]} context:Nil].size;
    CGRect authorFrame = (CGRect){{25,authorInfL.frame.origin.y+authorInfL.frame.size.height},{ceilf(authorSize.width),ceilf(authorSize.height)}};
    [authorsLabel setText:contentString];
    [authorsLabel setNumberOfLines:2];
    [authorsLabel setFrame:authorFrame];
}

-(void)refreshTextSnippet
{
    CGFloat AuthorYEnd = authorsLabel.frame.origin.y + authorsLabel.frame.size.height;
    CGFloat isAuthor = authorsLabel.frame.size.height == 0 ? -10 : 0;
    
    //existenz überprüfen
    //falss nicht erwähnen das kein textsnippet angegebn wurde/ vorhanden
    [snippetTextInfL setFrame:(CGRect){{25,AuthorYEnd+isAuthor+10},CGSizeZero}];
    [snippetTextInfL sizeToFit];
    
    [snippetTextView setText:book.textSnippet];
    [snippetTextView setFrame:(CGRect){{25,snippetTextInfL.frame.origin.y+snippetTextInfL.frame.size.height},{250,100}}];
    [snippetTextView sizeToFit];
    
}

-(void)refreshThumbnail
{
    CGFloat snippetYEnd = snippetTextView.frame.origin.y + snippetTextView.frame.size.height;
    CGFloat isSnippet = snippetTextView.frame.size.height == 0 ? -10 : 0;
    
    UIImage* myImage = [UIImage imageWithData:
                        [NSData dataWithContentsOfURL:
                         [NSURL URLWithString:[[book thumbnail] normal]]]];
    
    [thumbnail setFrame:(CGRect){{25, snippetYEnd+isSnippet+10},{12,12}}];
    [thumbnail setImage:myImage];
    [thumbnail sizeToFit];
    
    float maxHeight = sheetBackground.frame.size.height-(snippetYEnd+10+25);
    if (maxHeight < thumbnail.frame.size.height) {
        float maxWidth = ceilf((maxHeight/thumbnail.frame.size.height)*thumbnail.frame.size.width);
        [thumbnail setFrame:(CGRect){thumbnail.frame.origin,{maxWidth, maxHeight}}];
    }
    
    /*if (book.thumbnail) {
        if (![thumbnail superview]) {
            //view sichtbar machen bzw superview setzen
        }
    } else {
        if ([thumbnail superview]) {
            //View entfernen oder unsichtbar machen
        }
    }*/
    //existenz überprüfen
    //falls nicht vorhanden wird der View zeitweilig entfernt
}

#warning slide in and out
/**
  * Diese Method lässt den View bei auf seinem SuperView erscheinen.
  */
-(void)slideIn
{
    if ([self superview]) {
        
    }
    //abfrage ob der View überhaupt auftauchen muss
    //wenn er bereits vorhanden ist dann wird auch nichts passieren(vorerst)
}

/**
  * Diese Methode lässt den View auf seinem SuperView verschwinden
  * @return nichts
  *
  */
-(void)slideOut
{
    //abfrage ob der View verschwinden muss
    //wenn nicht vorhanden wird er auch nicht nochmal verschwinden
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
