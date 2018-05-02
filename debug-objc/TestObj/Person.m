//
//  Person.m
//  objc
//
//  Created by 蓝布鲁 on 2016/12/29.
//
//

#import "Person.h"

@interface Person ()


@end

@implementation Person

+ (void)load {
    
}

+(NSString *)species{
    return @"Person";
}

-(void)sayHello{
    NSLog(@"!!!");
}
- (Person *)person {
    Person *person = [[Person alloc] init];
    return person;
}

- (void)person1 {
    Person *person = [[Person alloc] init];
}

@end


@implementation Son
@end
@implementation Father
@end
