<!--
 * @Github: https://github.com/Certseeds/tricks
 * @Organization: SUSTech
 * @Author: nanoseeds
 * @Date: 2020-03-26 11:25:52
 * @LastEditors: nanoseeds
 * @LastEditTime: 2020-03-26 12:07:55
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
build a `file-header.py` in include and add it in py pyunit.  
#### `File-Header.py`
``` python
#!/usr/bin/env python3
# coding=utf-8
"""
@Github: https://github.com/Certseeds
@Organization: SUSTech
@Author: ${USER}
@Date: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:${SECOND} 
@LastEditors  : ${USER}
"""
```
#### `LICENSE.py`
``` python
""" ${PROJECT_NAME} 
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
"""
```
## Encode
1. File-setting-Editor-File_Encodings all set to UTF-8