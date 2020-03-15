#import "Parser.h"


@implementation Parser

static NSCharacterSet *setOpen;
static NSCharacterSet *setClose;


// Complete the parseString function below.
- (NSArray <NSString*>*)parseString:(NSString*)string {
    
    NSMutableString *copyString = [[NSMutableString alloc] init];
    [copyString setString:string];
    
    NSMutableArray *arrOfRange = [[NSMutableArray alloc] init];
    NSMutableArray *arrOfString = [[NSMutableArray alloc] init];
    
    extern NSCharacterSet *setOpen;
    setOpen = [NSCharacterSet characterSetWithCharactersInString:@"(<["];
    
    
    extern NSCharacterSet *setClose;
    setClose = [NSCharacterSet characterSetWithCharactersInString:@")>]"];
    
    
    long *state_open_brackets = (long *)malloc(sizeof(long) * 20);
    #pragma unused(state_open_brackets)
    
    long *state_close_brackets = (long *)malloc(sizeof(long) * 20);
    #pragma unused(state_close_brackets)
    
    NSArray *just = [self isHaveSomeBrackets:arrOfRange inputString:string fromTo: @[[NSValue valueWithRange:NSMakeRange(0, string.length)]] ];
    
    
    for (NSValue *one in just) {
        [arrOfRange addObject: one];
    }
    
    for (NSValue *one in arrOfRange) {
        NSRange range = [one rangeValue];
        NSMutableString *strMut = copyString;
        
        NSString *str = [strMut substringWithRange:range];
        
        [arrOfString addObject: str];
    }
    
    //Lorem <(ipsum [dolor <sit] amet), consectetur adipiscing elit>. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet>. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget (nulla. Class aptent <taciti [sociosqu ad] litora torquent per conubia> nostra), per inceptos himenaeos.
    
    //["<": 6, "(": 7, "[": 14, "<": 21, "]": 25, ")": 31, ">": 61]
    
    return arrOfString;
}

- (NSArray *)isHaveSomeBrackets:(NSMutableArray *)arrOfRange inputString:(NSString *)string fromTo:(NSArray *)ft {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *buffer = @"";
    NSRange includeRange = NSMakeRange(0, 0);
    NSUInteger includeIndex = 0;
    
    for (NSValue *oneRange in ft) {
        NSRange range = [oneRange rangeValue];
        
        for (long i = range.location, j = 0; i < range.length; i++) {
            NSString *currentSymb = [string substringWithRange:NSMakeRange(i, 1)];
            
            if ([setOpen isSupersetOfSet: [NSCharacterSet characterSetWithCharactersInString:currentSymb]]) {
                
                if ([buffer isEqualToString:@""]) {
                    buffer = currentSymb;
                    j = i;
                } else {
                    includeIndex++;
                    includeRange.location = i+1;
                }
                
            } else if ([setClose isSupersetOfSet: [NSCharacterSet characterSetWithCharactersInString:currentSymb]]) {
                if ([[self invertBracket:buffer] isEqualToString:currentSymb] && includeIndex == 0) {
                    
                    [arrOfRange addObject:[NSValue valueWithRange:NSMakeRange(j+1, i-j-1)]];
                    buffer = @"";
                    
                } else {
                    includeIndex--;
                    includeRange.length = i-includeRange.location;
                    [result addObject:[NSValue valueWithRange:includeRange]];
                }
            }
        }
        
    }
    

    
    return result;
}

- (BOOL)isStringContains:(NSString *)elements stringData:(NSString *)string {
    for (long i = 0; i < [string length]; i++) {
        NSString *one = [string substringWithRange:NSMakeRange(i, 1)];
        for (long j = 0; j < [elements length]; j++) {
            NSString *check = [elements substringWithRange:NSMakeRange(j, 1)];
            if ([one isEqualToString:check]) {
                return true;
            }
        }
    }
    return false;
}

- (NSString *)invertBracket:(NSString *)input {
    if ([input  isEqual: @"("]) {
        return @")";
    } else if ([input  isEqual: @")"]){
        return @"(";
    } else if ([input  isEqual: @"<"]){
        return @">";
    } else if ([input  isEqual: @">"]){
        return @"<";
    } else if ([input  isEqual: @"["]){
        return @"]";
    } else if ([input  isEqual: @"]"]){
        return @"[";
    }
    return @"";
}

@end
