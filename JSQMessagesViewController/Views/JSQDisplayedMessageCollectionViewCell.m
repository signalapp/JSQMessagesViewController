//
//  JSQDisplayedMessageCollectionViewCell.m
//  JSQMessages
//
//  Created by Dylan Bourgeois on 29/11/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQDisplayedMessageCollectionViewCell.h"

#import "UIView+JSQMessages.h"

@interface JSQDisplayedMessageCollectionViewCell ()

@property(weak, nonatomic) IBOutlet JSQMessagesLabel* cellLabel;

@property(weak, nonatomic) IBOutlet NSLayoutConstraint* cellLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView* headerImageView;

- (void)jsq_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant;

@end

@implementation JSQDisplayedMessageCollectionViewCell

#pragma mark - Class Methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

#pragma mark - Initializer

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    self.cellLabelHeightConstraint.constant = 0.0f;
    
    self.cellLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.cellLabel.layer.borderWidth = 0.75f;
    self.cellLabel.layer.cornerRadius = 5.0f;
    self.cellLabel.textAlignment = NSTextAlignmentCenter;
    self.cellLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
    self.cellLabel.textColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleTapGesture:)];
    [self addGestureRecognizer:tap];

}

-(void)dealloc
{
    _cellLabel = nil;
    
    _delegate = nil;
    
    
}

#pragma mark - Collection view cell

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.cellLabel.text = nil;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    [self jsq_updateConstraint:self.cellLabelHeightConstraint
                  withConstant:kDisplayedMessageCellTextLabelHeight];
    
}


#pragma mark - Utilities

- (void)jsq_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant
{
    if (constraint.constant == constant) {
        return;
    }
    
    constraint.constant = constant;
}

#pragma mark - Gesture recognizers

-(void)jsq_handleTapGesture:(UITapGestureRecognizer *)tap
{
    CGPoint touchPoint = [tap locationInView:self];
    
    if (CGRectContainsPoint(self.contentView.frame, touchPoint))
    {
        [self.delegate displayedCollectionViewCellDidTapMessage:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPt = [touch locationInView:self];
    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return CGRectContainsPoint(self.contentView.frame, touchPt);
    }
    
    return YES;
}


@end
