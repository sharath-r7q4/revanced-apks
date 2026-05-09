source src/build/utils.sh
# repo owner pkgname appname regex method/apkpure method(apkpure)
dl_gh "morphe-cli" "MorpheApp" "latest"
dl_gh $1 $2 "prerelease"
get_patches_key $4
if [[ $6 == "apkpure" ]]
then
  get_apkpure $3 $4 $5 $7
elif [[ $3 == "com.amazon.avod.thirdpartyclient"
  get_apk "com.amazon.avod.thirdpartyclient" "prime-video-arm64-v8a" "amazon-prime-video" "amazon-mobile-llc/amazon-prime-video/amazon-prime-video" "arm64-v8a"
else
  get_apk $3 $4 $4 $5 $6
fi
split_editor $4 $4
patch $4 $2 "morphe"
