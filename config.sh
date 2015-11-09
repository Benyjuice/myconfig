#!/bin/bash

LINK='ln -s'

function print_uasge()
{
    echo "$0 -- add or delete config file"
    echo "Usages:"
    echo "  $0 -a CONFIG_FILE [-n LINK_NAME]"
    echo "this command will add CONFIG_FILE link LINK_NAME to current workspace."
    echo "  $0 -d LINK_NAME"
    echo "this command will delete CONFIG_FILE link,which located at current workspace"
    echo "example:"
    echo "  $0 -a /etc/network/interfaces"
    echo "  $0 -a interfaces"
}


SOURCE_FILE=''
TARGET_FILE=''
DELETE_FILE=''
COMMAND=''

while getopts "a:d:n:h" arg
do
    case $arg in
        a)
            SOURCE_FILE=$OPTARG
            COMMAND='add'
            ;;
        d)
            DELETE_FILE=$OPTARG
            COMMAND='delete'
          ;;
        n)
            TARGET_FILE=$OPTARG
            ;;

        h)
            print_uasge
            ;;
        ?)
            echo "unknown argument"
            print_uasge
            exit 1
            ;;
    esac
done

case $COMMAND in
    add)
        if [ -z "$TARGET_FILE" ]  
        then
            TARGET_FILE=`echo ${SOURCE_FILE##*/}`
        fi

        if [ ! -f "$SOURCE_FILE" ] 
        then
            echo "error: $SOURCE_FILE is not a file"
            exit 1
        fi

        if [ -e "$TARGET_FILE" ] 
        then
            echo “error: targer file $TARGET_FILE already exist.”
            exit 1
        fi
    
        $LINK $SOURCE_FILE $TARGET_FILE
        ;;

    delete)
        if [ ! -e $DELETE_FILE ]; then
            echo "error: $DELETE_FILE not exist."
            exit 1
        fi

        rm -rf $DELETE_FILE
        ;;
    *)
        echo "Unknown command."
        exit 1
        ;;
esac

