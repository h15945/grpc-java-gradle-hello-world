#!/usr/bin/env bash

set -e
# Usage $0 <new-package> <old-package> <ios-ProjectName> 
# ./rename_package.bash cn.chinajnc.grpc.auth cn.chinajnc.grpc.hello Auth
OLD_PACKAGE=$2;
NEW_PACKAGE=$1
NEW_iOS_Proj=$3
SED=${SED:=sed}

if [ -z $1 ]; then
    echo "Usage: $0 <new-package>" 1>&2
    exit 1
fi

#git grep -l $OLD_PACKAGE| xargs $SED -i "s/${OLD_PACKAGE}/${NEW_PACKAGE}/g"

OLD_DIR_STRUCTURE=${OLD_PACKAGE//.//}
NEW_DIR_STRUCTURE=${NEW_PACKAGE//.//}

echo $DIR_STRUCTURE

for basedir in src/main/java src/generated/main/*; do
    mkdir -p ${basedir}/${NEW_DIR_STRUCTURE}
    mv ${basedir}/${OLD_DIR_STRUCTURE}/* ${basedir}/${NEW_DIR_STRUCTURE}/
    rm -rf ${basedir}/io
done
echo "rename packages"
python ./rename_package.py $OLD_PACKAGE $NEW_PACKAGE "/"

echo "rename ios"

python ./rename_package.py "HelloWorld" $NEW_iOS_Proj "/iOS/"

cd ./iOS
rename "s/HelloWorld/$NEW_iOS_Proj/" * 
pod install
echo "Done!";
