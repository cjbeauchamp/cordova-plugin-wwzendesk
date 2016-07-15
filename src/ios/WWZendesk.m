/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#include <sys/types.h>
#include <sys/sysctl.h>
#include "TargetConditionals.h"

#import <Cordova/CDV.h>
#import "WWZendesk.h"

// project-specific
#import "AppDelegate.h"
#import <ZendeskSDK/ZendeskSDK.h>

@implementation WWZendesk

- (void) showHelpdesk:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Email was null"];
    if(command.arguments.count > 0) {
        NSString *email = [command.arguments objectAtIndex:0];
        if(email != nil) {
            ZDKAnonymousIdentity *identity = [ZDKAnonymousIdentity new];
            identity.email = email;
            [ZDKConfig instance].userIdentity = identity;
            
            [ZDKHelpCenter presentHelpCenterWithViewController:[AppDelegate sharedDelegate].viewController];

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
