# label4MRI: label MNI cooridnate with AAL & BA system
- ##### Under the R program environment,input an MNI coordinate, output the corresponding AAL(Automated Anatomical Labeling) and BA (Brodmann area) brain region name. More importantly, if the coordinate does not match a brain region defined by AAL/BA (e.g., white matter), the package help find the closest brain region with the corresponding distance.
&#13;&#10;
- ##### 在R程式語言中輸入MNI座標，輸出對應的AAL/BA腦區。

<English version instruction comes first. (中文版本說明在後方)>
#### CATALOG 
    1.Why and when do I need the package?
    2.How to use it?
    3.How to install it? Simple easy!
    4.Advanced issue: What if I have a hundred of MNI coordinates?
#### 目錄 
    1.何時我需要用到該套件呢 ?
    2.該怎麼使用該套件呢?
    3.如何安裝?非常簡單!
    4.進階議題:如果我有100個MNI座標呢?
 
### 1.Why and when do I need the package?
- Those who work with MRI (Magnetic resonance imaging) data **often want to know how dozens of MNI coordinates correspond to which anatomical brain regions  (e.g., [x = 18, y = -5, z = 20] belong to the brain region "Right Caudate")**. 

- However, to my knowledge, **all the free programs/tools with this feature are GUI-based(e.g. MRIcron, XJview,aal toolbox)**. That is, one need to manually key in/click on the interested MNI coordinate and manullay copy down the region name shown on the screen. **This could be quite tedious and time-consuming when one is dealing with dozens or more MNI coordiante. Yet, none available tools provide program-embedded code.**

- Therefore, **I create the R package "label4MRI" for MNI labeling.** 

 ### 2.How to use the label4MRI package?
 - #### **The Main Function: mni_to_region_name(x, y, z, distance = T, template = c("aal", "ba"))**
 
 - Input description: 
    - x, y, z : x,y,z value of the mni coordinate.
    - distance(default is T): If the MNI coordinate does not belong to any AAL/BA brain region (e.g. white matter, ventricle), then output the closest AAL/BA brain region name and the their distance (mm). When the MNI coordinate does fall into an AAL brain region, then output distance=0.
 - #### **Examples**
 - Example 1, when the mni coordinate has a corresponding region:
 ```
 > mni_to_region_name(x = 26, y = 0, z = 0)  
 
 $aal.distance
[1] 0

$aal.label
[1] "Putamen_R"

$ba.distance
[1] 0

$ba.label
[1] "Right-Putamen (49)"
 ```
 - Example 2, when the mni coordinate does NOT have a corresponding region:
 ```
 > mni_to_region_name(x = 0, y = 0, z = 0)  
 
$aal.distance
[1] 7.81025

$aal.label
[1] "Thalamus_L"

$ba.distance
[1] 4.242641

$ba.label
[1] "Left-Thalamus (50)"
 ```
        
 ### 3. How to install the package? Simple easy!
  #### Install via R command line.
  ###### *Please type the following codes in R command line*

  ```
  # Step1: 
  install.packages("devtools") *#This is only required for the first time*   
  # Step2:
  library("devtools")
  # Step3: 
  install_github("yunshiuan/label4MRI", subdir = "label4MRI") *#This is also only required for the first time*
  # Step4: 
  library(label4MRI)
  # Step5: Install completed! 
  # Try "mni_to_region_name(x = 0, y = 0, z = 0)", you should get the results as above.
  ```
  
 ### 4.Advanced issue: What if I have a hundred of MNI coordinates? (done within 10 seconds!)
##### When one has a hundred of MNI coordinates and want to know their corresponding AAL/BA region name, one could simply implement the following R codes:  
 - (1) Create a data frame which contains all the MNI coordinates.
    - "m" as a data frame, which contains 100 rows of MNI coordinates, along with 3 variables represent their MNI coordinates. "m$x" corresponds to the x value of MNI coordinate of the 100 MNI coordinates, and so on.  
       
     |mni_x | mni_y | mni_z|
     |------ | ------ | ----|
     |-2    | -19   | -16|
     |11    | 4  | -8|
     |3 | 4 | -19|
     |...|...|...|  
       
 - (2) Process the 100 MNI coordinates.
    - R code: **Result <- t(mapply(FUN = mni_to_region_name, x = m$x, y = m$y, z = m$z))**
