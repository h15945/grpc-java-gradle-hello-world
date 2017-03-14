# -*- coding: utf-8 -*- 
import os 
import sys
def checkPsthListWithDir(rootDir,filePathType): 
	list_dirs = os.walk(rootDir) 
	path_list = []
	for root, dirs, files in list_dirs:	 
		for f in files: 
			if  (not(f[0] == '.')) and (root.find('.git') == -1):
				#print os.path.join(root, f)
				if filePathType == 1 :
					path_list.append(os.path.join(root, f))
				else:
					path_list.append(f)
	return path_list

def checkContainedIntheProject(src,des):
	mypath = os.path.abspath('.') + '/'
	path_list = checkPsthListWithDir(mypath,1)
	for filepath in path_list:
		#print filepath
		with open(filepath, 'r+') as myfile:
			data=myfile.read()
			if data.find(src) != -1:
				myfile.seek(0)
				myfile.truncate()
				print  filepath
				myfile.write(data.replace(src, des))
			myfile.close()


checkContainedIntheProject(sys.argv[1],sys.argv[2])
