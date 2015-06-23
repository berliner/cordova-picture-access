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
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Access granted"];
        NSLog(@"Access to picture gallery granted");
    }
    else if (authStatus == ALAuthorizationStatusNotDetermined) {
        NSLog(@"Access to picture gallery not yet determined");
        __block CDVPluginResult* result = nil;

        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Access not determined"];
            NSLog(@"Access to picture gallery granted");
        } failureBlock:^(NSError *error) {
            if (error.code == ALAssetsLibraryAccessUserDeniedError) {
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
                NSLog(@"Access to picture gallery denied");
            } else{
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
                NSLog(@"Other error code: %i", error.code);
            }
        }];


    }
    else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
        NSLog(@"Access to picture gallery denied");
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
