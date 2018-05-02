
//  main.m
//  debug-objc
//
//  Created by closure on 2/24/16.
//
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
            Person *person = [[Person alloc] init];
            [person performSelector:@selector(sayHello)];
    
            NSLog(@"%@",[Person performSelector:@selector(species)]);
            NSString *string = [NSString new];
            testRetainCount();
            // objc_autoreleasePoolPop(context)
    }
    return 0;
}

void testRetainCount(void) {
        RetainCount *obj = [[RetainCount alloc] init];
        [obj retainStrongObj];
        [obj description];
    
    
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
