#!/bin/bash
echo '=========change proto to oc=========='
projName=$1
cd ../../src/main/proto/
for filename in `ls` ;do
 if [[ ${filename/".proto"//} != $filename ]];
 	then
 	echo "转换"$filename
 	folder="../../../iOS/Pods/$projName"
 	if [ ! -d "$folder" ]; then
		mkdir -p "$folder"
	fi
 	mkdir 
 	../../../iOS/proto/protocarc --plugin=protoc-gen-grpc=../../../iOS/proto/grpc_objective_c_plugin --objc_out="$folder" --grpc_out="$folder" $filename
 	#../protoc    --plugin=protoc-gen-grpc=../grpc_php_plugin          --php_out=../PHP        --grpc_out=../PHP        $filename
 	fi
 done
cd ..