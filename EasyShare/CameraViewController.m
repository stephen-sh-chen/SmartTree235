//
//  CameraViewController.m
//  SmarTree_2017Summer
//
//  Created by Leonard Lee on 19/09/2017.
//  Copyright © 2017 Appkoder. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Camera";
    self.navigationController.navigationBar.translucent = NO;
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(logout)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - Image Picker Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImg = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = chosenImg;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//Save photos in the album and return message
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *alertTitle;
    NSString *alertMessage;
    if(error) {
        alertTitle   = @"Error";
        alertMessage = @"Unable to save to photo album";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMessage
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Gesture Recognizer -


#pragma mark - Button Click Event
- (IBAction)btnAlbum:(id)sender {
    UIImagePickerController *photoPickerController = [[UIImagePickerController alloc] init];
    photoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoPickerController.allowsEditing = NO;
    photoPickerController.delegate = self;
    [self presentViewController:photoPickerController animated:YES completion:nil];
}

- (IBAction)btnCamera:(id)sender {
    UIImagePickerController *cameraPickerController = [[UIImagePickerController alloc] init];
    cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraPickerController.allowsEditing = NO;
    cameraPickerController.delegate = self;
    [self presentViewController:cameraPickerController animated:YES completion:nil];
}

@end
