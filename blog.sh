#!/bin/sh
read -p "创建(N)/发布(P)/本地发布(S)博客:" type
#while (( $type != 'N' && $type != 'P'))
#do
#    read -p "创建(N)/发布(P)博客:" type
#done
#path=`pwd` 
if [ $type = 'N' ]
then
    read -p "博客名称:" name
    echo `hexo new $name`
    open -a /Applications/Typora.app  $path/source/_posts/$name.md
	echo 'N'
elif [ $type = 'P' ]
then
	hexo clean
	hexo g
	hexo d
    echo "finished!"
elif [ $type = 'S' ]
then 
	hexo s
	echo "finished!"
else
	echo "see you again!"
fi
