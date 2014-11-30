//
//  JSQCall.m
//  JSQMessages
//
//  Created by Dylan Bourgeois on 20/11/14.
//

#import "JSQCall.h"

#import "JSQMessagesTimestampFormatter.h"
#import "UIImage+JSQMessages.h"

@implementation JSQCall

#pragma mark - Initialzation

-(instancetype)initWithCallerId:(NSString *)senderId
              callerDisplayName:(NSString *)senderDisplayName
                           date:(NSDate *)date
                       duration:(long)durationInSeconds
                         status:(CallStatus)status
{
    NSParameterAssert(senderId != nil);
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(date != nil);
    
    self = [super init];
    if (self) {
        _senderId = [senderId copy];
        _senderDisplayName = [senderDisplayName copy];
        _date = [date copy];
        _duration = durationInSeconds;
        _status = status;
    }
    return self;
}

-(id)init
{
    NSAssert(NO,@"%s is not a valid initializer for %@. Use %@ instead", __PRETTY_FUNCTION__, [self class], NSStringFromSelector(@selector(initWithCallerId:callerDisplayName:date:duration:status:)));
    return nil;
}

-(void)dealloc
{
    _senderId = nil;
    _senderDisplayName = nil;
    _date = nil;
    _duration = 0;
    _status = kCallNone;
}

-(NSString*)text
{
    switch (self.status) {
        case kCallNone:
            return nil;
            break;
        case kCallFailed:
            return [NSString stringWithFormat:@"Your call to %@ failed.",_senderDisplayName];
            break;
        case kCallMissed:
            return [NSString stringWithFormat:@"You missed a call from %@.", _senderDisplayName];
            break;
        case kCallIncoming:
            return [NSString stringWithFormat:@"You called %@.", _senderDisplayName];
            break;
        case kCallOutgoing:
            return [NSString stringWithFormat:@"You received a call from %@.", _senderDisplayName];
            break;
            
        default:
            return nil;
            break;
    }
}

-(UIImage*)thumbnailImage
{
    switch (self.status) {
        case kCallNone:
            return nil;
            break;
        case kCallFailed:
            return [UIImage imageNamed:@"call_failed"];
            break;
        case kCallMissed:
            return [UIImage imageNamed:@"call_missed"];
            break;
        case kCallIncoming:
            return [[UIImage imageNamed:@"call_incoming"] jsq_imageMaskedWithColor:[UIColor darkGrayColor]];
            break;
        case kCallOutgoing:
            return [[UIImage imageNamed:@"call_outgoing"] jsq_imageMaskedWithColor:[UIColor darkGrayColor]];
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - NSObject

-(BOOL)isEqual:(id)object
{
    if (self==object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]])
    {
        return NO;
    }
    
    JSQCall * aCall = (JSQCall*)object;
    
    return [self.senderId isEqualToString:aCall.senderId]
            && [self.senderDisplayName isEqualToString:aCall.senderDisplayName]
            && ([self.date compare:aCall.date] == NSOrderedSame)
            && self.duration == aCall.duration
            && self.status == aCall.status;
}

-(NSUInteger)hash
{
    return self.senderId.hash ^ self.date.hash;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"<%@: senderId=%@, senderDisplayName=%@, date=%@, duration=%ld,>",
            [self class], self.senderId, self.senderDisplayName, self.date, self.duration];
}

#pragma mark - NSCoding

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _senderId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderId))];
        _senderDisplayName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderDisplayName))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _duration = [aDecoder decodeDoubleForKey:NSStringFromSelector(@selector(duration))];
        _status = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(status))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.senderId forKey:NSStringFromSelector(@selector(senderId))];
    [aCoder encodeObject:self.senderDisplayName forKey:NSStringFromSelector(@selector(senderDisplayName))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeInteger:self.duration forKey:NSStringFromSelector(@selector(duration))];
    [aCoder encodeDouble:self.status forKey:NSStringFromSelector(@selector(status))];
}

#pragma mark - NSCopying

-(instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone]initWithCallerId:self.senderId
                                            callerDisplayName:self.senderDisplayName
                                                         date:self.date
                                                     duration:self.duration
                                                       status:self.status];
}



@end
