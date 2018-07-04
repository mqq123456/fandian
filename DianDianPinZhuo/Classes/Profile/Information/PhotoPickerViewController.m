//
//  PhotoPickerViewController.m
//  WisdomTree
//
//  Created by zyj on 14-3-12.
//  Copyright (c) 2014年 hyww. All rights reserved.
//

#import "PhotoPickerViewController.h"

@interface PhotoPickerViewController (Private)
- (UIImagePickerController *)imagePicker;
- (void)showWithCamera;
- (void)showWithPhotoLibrary;
@end

@implementation PhotoPickerViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithDelegate:(id)delegate IsCamera:(BOOL) isCamera IsEdit:(BOOL)isedit
{
    if(!(self=[super initWithNibName:nil bundle:nil]))
    {
        return self;
    }
    
    if(self)
    {
        delegate_ = delegate;
        isFromCamera_ = isCamera;
        isEdit = isedit;
        if(isCamera)
        {
            [self  showWithCamera];
        }
        else
        {
            [self showWithPhotoLibrary];
        }
    }
    return self;
}

- (void)showWithCamera
{
    isFromCamera_=YES;
    [[self imagePicker] setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self showImagePicker];
}

- (void)showWithPhotoLibrary
{
    isFromCamera_=NO;
    [[self imagePicker] setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self showImagePicker];
}

- (void)showImagePicker
{
    if([delegate_ respondsToSelector:@selector(presentModalViewController:animated:)])
    {
        [delegate_ presentModalViewController:imagePicker_ animated:YES];
    }
}

- (UIImagePickerController *)imagePicker
{
    if(imagePicker_)
    {
        return imagePicker_;
    }
    
    imagePicker_=[[UIImagePickerController alloc] init];
    [imagePicker_ setDelegate:self];
    if( isEdit )
    {
        [imagePicker_ setAllowsEditing:YES];
    }
    else
    {
        [imagePicker_ setAllowsEditing:NO];
    }
    return imagePicker_;
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *newImage;
    if(isEdit)
    {
         newImage=[info objectForKey:UIImagePickerControllerEditedImage];
    }
    else
    {
        newImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    }
   
    UIImage * reImg = [self fixOrientation:newImage];
    
    if ([delegate_ respondsToSelector:@selector(didFinishPickingWithImage:isFromCamera:)])
    {
        [delegate_  didFinishPickingWithImage:/*newImage */reImg isFromCamera:isFromCamera_ ];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [delegate_ PhotoPickerCancel];
}


- (UIImage *)fixOrientation:(UIImage *)srcImg
{
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
