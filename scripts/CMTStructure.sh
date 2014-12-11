#!/bin/bash
while read project 
do
        cmt create $TopDir/$project $project-$VERSION
        rm $TopDir/$project/$project-$VERSION/cmt/*
        echo "project $project" >> $TopDir/$project/$project-$VERSION/cmt/project.cmt
        python $TopDir/../scripts/AddProjects.py "${project}Release ${project}Release-v*" "$project" "$LCGCMT_VERS" >> $TopDir/$project/$project-$VERSION/cmt/project.cmt 
done < Projects.txt
