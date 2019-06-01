# T1_normalization_app

This includes everything required to build a docker and corresponding singularity container to perform a minimal FreeSurfer T1 intensity normalization. 

[Docker Hub](https://hub.docker.com/r/justinblaber/t1_normalization/tags/)

[Singularity Hub](https://singularity-hub.org/collections/725)

# Run Instructions:
For docker:
```
sudo docker run --rm \
-v $(pwd)/INPUTS/:/INPUTS/ \
-v $(pwd)/OUTPUTS:/OUTPUTS/ \
-v <path to license.txt>:/extra/freesurfer/license.txt \
--user $(id -u):$(id -g) \
justinblaber/t1_normalization
```
For singularity:
```
singularity run -e \
-B INPUTS/:/INPUTS \
-B OUTPUTS/:/OUTPUTS \
-B <path to license.txt>:/extra/freesurfer/license.txt \
shub://justinblaber/t1_normalization_app
```
