


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDUtilities : NSObject

+ (void)printObject:(void *)object;

+ (void)setShouldExitOnCheckResultFail:(BOOL)shouldExitOnCheckResultFail;
+ (BOOL)shouldExitOnCheckResultFail;

+ (void)checkResult:(OSStatus)result
          operation:(const char *)operation;

//Comparing numbers
+ (void)setComparisonAccuracy:(Float64)accuracy;

+ (BOOL)compareDoubleWithFirstArgument:(Float64)first
                        secondArgument:(Float64)second;

@end

NS_ASSUME_NONNULL_END