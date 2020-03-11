#import "MiniMaxArrayConverter.h"




@implementation MiniMaxArrayConverter

// Complete the convertFromArray function below.
- (NSArray<NSNumber*>*)convertFromArray:(NSArray<NSNumber*>*)array {
    
    NSInteger min = 0;
    NSInteger max = 0;
    
    NSArray *sorted1 = [array sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]]];
    NSArray *sorted2 = [array sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:nil ascending:NO]]];
    
    for (int i = 1; i < sorted1.count; i++) {
        max += [sorted1[i] integerValue];
        min += [sorted2[i] integerValue];
    }
    
    return @[[[NSNumber alloc] initWithInteger:min], [[NSNumber alloc] initWithInteger:max]];
}



@end
