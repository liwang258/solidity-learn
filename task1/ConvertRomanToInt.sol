// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ConvertRomanToInt {
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

    function RomanToInt(string memory s) public view returns (int256) {
        int256 v = 0;
        bytes memory b = bytes(s);
        bytes memory pre = new bytes(1);
        bool hasPre = false;
        //LVIII
        for (uint256 i = 0; i < b.length; i++) {
            bytes memory tmp = new bytes(1);
            tmp[0] = b[i];
            bool special = specialMap[string(tmp)];
            //特殊字符，可能需要和接下来的字符做组合判断
            if (special) {
                //如果前面的是特殊字符
                if (hasPre) {
                    bytes memory combin = new bytes(2);
                    combin[0] = pre[0];
                    combin[1] = tmp[0];
                    //前一个是特殊字符，当前的也是特殊字符，组合后能命中值，说明需要组合计算，不需要延迟到下一个循环
                    if (intMap[string(combin)] > 0) {
                        v = v + intMap[string(combin)];
                        hasPre = false;
                    } else {
                        v = v + intMap[string(pre)];
                        hasPre = true;
                        //特殊场景：如果本身就是最后一个字符了，即不存在和后续字符组合的情况，这种时候直接相加即可
                        if (i == b.length - 1) {
                            v = v + intMap[string(tmp)];
                        }
                    }
                } else {
                    //特殊场景：如果本身就是最后一个字符了，即不存在和后续字符组合的情况，这种时候直接相加即可
                    if (i == b.length - 1) {
                        v = v + intMap[string(tmp)];
                    } else {
                        pre[0] = tmp[0];
                        hasPre = true;
                    }
                }
            } else {
                // 非特殊字符的情况下，需要判断是否有前一个是特殊字符，需要组合判断
                if (hasPre) {
                    bytes memory combin = new bytes(2);
                    combin[0] = pre[0];
                    combin[1] = tmp[0];
                    //组合后发现是特殊情况，则直接使用组合后的结果相加
                    if (intMap[string(combin)] > 0) {
                        v = v + intMap[string(combin)];
                    } else {
                        //发现不是特殊情况，则需要单独相加，因为前一个特殊字符还没有加上
                        v = v + intMap[string(b)] + intMap[string(combin)];
                    }
                } else {
                    //前面不是特殊字符，当前也不是特殊字符，直接相加
                    v = v + intMap[string(tmp)];
                }
                //当前是非特殊字符，直接将标识置为非特殊字符
                hasPre = false;
            }
        }
        return v;
    }
}
