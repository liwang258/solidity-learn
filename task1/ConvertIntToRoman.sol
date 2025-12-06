// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ConvertIntToRoman {
    mapping(string => int256) public intMap;
    mapping(string => bool) public specialMap;

    constructor() {
        intMap["I"] = 1;
        intMap["V"] = 5;
        intMap["X"] = 10;
        intMap["L"] = 50;
        intMap["C"] = 100;
        intMap["D"] = 500;
        intMap["M"] = 1000;
        intMap["IV"] = 4;
        intMap["IX"] = 9;
        intMap["XL"] = 40;
        intMap["XC"] = 90;
        intMap["CD"] = 400;
        intMap["CM"] = 900;

        specialMap["I"] = true;
        specialMap["X"] = true;
        specialMap["C"] = true;
    }

    function intToRoman(int memory num) public view returns (string) {
        return "";
    }
}
