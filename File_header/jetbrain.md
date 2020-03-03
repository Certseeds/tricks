"setting"-"editor"-"file-and-code-templates"-"include"
add it to the File-header.
last edit time can not auto change,
but can add live template to save times.
```
$DATE$ $TIME$
date("yyyy-MM-dd")
date("HH:mm:ss")
```

java:
``` java
/**
 * @Github: https://github.com/Certseeds
 * @Organization: SUSTech
 * @Author: ${USER}
 * @Date: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND} 
 * @LastEditors  : ${USER}
 * @LastEditTime : ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND} 
*/

``` 

python: 
build a file-header.py in include and add it in py pyunit. 
``` python
#!/usr/bin/env python3
# coding=utf-8
"""
@Github: https://github.com/Certseeds
@Organization: SUSTech
@Author: ${USER}
@Date: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND} 
@LastEditors  : ${USER}
@LastEditTime : ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND} 
"""
```