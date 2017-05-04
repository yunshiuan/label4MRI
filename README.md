# MRI-labeling: MNI-to-AAL
- ##### Under the R program environment,input an MNI coordinate, output the corresponding AAL(Automated Anatomical Labeling) brain region name.  
&#13;&#10;
- ##### 在R程式語言中輸入MNI座標，輸出對應的AAL腦區。

<English version instruction. (中文版本說明在後方)>
#### CATALOG 
    1.Why and when do I need the function?
    2.How to use the mni-to-aal R function?
    3.How to install it? Simple easy!
### 1.Why and when do I need the function?
- Those who work with MRI (Magnetic resonance imaging) data **often want to know how dozens of MNI coordinate corresponds to which anatomical brain regions  (e.g.[x=18, y=-5, z=20] belong to the brain region"Right Caudate")**. 

- However, to my knowledge, **all the free programs/tools with this feature are GUI-based(e.g. MRIcron, XJview,aal toolbox)**. That is, one need to manually key in/click on the interested MNI coordinate and manullay copy down the region name shown on the screen. **This could be quite tedious and time-consuming when one is dealing with dozens or more MNI coordiante. Yet, none available tools provide program-embedded code.**

- Here, **I create an R function for this MNI-to-AAL purpose.** They have been tested to ensure the MNI-to-AAL results be totally consistent with MRIcron.
 ### 2.How to use the mni-to-aal R function?
 - #### **The Main Function: mni_to_region_name(x=x,y=y,z=z,distance=T)**
 - Example 1: (*When the mni coordinate has a corresponding region*):
 **mni_to_region_name(26,0,0)  
--> Output :"Putamen_R","distance=0"**
 - Example2 : (*When the mni coordinate do NOT have a corresponding region*)
 **mni_to_region_name(0,0,0) 
--> Output :Thalamus_L","distance=7.81025"**
- Description: 
    - x, y, z : x,y,z value of the mni coordinate.
    - distance(default=T): If the MNI coordinate does not belong to any AAL brain region (e.g. the pointt given fall in the ventricle), then output the nearset AAL brain region name and the their distance (mm). When the MNI coordinat do fall into an AAL brain region, then output distance=0.
    - Output: 
        -   If distance=T,output a list with brain region name along with the distance. 
        - If distance=F, output a string of region name when available, otherwise output *"Not exactly correspond to aal-labeled brain region. Please set distance=T if you want the nearest aal-labeled region name."*.
        
 ### 3. How to install it? Simple easy!
  #### Step1: Download the following file: _"mmi2aal.RData"_  
  #### Step2: Load the RData to your R environment  
 - ##### R code: load("mni2aal.RData")
 - ##### Note: If the .RData file is not in your working directory, please use the code:load("D:\\\\yourdirectory\\\\mni2aal.RData")
  #### Step3: Install completed! 
 - ##### Try "mni_to_region_name(20,-15,-18)", you should get "Region= ParaHippocampus; distance=0 "   

 ### 1.何時我需要用到這個函數呢 ?：
 - 有時後MNI 座標非常多，希望能一次**知道所有MNI座標所對應的AAL的腦區名稱**為何。然而，目前的程式都是GUI介面(如：MRIcron,XJview,aal.toolbox)，要手動一個一個按按鈕，當作標很多的時候很花時間，且也無法和R code鑲嵌再一起。目前似乎沒有人寫能在command line執行的function code。
 - 因此，我用Rcode寫了可以執行該功能的函數。歡迎有需要的人下載使用。該函數已被測試過，結果和MRIcron的完全相同，可以放心使用。此外，**該函數比MRIcron更厲害**，當MNI座標沒有直接對應的腦區名稱時，可以回報離它最近的腦區名稱以及對應的距離。

### 2. 函數說明：mni_to_region_name(x=x,y=y,z=z,distance=T)
- 例子一: (*當MNI座標有直接對應的AAL腦區名稱時*)
 **mni_to_region_name(26,0,0)  
--> 輸出:"Putamen_R","distance=0"**
- 例子二: (*當MNI座標 **沒有** 直接對應的AAL腦區名稱時*)
 **mni_to_region_name(0,0,0) 
--> 輸出 :Thalamus_L","distance=7.81025"**
- 描述: 
    - x, y, z : MNI 座標的x,y,z 值.
    - distance(預設=T):若輸入的MNI座標不屬於任何AAL腦區(如:落在腦室中)，則會 回報最接近的腦區名稱，以及和其的距離(mm)。當MNI座標屬於AAL定義的腦區，則回報distance=0。
    - 輸出: 
        - 當distance=T時，輸出對應的腦區名稱以及距離。
        - 當 distance=F時,若有對應的AAL腦區，則輸出腦區名稱，否則，將輸出  *"Not exactly correspond to aal-labeled brain region. Please set distance=T if youn want the nearest aal-labeled region name."*
 ### 3. 如何安裝?非常簡單!
  #### 步驟一: 下載 _"mmi2aal.RData"_  這個檔案。
  #### 步驟二: 將這個檔案載入R環境中。 
 - ##### R 指令: load("mni2aal.RData")
 - ##### 注意到，如果下載的.RData檔案不在工作路徑中，則請用如下的指令:  load("D:\\\\yourdirectory\\\\mni2aal.RData")
  #### 步驟三:安裝完成!
 - ##### 測試看看 "mni_to_region_name(20,-15,-18)",你應該會看到 "Region= ParaHippocampus; distance=0"。  
