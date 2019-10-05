#!/bin/bash
parentdir='/media/tpsych7/Seagate_Backup_Plus_Drive/Gaurav_HC_simulation_20-7-2019/for_glasser/spms_sims'
indir=${parentdir}/brain
glasssurf='/home/tpsych7/Workbench/glasser_templates'

## Surface mapping from right surface ####
for dir in ${indir}/*;do(cd "$dir" && wb_command -volume-to-surface-mapping ${dir##*/}.nii ${glasssurf}/Q1-Q6_RelatedParcellation210.R.midthickness_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii Rightefield.shape.gii -trilinear);done

echo "surface mapping from right surface is done for all subjects"

## Surface mapping from left surface ####
for dir in ${indir}/*;do(cd "$dir" && wb_command -volume-to-surface-mapping ${dir##*/}.nii ${glasssurf}/Q1-Q6_RelatedParcellation210.L.midthickness_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii Leftefield.shape.gii -trilinear);done

echo "surface mapping from left surface is done for all subjects"

## Assigning values to surface parcels Left ########
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-separate ${glasssurf}/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii COLUMN -metric CORTEX_LEFT GLRleft.func.gii);done

echo "surface parcel values are assigned for left surface"

## Assigning values to surface parcels Right ########
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-separate ${glasssurf}/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii COLUMN -metric CORTEX_RIGHT GLRright.func.gii);done

echo "surface parcel values are assigned for right surface"

## get func.gii of your electric field LEFT ###############
for dir in ${indir}/*;do(cd "$dir" && wb_command -volume-to-surface-mapping ${dir##*/}.nii ${glasssurf}/Q1-Q6_RelatedParcellation210.L.midthickness_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii Leftefield.func.gii -enclosing);done

echo "creation of func.gii is completed for left surface"

## get func.gii of your electric field RIGHT ###############
for dir in ${indir}/*;do(cd "$dir" && wb_command -volume-to-surface-mapping ${dir##*/}.nii ${glasssurf}/Q1-Q6_RelatedParcellation210.R.midthickness_MSMAll_2_d41_WRN_DeDrift.32k_fs_LR.surf.gii Rightefield.func.gii -enclosing);done

echo "creation of func.gii is completed for right surface"

## Create cifti for Left ######
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-create-dense-from-template ${glasssurf}/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii leftImg.dscalar.nii -metric CORTEX_LEFT Leftefield.shape.gii);done

echo "cifti file is created for left surface"

## Create cifti for Right ######
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-create-dense-from-template ${glasssurf}/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii rightImg.dscalar.nii -metric CORTEX_RIGHT Rightefield.shape.gii);done

echo "cifti file is created for right surface"

## Parcellate cifti file Left ######
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-parcellate leftImg.dscalar.nii ${glasssurf}/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii COLUMN leftImg1.pscalar.nii);done

echo "parcellation of left surface is completed!!!"

## Parcellate cifti file Right ######
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-parcellate rightImg.dscalar.nii ${glasssurf}/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii COLUMN rightImg1.pscalar.nii);done

echo "parcellation of right surface is completed!!!"

## Write the values from left and right parcellated files ###
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-convert -to-text rightImg1.pscalar.nii glasser_right_${dir##*/}.txt);done
for dir in ${indir}/*;do(cd "$dir" && wb_command -cifti-convert -to-text leftImg1.pscalar.nii glasser_left_${dir##*/}.txt);done

echo "values are written for parcellations in left and right separate text files"
echo "COMPLETED THE PROCESS OF PARCELLATION !!!!"








