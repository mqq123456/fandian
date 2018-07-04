//
//  PhotoPickerViewController.h
//  WisdomTree
//
//  Created by zyj on 14-3-12.
//  Copyright (c) 2014年 hyww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPickerViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate >
{
    id delegate_;
    UIImagePickerController *imagePicker_;
    BOOL isFromCamera_;
    
    BOOL isEdit;
}

- (id)initWithDelegate:(id)delegate IsCamera:(BOOL) isCamera IsEdit:(BOOL)isedit;

@end

@protocol PhotoPickerControllerDelegate <NSObject>

@optional
- (void)didFinishPickingWithImage:(UIImage *)image isFromCamera:(BOOL)isFromCamera;
-(void) PhotoPickerCancel;

@end;

