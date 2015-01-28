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
                         status:(CallStatus)status
{
    NSParameterAssert(senderId != nil);
    NSParameterAssert(senderDisplayName != nil);
    
    self = [super init];
    if (self) {
        _senderId = [senderId copy];
        _senderDisplayName = [senderDisplayName copy];
        _date = [date copy];
        _status = status;
        _messageType = TSCallAdapter;
        
    }
    return self;
}

-(id)init
{
    NSAssert(NO,@"%s is not a valid initializer for %@. Use %@ instead", __PRETTY_FUNCTION__, [self class], NSStringFromSelector(@selector(initWithCallerId:callerDisplayName:date:status:)));
    return nil;
}

-(void)dealloc
{
    _senderId = nil;
    _senderDisplayName = nil;
    _date = nil;
}

-(NSString*)text
{
    NSString *name = _senderDisplayName;
    
    switch (self.status) {
        case kCallMissed:
            return [NSString stringWithFormat:@"Missed call from %@. ", name];
        case kCallIncoming:
            return [NSString stringWithFormat:@"You received a call from %@. ", name];
        case kCallOutgoing:
            return [NSString stringWithFormat:@"You called %@. ", name];
        default:
            return nil;
            break;
    }
}

-(NSString*)dateText
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.doesRelativeDateFormatting = YES;
    return [dateFormatter stringFromDate:_date];
}

-(UIImage*)thumbnailImage {
    // This relies on those assets being in the project
    if(!_useThumbnail) {
        return nil;
    }
    switch (_status) {
        case kCallOutgoing:
            return [UIImage imageNamed:@"statCallOutgoing--blue"];
            break;
        case kCallIncoming:
        case kCallMissed:
            return [UIImage imageNamed:@"statCallIncoming--blue"];
            break;
        case kGroupUpdate:
            return [UIImage imageNamed:@"statRefreshedGroup--blue"];
            break;
        case kGroupUpdateLeft:
            return [UIImage imageNamed:@"statLeftGroup--blue"];
            break;
        case kGroupUpdateJoin:
            return [UIImage imageNamed:@"statJoinedGroup--blue"];
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
            && self.status == aCall.status;
}

-(NSUInteger)hash
{
    return self.senderId.hash ^ self.date.hash;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"<%@: senderId=%@, senderDisplayName=%@, date=%@>",
            [self class], self.senderId, self.senderDisplayName, self.date];
}

#pragma mark - NSCoding

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _senderId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderId))];
        _senderDisplayName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderDisplayName))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _status = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(status))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.senderId forKey:NSStringFromSelector(@selector(senderId))];
    [aCoder encodeObject:self.senderDisplayName forKey:NSStringFromSelector(@selector(senderDisplayName))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeDouble:self.status forKey:NSStringFromSelector(@selector(status))];
}

#pragma mark - NSCopying

-(instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone]initWithCallerId:self.senderId
                                            callerDisplayName:self.senderDisplayName
                                                         date:self.date
                                                       status:self.status];
}



@end
