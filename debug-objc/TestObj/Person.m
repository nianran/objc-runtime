//
//  Person.m
//  objc
//
//  Created by 蓝布鲁 on 2016/12/29.
//
//

#import "Person.h"

@interface Person() {
    @private
    NSString *privateString;
}

@property (class, nonatomic, strong) NSString *classString;
@property (nonatomic, strong) NSString *extsionString;


@end

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        self.strongString = @"kfjahsdjfhkajshdfhksjhdfkjsahdfhkjshkfjshdjfkhskjhfkajshfsdfhkjh";
        self.weakString = self.strongString;
    }
    return self;
}

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

- (void)person2 {
    __weak Person *person = [[Person alloc] init];
}

@end


@implementation Son
@end
@implementation Father
@end
