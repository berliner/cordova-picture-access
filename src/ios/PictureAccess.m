//
//  PictureAccess.m
//

#import "PictureAccess.h"

@implementation PictureAccess

@synthesize callbackId;

- (void) checkAccess:(CDVInvokedUrlCommand *)command {

    // Check for permission
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];

    CDVPluginResult* result = nil;

    if (authStatus == ALAuthorizationStatusAuthorized) {
        NSLog(@"Access to picture gallery granted");
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Access granted"];
        [self invokeCallback:command withResult:result];
    }
    else if (authStatus == ALAuthorizationStatusNotDetermined) {
        NSLog(@"Access to picture gallery not yet determined. Will ask user.");
        __block CDVPluginResult* result = nil;

        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            NSLog(@"Access to picture gallery granted by user");
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Access granted"];
            [self invokeCallback:command withResult:result];
        } failureBlock:^(NSError *error) {
            if (error.code == ALAssetsLibraryAccessUserDeniedError) {
                NSLog(@"Access to picture gallery denied by user");
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
                [self invokeCallback:command withResult:result];
            } else{
                NSLog(@"Other error code: %i", error.code);
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
                [self invokeCallback:command withResult:result];
            }
        }];
    }
    else {
        NSLog(@"Access to picture gallery denied");
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
        [self invokeCallback:command withResult:result];
    }
}

- (void) invokeCallback:(CDVInvokedUrlCommand *)command withResult:(CDVPluginResult *)result {
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
