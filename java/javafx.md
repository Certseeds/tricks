<!--
 * @Github: https://github.com/Certseeds/tricks
 * @Organization: SUSTech
 * @Author: nanoseeds
 * @Date: 2020-03-17 21:09:25
 * @LastEditors: nanoseeds
 * @LastEditTime: 2020-03-18 00:42:52
 java,javafx,idea.
 -->
1. download the javafx and javafxmod from https://gluonhq.com/products/javafx/
2. unpack and place it in where openjdk in.
3. in idea,Project-Structure/Libiaries/"`javafx-sdk-11.0.2/lib`"
4. in idea,setting,Path variables,add key:value pair "`PATH_TO_FX`: `absoluted path javafx`"
5. add `--module-path ${PATH_TO_FX} --add-modules javafx.controls,javafx.fxml`
6. finish, it can run.
7. *I dont konw why, when i use maven to add javafx , it always report `Exception in Application start method even i add / before the path or do otherthings as the stackoverflow say,wtf?`*




another way is that:
1. 使用maven,引入本地库,并确保scope为system,各自添加systemPath
2. 同上4,5,6部.