#import "T1Array.h"

@implementation T1Array

// Complete the following fuction
- (NSArray *)convertToHappy:(NSArray *)sadArray {
    
    if (sadArray.count == 0) {
        return @[];
    }
    
    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:sadArray];
    
    int check = 1;
    NSInteger firstNearValue = 0;
    NSInteger middleValue = 0;
    NSInteger secondNearValue = 0;
    
    while (check == 1) {
        check = 0;
        for (int i = 0; i < mutableArr.count-2; i++) {
            firstNearValue = [mutableArr[i] intValue];
            middleValue = [mutableArr[i+1] intValue];
            secondNearValue = [mutableArr[i+2] intValue];
            if (firstNearValue + secondNearValue <= middleValue) {
                [mutableArr removeObjectAtIndex:i+1];
                check = 1;
            }
        }
    }
    
    
    return [NSArray arrayWithArray:mutableArr];
}

@end
