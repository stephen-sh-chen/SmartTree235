//
//  CameraViewController.h
//  SmarTree_2017Summer
//
//  Created by Leonard Lee on 19/09/2017.
//  Copyright © 2017 Appkoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)btnAlbum:(id)sender;
- (IBAction)btnCamera:(id)sender;
@end
