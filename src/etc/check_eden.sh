#!/bin/bash

# Check new Eden Version:



get_date_gh() {
	json=$(wget -qO- "https://api.github.com/repos/$1/releases")
	updated_at=$(echo "$json" | jq -r '[.[] | select(.tag_name == "'$2'") | .assets[] | select(.name | test("'$3'"))] | sort_by(.updated_at) | last | .updated_at')
	echo "$updated_at"
}
	
checker(){
	local date1 date2 date1_sec date1_sec ur_repo=$repository
	date1=$(gh run list -R Eden-CI/Workflow -w nightly.yml --status success --limit 1 --json updatedAt  -q ".[0].updatedAt")
	date2=$(get_date_gh "$ur_repo" "all" "Eden-Android")
	date1_sec=$(date -d "$date1" +%s)
	date2_sec=$(date -d "$date2" +%s)
	if [ -z "$date2" ] || [ "$date1_sec" -gt "$date2_sec" ]; then
		echo "new_patch=1" >> $GITHUB_OUTPUT
		echo -e "\e[32mNew patch, building...\e[0m"
	elif [ "$date1_sec" -lt "$date2_sec" ]; then
		echo "new_patch=0" >> $GITHUB_OUTPUT
		echo -e "\e[32mOld patch, not build.\e[0m"
	fi
}
checker
