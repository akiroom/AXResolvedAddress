//
//  AXResolvedAddress.m
//  Pods
//

#import "AXResolvedAddress.h"
#import <arpa/inet.h>

@implementation AXResolvedAddress

- (id)initWithHost:(NSString *)host port:(int)port type:(AXResolvedAddressType)type data:(NSData *)data
{
  if (self = [super init]) {
    _host = [host copy];
    _port = port;
    _type = type;
    _data = [data copy];
  }
  return self;
}

+ (NSArray *)addressesWithNetServiceAddresses:(NSArray *)netServiceAddresses
{
  NSMutableArray *array = [NSMutableArray array];
  
  NSString *currentHost;
  int currentPort;
  AXResolvedAddressType currentType;
  
  char addressBuffer[INET6_ADDRSTRLEN];
  for (NSData *data in netServiceAddresses) {
    currentHost = nil;
    currentPort = 0;
    currentType = AXResolvedAddressUnknown;
    memset(addressBuffer, 0, INET6_ADDRSTRLEN);
    
    typedef union {
      struct sockaddr sa;
      struct sockaddr_in ipv4;
      struct sockaddr_in6 ipv6;
    } ip_socket_address;
    
    ip_socket_address *socketAddress = (ip_socket_address *)[data bytes];
    
    if (socketAddress && (socketAddress->sa.sa_family == AF_INET || socketAddress->sa.sa_family == AF_INET6)) {
      // When IPv4 / IPv6
      
      const char *addressStr = inet_ntop(socketAddress->sa.sa_family,
                                         (socketAddress->sa.sa_family == AF_INET ? (void *)&(socketAddress->ipv4.sin_addr) : (void *)&(socketAddress->ipv6.sin6_addr)),
                                         addressBuffer,
                                         sizeof(addressBuffer));
      
      int port = ntohs(socketAddress->sa.sa_family == AF_INET ? socketAddress->ipv4.sin_port : socketAddress->ipv6.sin6_port);
      
      switch (socketAddress->sa.sa_family) {
        case AF_INET:
          currentType = AXResolvedAddressIPv4;
          break;
        case AF_INET6:
          currentType = AXResolvedAddressIPv6;
          break;
        default:
          break;
      }
      
      if (addressStr && port) {
        currentHost = [NSString stringWithFormat:@"%s", addressStr];
        currentPort = port;
        NSLog(@"Found service at %s:%d", addressStr, port);
      }
    }
    [array addObject:
     [[AXResolvedAddress alloc]
      initWithHost:currentHost port:currentPort type:currentType data:data]];
  }
  
  return array;
}

@end
