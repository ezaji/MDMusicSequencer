


#import "MDUtilities.h"
#import <AudioToolbox/AudioToolbox.h>

BOOL __shouldExitOnCheckResultFail = NO;

Float64 __accuracy = 0.000001;

@implementation MDUtilities

//------------------------------------------------------------------------------
#pragma mark - Debugging
//------------------------------------------------------------------------------

+ (void)printObject:(void *)object {
    CAShow(object);
}

+ (void)setShouldExitOnCheckResultFail:(BOOL)shouldExitOnCheckResultFail
{
    __shouldExitOnCheckResultFail = shouldExitOnCheckResultFail;
}

//------------------------------------------------------------------------------

+ (BOOL)shouldExitOnCheckResultFail
{
    return __shouldExitOnCheckResultFail;
}

//------------------------------------------------------------------------------
#pragma mark - OSStatus Utility
//------------------------------------------------------------------------------

+ (void)checkResult:(OSStatus)result operation:(const char *)operation {
    if (result == noErr) return;
    char errorString[20];
    // see if it appears to be a 4-char-code
    *(UInt32 *)(errorString + 1) = CFSwapInt32HostToBig(result);
    if (isprint(errorString[1]) && isprint(errorString[2]) && isprint(errorString[3]) && isprint(errorString[4]))
    {
        errorString[0] = errorString[5] = '\'';
        errorString[6] = '\0';
    } else
        // no, format it as an integer
        sprintf(errorString, "%d", (int)result);
    fprintf(stderr, "Error: %s (%s)\n", operation, errorString);
    if (__shouldExitOnCheckResultFail)
    {
        exit(-1);
    }
}

//------------------------------------------------------------------------------
#pragma mark - Comparing Numbers Utility
//------------------------------------------------------------------------------
+ (void)setComparisonAccuracy:(Float64)accuracy {
    __accuracy = accuracy;
}

+ (BOOL)compareDoubleWithFirstArgument:(Float64)first
                        secondArgument:(Float64)second {
    return (fabs(second - first) <= __accuracy);
}

@end
