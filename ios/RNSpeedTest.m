
#import "RNSpeedTest.h"
@implementation RNSpeedTest
- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()
RCT_REMAP_METHOD(getSpeed,
                 findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    [self testDownloadSpeedWithTimout:5.0 completionHandler:^(CGFloat megabytesPerSecond, NSError *error) {
        NSString *str = [NSString stringWithFormat:@"%.1f", megabytesPerSecond];
        NSLog(@"%0.1f; error = %@", megabytesPerSecond, error);
        resolve(str);
    }];


}

- (void)testDownloadSpeedWithTimout:(NSTimeInterval)timeout completionHandler:(nonnull void (^)(CGFloat megabytesPerSecond, NSError * _Nullable error))completionHandler {
    NSURL *url = [NSURL URLWithString:@"http://ovh.net/files/1Gb.dat"];

    self.startTime = CFAbsoluteTimeGetCurrent();
    self.stopTime = self.startTime;
    self.bytesReceived = 0;
    self.speedTestCompletionHandler = completionHandler;

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    configuration.timeoutIntervalForResource = timeout;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    [[session dataTaskWithURL:url] resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    self.bytesReceived += [data length];
    self.stopTime = CFAbsoluteTimeGetCurrent();
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    CFAbsoluteTime elapsed = self.stopTime - self.startTime;
    CGFloat speed = elapsed != 0 ? self.bytesReceived / (CFAbsoluteTimeGetCurrent() - self.startTime) / 100000.0 : -1;

    // treat timeout as no error (as we're testing speed, not worried about whether we got entire resource or not

    if (error == nil || ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorTimedOut)) {
        self.speedTestCompletionHandler(speed, nil);
    } else {
        self.speedTestCompletionHandler(speed, error);
    }
}
@end
