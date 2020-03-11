#import "BillCounter.h"

@implementation BillCounter

// Complete the following fuction
- (NSString*)compareResultForBill:(NSArray<NSNumber*>*)bill notIncludingElementWithIndex:(NSInteger)index withGivenSum:(NSNumber*)sum {
    
    NSInteger allMoney = 0;
    NSMutableArray *prepareArr = [NSMutableArray arrayWithArray:bill];
    [prepareArr removeObjectAtIndex:index];
    
    for (NSNumber *num in prepareArr) {
        allMoney += [num integerValue];
    }
    
    NSInteger refundInt = [sum integerValue]-allMoney/2;
    
    if (allMoney/2 == [sum integerValue]) {
        return @"Bon Appetit";
    } else {
        return [NSString stringWithFormat:@"%li", (long)refundInt];
    }

}

@end
