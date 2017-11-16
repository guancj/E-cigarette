//
//  ECCommunication.h
//  E-cigarette
//
//  Created by 有限公司 深圳市 on 2017/10/28.
//  Copyright © 2017年 SMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, command){
    COMMAND_TEMP_UP            = 0x10,
    COMMAND_TEMP_DOWN          = 0x15,
    COMMAND_TIME_LOOP          = 0X17,
};

@interface ECCommunication : NSObject
+ (instancetype)shareCommunication;
- (void)sendUtfData:(NSData *)data commandState:(command)state;
@end
