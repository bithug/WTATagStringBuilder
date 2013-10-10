//
//  WTATagStringBuilder.m
//  WTATagStringBuilder
//
//  Created by Andrew Carter on 11/28/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "WTATagStringBuilder.h"

@interface WTATagStringBuilder ()

@property (nonatomic, readonly) NSMutableDictionary *tags;
@property (nonatomic, readonly) NSMutableArray *globalAttributes;

@end

@implementation WTATagStringBuilder

@synthesize tags = _tags;
@synthesize globalAttributes = _globalAttributes;
@synthesize attributedString = _attributedString;

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self)
    {
        [self setString:string];
    }
    return self;
}

#pragma mark - Accessors

- (void)setString:(NSString *)string
{
    _string = [string copy];
    _attributedString = nil;
}

- (NSMutableDictionary *)tags
{
    if (!_tags)
    {
        _tags = [NSMutableDictionary new];
    }
    return _tags;
}

- (NSMutableArray *)globalAttributes
{
    if (!_globalAttributes)
    {
        _globalAttributes = [NSMutableArray new];
    }
    return _globalAttributes;
}

- (NSAttributedString *)attributedString
{
    if (!_attributedString)
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[self string]];
        
        if (_globalAttributes)
        {
            for (NSDictionary *attribute in [self globalAttributes])
            {
                [attributedString addAttribute:attribute[@"attribute"] value:attribute[@"value"] range:NSMakeRange(0, [[attributedString string] length])];
            }
        }
        
        NSString *workingString = [[self string] copy];
        
        for (NSString *tag in [[self tags] allKeys])
        {
            NSString *startTag = [NSString stringWithFormat:@"<%@>", tag];
            NSString *endTag = [NSString stringWithFormat:@"</%@>", tag];
            
            while ([workingString rangeOfString:startTag].location != NSNotFound)
            {
                NSScanner *scanner = [NSScanner scannerWithString:workingString];
                [scanner setScanLocation:0];
                [scanner scanUpToString:startTag intoString:nil];
                NSUInteger startLocation = [scanner scanLocation];
                [scanner scanUpToString:endTag intoString:nil];
                NSUInteger endLocation = [scanner scanLocation];
                
                if (endLocation == [workingString length])
                {
                    NSLog(@"MTTagString: <Warning> encountered tag (%@) without a closing tag at location", tag);
                    [attributedString replaceCharactersInRange:NSMakeRange(startLocation, [startTag length])
                                                    withString:@""];
                    continue;
                }
                
                [attributedString replaceCharactersInRange:NSMakeRange(endLocation, [endTag length])
                                                withString:@""];
                
                
                for (NSDictionary *attribute in [self tags][tag])
                {
                    [attributedString addAttribute:attribute[@"attribute"] value:attribute[@"value"]
                                             range:NSMakeRange(startLocation, endLocation - startLocation)];
                }
                
                [attributedString replaceCharactersInRange:NSMakeRange(startLocation, [startTag length])
                                                withString:@""];
                
                workingString = [attributedString string];
            }
            
        }
        
        _attributedString = [[NSAttributedString alloc] initWithAttributedString:attributedString];
    }
    
    return _attributedString;
}

#pragma mark - Instance Methods

- (void)addGlobalAttribute:(id)attribute value:(id)value
{
    _attributedString = nil;
    [[self globalAttributes] addObject:@{@"attribute" : attribute, @"value" : value}];
}

- (void)addAttribute:(id)attribute value:(id)value tag:(NSString *)tag
{
    _attributedString = nil;
    NSMutableArray *attributes = [self tags][tag];
    if (!attributes)
    {
        attributes = [NSMutableArray new];
        [self tags][tag] = attributes;
    }
    [attributes addObject:@{@"attribute" : attribute, @"value" : value}];
}

- (NSArray *)attributesForTag:(NSString *)tag
{
    return [self tags][tag];
}

@end
