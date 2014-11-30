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
}

-(void)dealloc
{
    _cellLabel = nil;
    
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



@end
