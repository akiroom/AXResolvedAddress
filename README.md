# AXResolvedAddress

[![CI Status](http://img.shields.io/travis/Hiroki Akiyama/AXResolvedAddress.svg?style=flat)](https://travis-ci.org/Hiroki Akiyama/AXResolvedAddress)
[![Version](https://img.shields.io/cocoapods/v/AXResolvedAddress.svg?style=flat)](http://cocoadocs.org/docsets/AXResolvedAddress)
[![License](https://img.shields.io/cocoapods/l/AXResolvedAddress.svg?style=flat)](http://cocoadocs.org/docsets/AXResolvedAddress)
[![Platform](https://img.shields.io/cocoapods/p/AXResolvedAddress.svg?style=flat)](http://cocoadocs.org/docsets/AXResolvedAddress)

AXResolvedAddress is easy way to get NSNetService#addresses result.

```
NSNetService *netService;
[AXResolvedAddress addressesWithNetServiceAddresses:netService.addresses];
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Example

Get the list of http services.

```

NSNetServiceBrowser *_netServiceBrowser;
NSNetService *_netService;

// Search http services.
_netServiceBrowser = [[NSNetServiceBrowser alloc] init];
_netServiceBrowser.delegate = self;
[_netServiceBrowser searchForServicesOfType:@"_http._tcp" inDomain:nil];

#pragma mark - Net service browser delegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
  _netService = aNetService;
  _netService.delegate = self;
  [_netService resolveWithTimeout:3.0];
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender
{
  NSArray *addresses = [AXResolvedAddress addressesWithNetServiceAddresses:sender.addresses];
  for (AXResolvedAddress *address in addresses) {
    NSLog(@"---: %@", sender.name);
    NSLog(@"%@", address.host);
    NSLog(@"%d", address.port);
    switch (address.type) {
      case AXResolvedAddressIPv4:
        NSLog(@"IP v4");
        break;
      case AXResolvedAddressIPv6:
        NSLog(@"IP v6");
        break;
      default:
        NSLog(@"Unknown");
        break;
    }
  }
}
```

You can get output like this:

```
---: Foo bar WebAdmin (akiroom-MacBook-Air.local)
192.168.1.100
3000
IP v4
---: Foo bar WebAdmin (akiroom-MacBook-Air.local)
fe80::be8d:10ff:fe1d:2e30
3000
IP v6
---: Foo bar WebAdmin (akiroom-MacBook-Air.local)
240b:11:2510:1b01:ba8b:12fe:fe1a:6a60
3000
IP v6
```

## Installation

AXResolvedAddress is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "AXResolvedAddress"

## Author

Hiroki Akiyama, aki-hiroki@nifty.com

## License

AXResolvedAddress is available under the MIT license. See the LICENSE file for more info.
