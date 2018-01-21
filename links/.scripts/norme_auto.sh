#!/bin/bash
# Name: norme_auto
getScriptPath () {
    if [ -d ${0%/*} ]
    then
        abspath=$(cd ${0%/*} && echo $PWD/${0##*/})
        pathOnly=`dirname "$abspath"`
    else
        progdir=`dirname $0`
        cd $progdir
        pathOnly=$PWD
    fi
    echo $pathOnly;
    return
}

download_and_intall () {
    URL="http://webcomputing.fr/Epitech/"
    FPATH=${HOME}"/moulinette/"
    TEMP_DIR=".temp"
    PACKAGE="latest_version.tar.bz2"
    echo -e "\033[0;36;40m> Downloading ${PACKAGES_URL}${_get_download}\033[0m"
    mkdir ${FPATH}${TEMP_DIR} 2> /dev/null
    wget -nv ${URL}${PACKAGE} -P ${FPATH}${TEMP_DIR}
    chmod +rw ${FPATH}${TEMP_DIR} -R
    echo -e "\033[0;36;40m> Extracting archive...\033[0m"
    tar xjf "${FPATH}${TEMP_DIR}/${PACKAGE}" -C ${FPATH}${TEMP_DIR}
    echo -e "\033[0;36;40m> Saving old version in \"OLD\" directory\033[0m"
    mkdir ${FPATH}.OLD 2> /dev/null
    cp ${FPATH}norme.py ${FPATH}norme_auto.sh ${FPATH}.OLD 2> /dev/null
    echo -e "\033[0;36;40m> Copying files...\033[0m"
    cp ${FPATH}${TEMP_DIR}/norme.py ${FPATH}${TEMP_DIR}/norme_auto.sh ${FPATH}
    echo -e "\033[0;36;40m> Deleting temp directory...\033[0m"
    rm -rf ${FPATH}${TEMP_DIR}
    echo -e "\033[0;36;40m====== Update finished! ======\033[0m"
}

norme=$(getScriptPath)"/norme.py"
option="-score -libc -printline -return"
optionm="-malloc"

if [ $1 ]
then
    if [ "${1:0:1}" != '-' ]
    then
	echo -e "\033[0;32;40m------------------------------ Checking the malloc -----------------------------------"
	echo -e "Crée par maillo_a\033[0m"
	echo -e "\033[0;33;40mPréparation du test de malloc, veuillez patienter..."
	touch norme_malloc.c
	python3 $norme $optionm
	gcc -fPIC norme_malloc.c -shared -o libmymalloc.so
	echo -e "Exécution du programme...\033[0m\n"
	trap '' 11
	LD_PRELOAD=$PWD/libmymalloc.so ./$1
	segerror=$?
	echo -e "\n\033[0;33;40mFinalisation en cours...\033[0m"
	rm $PWD/libmymalloc.so
	rm norme_malloc.c
	if [ $segerror -eq 139 ]
	then
	    echo -e "\033[5;31;40m\n  Segmentation fault trouvé !\033[0m"
	else
	    echo -e "\033[0;32;40m\n  Aucun Segmentation fault.\033[0m"
	fi
	echo -e "\033[0;33;40m\nFin du programme.\033[0m"
	echo -e "\033[0;32;40m---------------------------------------------------------------------------------------\033[0m"
	exit
    else
	if [ "${1}" == "-update" ]
	then
	    download_and_intall
	    exit
	fi
	if [ "${1}" == "-version" ]
        then
            python2 $norme -version
            exit
        fi
    fi
fi
echo -e "\033[0;32;40m------------------------------ Checking the norme TWICE ------------------------------"
echo -e "Modifié par pirez_l/duponc_j\033[0m"
echo -e "\033[0;36;40mChecking *.c files...\033[0m"
if [ $1 ]
then
    option="$option $1"
fi
files=`find ./ -type f \( -name "*.c" ! -name "*op.c" \) -exec echo {} \; | sed 's/ /\\ /g'`
python2 $norme $files $option
echo -e "\033[0;36;40m\nChecking *.h files...\033[0m"
files=`find ./ -name "*.h" -exec echo {} \; | sed 's/ /\\ /g'`
python2 $norme $files $option
echo -e "\033[0;36;40m\nChecking Makefiles...\033[0m"
files=`find ./ -type f -name "Makefile" -exec echo {} \; | sed 's/ /\\ /g'`
python2 $norme $files $option
tempfile=$(find ./ -type f -name "*~" | wc -l)
if [ $tempfile != 0 ]
then
    echo -e "\033[0;31;40m\nTemporary file found !\033[0m"
    echo -e "\033[0;33;40m"; find ./ -type f -name "*~"; echo -e "\033[0m"
fi
tempfile=$(find ./ -type f -name "*#" | wc -l)
if [ $tempfile != 0 ]
then
    echo -e "\033[0;31;40mOther temporary file found !\033[0m"
    echo -e "\033[0;33;40m"; find ./ -type f -name "*#"; echo -e "\033[0m"
fi
tempfile=$(find ./ -type f -name "*.o" | wc -l)
if [ $tempfile != 0 ]
then
    echo -e "\033[0;31;40m$tempfile object file found !\033[0m"
fi
echo -e "\033[0;32;40m---------------------------------------------------------------------------------------\033[0m"
