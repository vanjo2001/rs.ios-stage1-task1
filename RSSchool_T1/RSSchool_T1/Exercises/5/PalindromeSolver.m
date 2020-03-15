#import "PalindromeSolver.h"

@implementation PalindromeSolver

// Complete the highestValuePalindrome function below.
- (NSString *) highestValuePalindrome:(NSString *)s n:(NSNumber *)n k:(NSNumber *)k {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [s enumerateSubstringsInRange:(NSRange){0, [s length]} options: NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [arr addObject:substring];
    }];
    
    NSInteger size = [n integerValue];
    NSInteger countOfChange = [k integerValue];
    NSInteger max = 0;
    NSInteger check = 0;
    
    size = size % 2 == 0 ? size : size-1;
    
    for (long i = 0, j = size-1; i < size/2; i++, j--) {
        if (([[arr objectAtIndex:i] integerValue] != [[arr objectAtIndex:j] integerValue])) {
            NSInteger valueI = [[arr objectAtIndex:i] integerValue];
            NSInteger valueJ = [[arr objectAtIndex:j] integerValue];
            NSInteger bigger = MAX(valueI, valueJ);
            if (max < bigger) {
                max = bigger;
            }
            check++;
        }
    }
    
    if (check > [k integerValue]) {
        return @"-1";
    }
    
    for (long i = 0, j = size-1; i < size/2; i++, j--) {
        if (([[arr objectAtIndex:i] integerValue] != [[arr objectAtIndex:j] integerValue]) && countOfChange > 0) {
            
            arr[j] = [NSNumber numberWithInteger:max];
            arr[i] = [NSNumber numberWithInteger:max];
            countOfChange --;
        }
    }
    
    return [arr componentsJoinedByString:@""];
}


@end
