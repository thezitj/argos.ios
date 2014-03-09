//
//  ARSnippetCollectionViewCell.m
//  Argos
//
//  Created by Francis Tseng on 2/28/14.
//  Copyright (c) 2014 Argos. All rights reserved.
//



#import "ARSnippetCollectionViewCell.h"

@implementation ARSnippetCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float xPadding = 10;
        float yPadding = 20;
        
        float textLabelHeight = 50;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, self.frame.size.height - textLabelHeight - yPadding, self.frame.size.width - 2*xPadding, textLabelHeight)];
        self.textLabel.numberOfLines = 4;
        self.textLabel.font = [UIFont mediumFontForSize:12];
        self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.textLabel];
        
        // Reposition the title label accordingly.
        CGRect titleFrame = self.titleLabel.frame;
        titleFrame.origin.y = self.textLabel.frame.origin.y - titleFrame.size.height;
        self.titleLabel.frame = titleFrame;
    }
    return self;
}

- (void)setImageForEntity:(id<AREntity>)entity
{
    id <AREntityWithLargeImage> entityWithLargeImage = (id<AREntityWithLargeImage>)entity;
    if (!entityWithLargeImage.imageLarge) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImage *croppedImage = [self cropImage:entity.image];
            entityWithLargeImage.imageLarge = croppedImage;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = entityWithLargeImage.imageLarge;
            });
        });
    } else {
        self.imageView.image = entityWithLargeImage.imageLarge;
    }
}

@end