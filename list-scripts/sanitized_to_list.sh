#!/bin/bash
# usage: bash list-scripts/sanitized_to_list.sh 314 8000000000 200 lists/314
RELEASE=${1:-314}

# Remove dirs
cat list-scripts/rsynclist_$RELEASE.sanitized | sed '/^d/d' | awk  '{gsub(",","",$2); print $5" "$2}' > list-scripts/rsynclist_$RELEASE.sizes


sizelimit=${2:-8000000000} # in B (8Gb)
filenumlimit=${3:-200} # 200 files max
outdir=${4:-"lists/$RELEASE"}
sizesofar=0
filenumsofar=0
dircount=1
mkdir -p $outdir
touch "$outdir/tmp_sub_$dircount.txt"
while read -r file size
do
  if ((sizesofar + size > sizelimit || filenumsofar >= filenumlimit ))
  then
    echo "Done with chunk $dircount with size $sizesofar B and $filenumsofar files"
    mv $outdir/tmp_sub_$dircount.txt $outdir/sub_${dircount}_${sizesofar}_${filenumsofar}.txt
    (( dircount++ ))
    sizesofar=0
    filenumsofar=0
    touch "$outdir/tmp_sub_$dircount.txt"
  fi
  (( sizesofar += size ))
  (( filenumsofar += 1 ))
  echo "$file" >> "$outdir/tmp_sub_$dircount.txt"
done < list-scripts/rsynclist_$RELEASE.sizes

echo "Done with chunk $dircount with size $sizesofar B and $filenumsofar files"
mv $outdir/tmp_sub_$dircount.txt $outdir/sub_${dircount}_${sizesofar}_${filenumsofar}.txt