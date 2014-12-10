//
//  JSQDisplayedMessageCollectionViewCell.h
//  JSQMessages
//
//  Created by Dylan Bourgeois on 29/11/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSQMessagesLabel.h"

#define kDisplayedMessageCellTextLabelHeight 50.0f
#define kDisplayedMessageCellHeight 70.0f
#define kDisplayedMessageCellWidth 200.0f

@class JSQDisplayedMessageCollectionViewCell;

@protocol JSQDisplayedCollectionViewCellDelegate <NSObject>

@required


/**
 *  Tells the delegate that the error/info message bubble has been tapped.
 *
 *  @param cell The cell that received the tap touch event.
 */

- (void)displayedCollectionViewCellDidTapMessage:(JSQDisplayedMessageCollectionViewCell *)cell;


@end

@interface JSQDisplayedMessageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) JSQMessagesLabel * cellLabel;

@property (weak, nonatomic, readonly) UIImageView * headerImageView;

@property (weak, nonatomic) id<JSQDisplayedCollectionViewCellDelegate> delegate;

#pragma mark - Class methods

+ (UINib *) nib;

+ (NSString *) cellReuseIdentifier;

@end
