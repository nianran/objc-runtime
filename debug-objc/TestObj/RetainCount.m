//
//  RetainCount.m
//  debug-objc
//
//  Created by Hongzhi Zhao on 2018/4/19.
//

#import "RetainCount.h"
#import "Person.h"
#import "objc/runtime.h"

typedef NS_ENUM(NSUInteger, RetainCountEnum) {
    RetainCountEnumA,
    RetainCountEnumB,
    RetainCountEnumC,
};

@interface RetainCount(){
    int count;
}
@property (nonatomic, strong) NSMutableArray *objArray;
@property (nonatomic, strong) Person *strongObj;
@property (nonatomic, weak, nullable) NSObject *weakObj;
@property (nonatomic, assign) RetainCountEnum emun;
@property (nonatomic, unsafe_unretained) NSObject *unsafeObj;

@end

@implementation RetainCount

- (instancetype)init {
    if (self = [super init]) {
        self.objArray = [[NSMutableArray alloc] init];
        self.strongObj = [Person new];
//        [self retainStrongObj];
//        [self retainAssociateStrongObj];
        
        // 期望数量
        // 1. count函数内部会有一个计数 +1 这个不清楚 TODO:
        // 2. 当前实例[Person new]并没有被释放 + 1
        // 3. self.strongObj持有了 + 1
        int totoalCount = 516 - 3;
        for (int i = 0; i < totoalCount; i ++) {
            [self retainStrongObj];
        }
    }
    return self;
}

- (void)retainStrongObj {
    [self.objArray addObject:self.strongObj];
}

- (void)retainAssociateStrongObj {
    count ++;
    char str[2];
    sprintf(str,"%d",count);
    objc_setAssociatedObject(self, str, self.strongObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWeakableObj {
    self.weakObj = [[NSObject alloc] init];
}

- (NSString *)description {
    NSInteger retainCount = _objc_rootRetainCount(self.strongObj);
    for (Person *person in self.objArray) {
        NSLog(@"%p",person);
    }
    return [NSString stringWithFormat:@"strongObj retainCount:%ld \n",retainCount];
}


@end
