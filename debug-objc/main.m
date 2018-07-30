//
//  main.m
//  debug-objc
//
//  Created by Closure on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "objc-runtime.h"
#import "RetainCount.h"

// define
void testRetainCount(void);

int main(int argc, const char * argv[]) {
        // 只是往其中塞了push操作只是往其中放了一个哨兵对象
        // void *context = objc_autoreleasePoolPush();
    @autoreleasepool {
        typedef void (^blk_t)(id);
        blk_t blk;
        {
            id array = [[NSMutableArray alloc] init];
            blk = ^(id obj){
                [array addObject:obj];
                NSLog(@"array count: = %zd",[array count]);
            };
        }
        
        blk([[NSObject alloc] init]);
        blk([[NSObject alloc] init]);
        Person *person = [[Person alloc] init];
        [person performSelector:@selector(sayHello)];
        person.string7 = @"";

        NSLog(@"%@",[Person performSelector:@selector(species)]);
        NSString *string = [NSString new];
        testRetainCount();
    
    

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 测试autoreleasepool
            @autoreleasepool {
                RetainCount *countDown = [[RetainCount alloc] init];
                
            }
        });
        
        
        NSMapTable *mapTable = [NSMapTable weakToStrongObjectsMapTable];
        

        
        // objc_autoreleasePoolPop(context)
    }
    return 0;
}

void testRetainCount(void) {
    RetainCount *obj = [[RetainCount alloc] init];
    [obj retainStrongObj];
    [obj description];
}

void testAutoRelease() {
    NSNumber *number = @(1);
    NSArray *array = [NSArray arrayWithObjects:number, nil];
}

void testPerson() {
    Person *person = [[Person alloc] init];
    person.string3 = @"1";
    person.string4 = @"2";
}


#pragma mark - RACSwizzle

void RACSwizzleGetClass(Class class, Class statedClass) {
    SEL selector = @selector(class);
    Method method = class_getInstanceMethod(class, selector);
    IMP newIMP = imp_implementationWithBlock(^(id self) {
            return statedClass;
        });
    class_replaceMethod(class, selector, newIMP, method_getTypeEncoding(method));
}

void testRACSwizzle() {
    id son_before = [Son class];
    id son_meta_before = object_getClass(son_before);
    id fater_before = [Father class];
    id father_meta_before = object_getClass(fater_before);
    id object_before = [NSObject class];
    id object_meta_before = [NSObject class];

    IMP class_instance_before = [[Son new] methodForSelector:@selector(class)];
    IMP class_class_before = [son_before methodForSelector:@selector(class)];
    IMP class_meta_class_before = [object_getClass([son_meta_before class])  methodForSelector:@selector(class)];
    IMP fater_class_before = [fater_before methodForSelector:@selector(class)];


    NSLog(@"before: %p",[[Son new] class]);
    NSLog(@"after: %p",[Son class]);
    NSLog(@"before: %p",object_getClass([son_meta_before class]));

    RACSwizzleGetClass(son_before, fater_before);
    RACSwizzleGetClass(son_meta_before, fater_before);
    RACSwizzleGetClass(object_getClass([son_meta_before class]), fater_before);


    NSLog(@"after: %p",[[Son new] class]);
    NSLog(@"after: %p",[Son class]);
    NSLog(@"before: %p",object_getClass([son_meta_before class]));



    id son_after = [Son class];
    id son_meta_after = object_getClass(son_after);
    id fater_after = [Father class];
    id father_meta_after = object_getClass(fater_after);
    id object_after = [NSObject class];
    id object_meta_after = [NSObject class];

    IMP class_instance_after = [[Son new] methodForSelector:@selector(class)];
    IMP class_class_after = [son_before methodForSelector:@selector(class)];
    IMP class_meta_class_after = [object_getClass([son_meta_before class])  methodForSelector:@selector(class)];
    IMP fater_class_after = [fater_before methodForSelector:@selector(class)];
}
