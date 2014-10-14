//
//  AXResolvedAddress.h
//  Pods
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AXResolvedAddressType) {
  AXResolvedAddressUnknown = -1,
  AXResolvedAddressIPv4 = 0,
  AXResolvedAddressIPv6
};

@interface AXResolvedAddress : NSObject
@property (readonly, copy, nonatomic) NSData *data;
@property (readonly, copy, nonatomic) NSString *host;
@property (readonly, nonatomic) int port;
@property (readonly, nonatomic) AXResolvedAddressType type;
- (id)initWithHost:(NSString *)host port:(int)port type:(AXResolvedAddressType)type data:(NSData *)data;
+ (NSArray *)addressesWithNetServiceAddresses:(NSArray *)netServiceAddresses;
@end
