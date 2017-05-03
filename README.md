# MRI-labeling: MNI-to-AAL
Input an MNI coordinate, output the corresponding AAL(Automated Anatomical Labeling) brain region name.

<English version instruction. (中文版本說明在後方)>
### 1.Why and when do I need to use the function?
- Those who work with MRI (Magnetic resonance imaging) data often want to know **what a given mni coordinate corespond to which anatomical brain region (e.g.[x=18, y=-5, z=20] belong to the brain region"Right Caudate")**.

- However, to my knowledge, **all the free programs/tools with this feature are GUI-based(e.g. MRIcron, XJview,aal toolbox)**. That is, one need to manually key in/click on the interested MNI coordinate and manullay copy down the region name shown on the screen. This could be quite tedious and time-consuming when one is dealing with dozens or more MNI coordiante. **Yet, none available tools provide program-embedded codes.**

- Here, **I create a R script which contains functions for this purpose.** They have been tested to ensure the MNI-to-AAL results  be totally consistent with MRIcron.
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
        - If distance=F, output a string of region name when available, otherwise output *"Not exactly correspond to aal-labeled brain region. Please set distance=T if youn want the nearest aal-labeled region name."*.
        
 ### 3. How to install it?
