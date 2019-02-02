<?php

function odd($num) {
    //判断是否为整数
    if (floor($num) == $num) {
        //如果是奇数会返回true
        return $num % 2;
    } else {
        return false;
    }
}