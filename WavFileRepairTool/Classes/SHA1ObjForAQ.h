//
//  SHA1ObjForAQ.h
//  
//
//  Created by linjj on 2017/8/30.
//
//

#import <Foundation/Foundation.h>

@interface SHA1ObjForAQ : NSObject
-(void)updateSha1ForNewBuff:(const void *)buff length:(NSInteger)length;
-(NSString *)getResult;
@end
