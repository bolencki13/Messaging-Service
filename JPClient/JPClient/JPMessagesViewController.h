//
//  JPMessagesViewController.h
//  JPClient
//
//  Created by Brian Olencki on 5/8/16.
//  Copyright © 2016 bolencki13. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessages.h>

@interface JPMessagesViewController : JSQMessagesViewController
@property (nonatomic, retain, readonly) NSString *ipaddress;
@property (nonatomic, retain, readonly) NSString *port;
- (instancetype)initWithIPAddress:(NSString*)ipAddress withPort:(NSString*)port;
@end
