#!/bin/bash

function check_existance(){
    if ! [ -e ~/.trash ]
    then 
        mkdir ~/.trash
    fi
}

function check_key_existance(){
    if ! [ -e ~/.trash/.key ]
    then 
        echo 0 > ~/.trash/.key
    fi
}

function DO(){
    check_existance
    check_key_existance
    name=$(cat ~/.trash/.key)
    let "name=$name + 1"
    echo $name > ~/.trash/.key
    ln $1 ~/.trash/$name
    rm $1
    echo "$(pwd)/$1 $name" >> ~/.trash.log
}

DO