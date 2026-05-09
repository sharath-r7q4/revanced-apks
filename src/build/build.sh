source src/build/utils.sh
# repo owner pkgname appname regex method/apkpure method(apkpure)
dl_gh "morphe-cli" "MorpheApp" "latest"
dl_gh $1 $2 "prerelease"
get_patches_key $4
echo $6
if [ $6 == "apkpure" ]
then
  get_apk $3 $4 $5 $7
else
  get_apk $3 $4 $4 $5 $6
fi
split_editor $4 $4
patch $4 $2 "morphe"
