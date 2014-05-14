WTATagStringBuilder
===========

WTATagStringBuilder is a tool for building attributed strings using custom tags.  

You do this using tags like "The sky is \<tag>blue\</tag>" and setting attributes for those tags.

###Example
``` objc
WTATagStringBuilder* tagString = [[WTATagStringBuilder alloc] initWithString:@"The quick brown fox <TAG>jumped</TAG>"];
[tagString addGlobalAttribute:NSFontAttributeName 
                        value:[UIFont fontWithName:@"Helvetica-Light" size:20]];
[tagString addAttribute:NSUnderlineStyleAttributeName
                  value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                    tag:@"TAG"];
self.label.attributeText = tagString.attributedString;
```  

The example above would have "The quick brown fox jumped" all in Helvetica-Light, size 20 font and would have "jumped" underlined.

You can find list of attributes that iOS provides at https://developer.apple.com/library/ios/#documentation/uikit/reference/NSAttributedString_UIKit_Additions/Reference/Reference.html (search "Character Attributes").  

###Tasks

[string](#string) *property*  
[attributedString](#attributedString) *property*  
[- initWithString:](#initWithString)  
[- addGlobalAttribute:value:](#addGlobalAttributevalue)
[- addAttribute:value:tag:](#addAttributevaluetag)
[- attributesForTag:](#attributesForTag)

###Properties

<a name="string"/>
####string  
A copy of the character contents of the receiver (this `MTTagString`) as an `NSString` object  
`@property (nonatomic, copy) NSString *string;`  
Default: `nil`  

<a name="attributedString"/>
####attributedString
The character contents with string attributes as an `NSAttributedString` object  
`@property (nonatomic, readonly) NSAttributedString *attributedString;`  
Default: `nil`  

###Instance Methods

<a name="initWithString"/>
####initWithString:
Returns an instance of the `MTTagString` with a given `NSString` object  
`- (void)addGlobalAttribute:(id)attribute value:(id)value;`  
**Parameters**  
\* *string* - the characters for the new object  
**Return Value**  
    an instance of `MTTagString` with `string` as its string  

<a name="addGlobalAttributevalue"/>
####addGlobalAttribute:value:
Adds an attribute to the entire string  
`- (void)addAttribute:(id)attribute value:(id)value tag:(NSString *)tag;`  
**Parameters**  
\* *attribute* - the name of the attribute  
\* *value* - the value of the attribute  

<a name="addAttributevaluetag"/>
####addAttribute:value:tag:  
Adds an attribute to all parts of the string from `<tag>` to `</tag>`  
`- (void)addAttribute:(id)attribute value:(id)value tag:(NSString *)tag;`  
**Parameters**  
\* *attribute* - the name of the attribute  
\* *value* - the value of the attribute  
\* *tag* - the tag that shows where to apply the attributes  

<a name="attributesForTag"/>
####attributesForTag:  
Returns the all the attributes that are applied to parts of the strings from `<tag>` to `</tag>`  
`- (NSArray *)attributesForTag:(NSString *)tag;`  
**Parameters**  
\* *tag* - a string that determines where the attributes are applied  
**Returns**  
an array of all the attributes for `tag`  




