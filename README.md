# MRI-labeling-MNI-to-AAL
Input a MNI coordinate, output the corresponding AAL(Automated Anatomical Labeling) brain region.
<English version>
 ### 1.Why and when to use these functions?
- Those who work with MRI (Magnetic resonance imaging) data often want to know **what a given mni coordinate corespond to which anatomical brain region (e.g.[x=18, y=-5, z=20] belong to the brain region"Right Caudate")**.

- However, to my knowledge, **all the free programs/tools with this feature are GUI-based(e.g. MRIcron, XJview,aal toolbox)**. That is, one need to manually key in/click on the interested mni coordinate and manullay copy down the region name shown on the screen. This could be quite tedious and time-consuming when one is dealing with dozens or more MNI coordiante. **Yet, none available tools provide program-embedded codes.**

- Here, **I create a R script which contains functions for this purpose.** They have been well-tested and the mni-to-aal results should be totally consistent with  MRIcron.
 ### 2.How to use these mni-to-aal R function?
 - #### **Function name:  mni_to_region_name(x=x,y=y,z=z,distance=T)**
 - Example 1: (*When the mni coordinate has a corresponding region*):
 **mni_to_region_name(26,0,0) --> Output :"Putamen_R","distance=0"**
 - Example2 : (*When the mni coordinate do NOT have a corresponding region*)
 **mni_to_region_name(0,0,0) --> Output :Thalamus_L","distance=7.81025"**
- Description: 
