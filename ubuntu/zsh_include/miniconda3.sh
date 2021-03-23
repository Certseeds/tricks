
###
 # @Github: https://github.com/Certseeds/tricks
 # @Organization: SUSTech
 # @Author: nanoseeds
 # @Date: 2021-03-23 18:51:23
 # @LastEditors: nanoseeds
 # @LastEditTime: 2021-03-23 18:56:33
### 
__conda_setup="$('${HOME}/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
        . "${HOME}/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup