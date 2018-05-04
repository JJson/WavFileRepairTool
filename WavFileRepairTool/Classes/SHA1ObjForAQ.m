//
//  SHA1ObjForAQ.m
//
//
//  Created by linjj on 2017/8/30.
//
//

#import "SHA1ObjForAQ.h"
#import <CommonCrypto/CommonDigest.h>
@interface SHA1ObjForAQ()
@property(nonatomic)CC_SHA1_CTX hashObject;//    CC_MD5_CTX hashObject;
@property(nonatomic)CFStringRef result;
@end
@implementation SHA1ObjForAQ
- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialize the hash object
        
        _result = NULL;
        CC_SHA1_Init(&_hashObject);
    }
    return self;
}
- (void)updateSha1ForNewBuff:(const void *)buff length:(NSInteger)length
{
    if (buff == NULL || length == 0) {
        return;
    }
    CC_SHA1_Update(&_hashObject, (const void *)buff, (CC_LONG)length);
}

- (NSString *)getResult
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(digest, &_hashObject);
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    NSString * result = [[NSString alloc] initWithBytes:hash length:sizeof(hash)-1 encoding:kCFStringEncodingUTF8];
    return result;
}

- (void)dealloc
{
    
}

@end
