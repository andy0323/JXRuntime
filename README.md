# JXRuntime

## 提供Api

### 更换对象的类

	- (void)setClass:(Class)myClass;

### 获取对象所属类所有方法

	- (void)getAllMethods:(void (^)(NSArray *methods))block;

### 获取对象所属类所有属性

	- (void)getAllProperties:(void (^)(NSDictionary *properties))block;

### 覆盖对象所属类方法

	- (void)replaceMethod:(SEL)method by:(IMP)replaceMethod types:(const char *)types;

### 替换对象方法

	- (void)exchangeMethod:(SEL)method by:(SEL)exchangeMethod from:(NSObject *)target;
	
## Contact

**author:** Andy Jin  
**Email:** andy_ios@163.com

##Licenses

All source code is licensed under the [MIT License](https://github.com/andy0323/JXAddressBook/blob/master/LICENSE).

