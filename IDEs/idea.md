<!--
 * @Github: https://github.com/Certseeds/tricks
 * @Organization: SUSTech
 * @Author: nanoseeds
 * @Date: 2020-03-26 10:04:50
 * @LastEditors: nanoseeds
 * @LastEditTime: 2020-04-18 17:33:17
 -->
## FileHeader
### Live Template
"setting"-"editor"-"file-and-code-templates"-"include"
add it to the File-header.
last edit time can not auto change,
but can add live template to save times.
``` VHL
$DATE$ $TIME$
// DATE: date("yyyy-MM-dd")
// TIME: date("HH:mm:ss")
```
### File and Code Templates
#### `File Header.java`
``` java 
/**
 * @Github: https://github.com/Certseeds/${PROJECT_NAME}
 * @Organization: SUSTech
 * @Author: ${USER}
 * @Date: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND} 
 * @LastEditors : ${USER}
 */
```
#### `LICENSE.java`
``` java
/*  ${PROJECT_NAME} 
    Copyright (C) ${YEAR}  ${USER}

    ${PROJECT_NAME} is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    ${PROJECT_NAME} is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
    */
```
## Encode
1. File-setting-Editor-File_Encodings all set to UTF-8
## Problem and Solution.
#### 1. Idea加载Project名加载错误
(常出现于有子模块时,识别文件名为子模块)
查看./idea/misc.xml,把子模块的Maven添加进ignoredFiles
egs:
``` xml
    <option name="originalFiles">
      <list>
        <option value="$PROJECT_DIR$/pom.xml" />
      </list>
    </option>
    <option name="ignoredFiles">
      <set>
        <option value="$PROJECT_DIR$/${SUBMODULE}/pom.xml" />
      </set>
    </option>
```
originFiles即为Project的pom.xml,ignoredFiles为想要忽略的.