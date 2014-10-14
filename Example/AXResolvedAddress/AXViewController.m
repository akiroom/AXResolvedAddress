//
//  AXViewController.m
//  AXResolvedAddress
//

#import "AXViewController.h"
#import <AXResolvedAddress/AXResolvedAddress.h>

@interface AXViewController () <NSNetServiceBrowserDelegate, NSNetServiceDelegate>
@property (strong, nonatomic) NSNetServiceBrowser *netServiceBrowser;
@property (strong, nonatomic) NSNetService *netService;
@end

@implementation AXViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  
  // Search http services.
  _netServiceBrowser = [[NSNetServiceBrowser alloc] init];
  _netServiceBrowser.delegate = self;
  [_netServiceBrowser searchForServicesOfType:@"_http._tcp" inDomain:nil];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

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

@end
