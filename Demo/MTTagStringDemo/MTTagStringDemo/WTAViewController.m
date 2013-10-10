//
//  ViewController.m
//  MTTagStringDemo
//
//  Created by Harang Ju on 5/15/13.
//  Copyright (c) 2013 WillowTree Apps. All rights reserved.
//

#import "WTAViewController.h"
#import "WTATagStringBuilder.h"

@interface WTAViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelBefore;
@property (weak, nonatomic) IBOutlet UILabel *labelAfter;

@end

@implementation WTAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* regularString = @"The quick fox <TAG1>jumped</TAG1> over the lazy <TAG2>dog</TAG2>.";
    
    
    WTATagStringBuilder* tagString = [[WTATagStringBuilder alloc] initWithString:regularString];
    
    // adding global attribute
    [tagString addGlobalAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"Helvetica-Light"
                                                  size:20]];
    
    // adding tagged attributes
    [tagString addAttribute:NSUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt: NSUnderlineStyleSingle]
                        tag:@"TAG1"];
    [tagString addAttribute:NSBackgroundColorAttributeName
                      value:[UIColor greenColor]
                        tag:@"TAG2"];
    
    // before
    self.labelBefore.text = regularString;
    // after
    self.labelAfter.attributedText = tagString.attributedString;
}

@end
