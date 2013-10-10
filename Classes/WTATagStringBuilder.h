//
//  WTATagStringBuilder.h
//  WTATagStringBuilder
//
//  Created by Andrew Carter on 11/28/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTATagStringBuilder : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, readonly) NSAttributedString *attributedString;

- (id)initWithString:(NSString *)string;
- (void)addGlobalAttribute:(id)attribute value:(id)value;
- (void)addAttribute:(id)attribute value:(id)value tag:(NSString *)tag;
- (NSArray *)attributesForTag:(NSString *)tag;

@end
