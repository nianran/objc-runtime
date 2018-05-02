//
//  Person.h
//  objc
//
//  Created by 蓝布鲁 on 2016/12/29.
//
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    NSString *_string1;
    NSString *_string2;
}
@property (nonatomic, strong) NSString *string3;
@property (nonatomic, copy) NSString *string4;
@property (nonatomic, unsafe_unretained) NSString *string5;
@property (nonatomic) NSString *string6;


@property (nonatomic) NSInteger int1;
@property (nonatomic) char achar;



+(NSString *)species;
-(void)sayHello;

@end

@interface Son :NSObject
@end
@interface Father :NSObject
@end
