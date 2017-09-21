//
//  IndexViewController.m
//  SmarTree_2017Summer
//
//  Created by Leonard Lee on 20/09/2017.
//  Copyright © 2017 Appkoder. All rights reserved.
//

#import "IndexViewController.h"
@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAboutClicked:(id)sender {
    // Create the reader object
//    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
//    
//    // Instantiate the view controller
//    QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:_reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
//    
//    // Set the presentation style
//    _vc.modalPresentationStyle = UIModalPresentationFormSheet;
//    
//    // Define the delegate receiver
//    _vc.delegate = self;
//    
//    // Or use blocks
//    [_reader setCompletionWithBlock:^(NSString *resultAsString) {
//        NSLog(@"%@", resultAsString);
//    }];
}
@end
