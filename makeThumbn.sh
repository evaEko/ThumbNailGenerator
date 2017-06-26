#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'add the target path'
    exit 0
  fi
SEARCH_DIR="$1"
SEARCH_DIR=`find $1 -mindepth 1 -maxdepth 3 -type d`
echo $SEARCH_DIR
for dir in $SEARCH_DIR
   do
     if [ "$(ls -A $dir |grep jpg)" ];
     then
      mkdir -p "$dir"/thumbs
      IMAGES=`find $dir -name '*jpg'`;
      for image in $IMAGES
      do
        imagename=$(sed 's|.*/\([^/]\)|\1|g' <<< $image)
        if [ -f $dir/thumbs/$imagename ]
          then
            echo "ommiting $image"
          else
            if [[ $imagename = "nearbyicebergs.jpg" ]] ; then
              convert -thumbnail 390 $image $dir/thumbs/$imagename
            else
              echo "converting" + $image + " to " $dir/thumbs/$imagename
              convert -thumbnail 200 $image $dir/thumbs/$imagename
            fi
        fi
      done
    fi
done
