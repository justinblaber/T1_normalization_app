#!/bin/bash

# Set path for executable
export PATH=$PATH:/extra

# Set up freesurfer
export FREESURFER_HOME=/extra/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# Normalize T1
normalize_T1.sh /INPUTS/T1.nii.gz /OUTPUTS/T1_N3.nii.gz /OUTPUTS/T1_norm.nii.gz
