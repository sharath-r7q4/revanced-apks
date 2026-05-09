source src/build/utils.sh
# repo owner pkgname appname regex method
dl_gh "morphe-cli" "MorpheApp" "latest"
dl_gh $1 $2 "prerelease"
get_patches_key $4
get_apk $3 $4 $4 $5 $6
split_editor $4 $4
patch $4 "$2-$1" "morphe"
