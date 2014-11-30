//
//  JSQCallCollectionViewCell.m
//  JSQMessages
//
//  Created by Dylan Bourgeois on 20/11/14.
//

#import "JSQCallCollectionViewCell.h"

#import "UIView+JSQMessages.h"


@interface JSQCallCollectionViewCell ()

@property (weak, nonatomic) IBOutlet JSQMessagesLabel *cellLabel;

@property (weak, nonatomic) IBOutlet UIImageView *outgoingCallImageView;

@property (weak, nonatomic) IBOutlet UIImageView *incomingCallImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellLabelHeightConstraint;

- (void)jsq_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant;

@end

@implementation JSQCallCollectionViewCell

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
                  withConstant:kCallCellHeight];
    
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
