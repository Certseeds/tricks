1. 头文件中添加必要的

``` cpp
#ifndef _NAME_H_
#define _NAME_H_
#endif
```

2. 不使用using namespace std等,使用形为using std::cout的语句.
3. 后缀规范

| 类型           | 后缀 |
| :------------- | ---: |
| 头文件(无实现) |      |
| 宏,预编译指令  |   .h |
| 源文件         | .cpp |
| 纯C_源文件     |   .c |
| 头文件with实现 |      |
| 模板类         | .hpp |

4. 尽量使用形如uint32_t的变量类型,指定长度.