- (3) Access the result.
    - Get the tidy format of the AAL/BA name of the 100 MNI coordinates.  
     -->View(Result) 
    - If you want to save it as a csv file for further usage.  
    --> write.csv(Result,"Myresult.csv")
    
 ### 1.何時我需要用到該套件呢 ?：
 - 有時後MNI 座標非常多，希望能一次**知道所有MNI座標所對應的腦區名稱**為何。然而，目前的程式都是GUI介面(如：MRIcron,XJview,aal.toolbox)，要手動一個一個按按鈕，當作標很多的時候很花時間，且也無法和R code鑲嵌再一起。目前似乎沒有人寫能在command line執行的function code。
 - 因此，我用Rcode寫了可以執行該功能的函數。歡迎有需要的人下載使用。該函數已被測試過，結果和MRIcron的完全相同，可以放心使用。此外，**該套件比MRIcron更厲害**，當MNI座標沒有直接對應的腦區名稱時，可以回報離它最近的腦區名稱以及對應的距離。

### 2. 套件說明：mni_to_region_name(x = x,y = y,z = z,distance = T)
- 例子一: *當MNI座標有直接對應的AAL/BA腦區名稱時*
 ```
 > mni_to_region_name(x = 26, y = 0, z = 0)  
 
 $aal.distance
[1] 0

$aal.label
[1] "Putamen_R"

$ba.distance
[1] 0

$ba.label
[1] "Right-Putamen (49)"
 ```
- 例子二: *當MNI座標 **沒有** 直接對應的AAL/BA腦區名稱時*
 **mni_to_region_name(0,0,0)  
 ```
 > mni_to_region_name(x = 0, y = 0, z = 0)  
 
$aal.distance
[1] 7.81025

$aal.label
[1] "Thalamus_L"

$ba.distance
[1] 4.242641

$ba.label
[1] "Left-Thalamus (50)"
 ```
- 描述: 
    - x, y, z : MNI 座標的x,y,z 值.
    - distance(預設 = T):若輸入的MNI座標不屬於任何AAL/BA腦區(如:落在腦室中)，則會回報最接近的腦區名稱，以及和其的距離(mm)。當MNI座標屬於AAL/BA定義的腦區，則回報distance=0。

 ### 3. 如何安裝?非常簡單!
  ### 選項A(建議): 透過R指令安裝 
###### *請將以下的指令輸入R的指令視窗並執行*
```
  # 步驟一: 
  install.packages("devtools") *#該步驟僅在第一次安裝時需要*
  # 步驟二: 
  library("devtools")
  # 步驟三: 
  install_github("yunshiuan/label4MRI",subdir = "label4MRI") *#該步驟也僅在第一次安裝時需要*
  # 步驟四: 
  library(label4MRI)
  # 步驟五: 安裝完成! 
  # 測試看看 "mni_to_region_name(x = 0, y = 0, z = 0)", 你應該會看到上方的結果;
```

##### 當你有一百個MNI座標，並且想知道他們的AAL腦區名稱時，你可以輕鬆地透過下方的R語言指令快速解決 (10秒完成100個座標!)。
 - (1) 創造一個data frame。裡面包含這一百個MNI座標的數值。
 -"m"是一個data frame,裡面包含這100個MNI座標的3個變數-x,y,z座標的值。"m$x"是這100個MNI座標的x值，以此類推。   
 
     mni_x | mni_y | mni_z 
    | ------ | ------ | ----|
    | -2| -19| -16|
    |11|4 | -8|
    |3|4|-19|
    |...|...|...|  
    
 - (2) 標記這一百個座標。
    - R 語言指令:  
    **Result <- t(mapply(FUN = mni_to_region_name,x = m$x,y = m$y,z = m$z))**
- (3) 取得結果  
    - 檢視結果:  
     -->View(Result) 
    - 如果想存成csv檔以供後續使用:  
    --> write.csv(Result, "Myresult.csv")
