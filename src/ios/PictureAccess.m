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
    else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
        NSLog(@"Access to picture gallery denied");
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
