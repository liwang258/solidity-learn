// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract MergeTwoSortedArray {
    function merge(
        int[] memory arr1,
        int[] memory arr2
    ) public pure returns (int[] memory v) {
        v = new int[](arr1.length + arr2.length);
        for (uint256 i = 0; i < arr1.length; i++) {
            v[i] = arr1[i];
        }

        for (uint256 i = 0; i < arr2.length; i++) {
            v[arr1.length + i] = arr2[i];
        }

        for (uint256 i = 0; i < v.length; i++) {
            for (uint256 j = i + 1; j < v.length; j++) {
                if (v[i] > v[j]) {
                    int tmp = v[i];
                    v[i] = v[j];
                    v[j] = tmp;
                }
            }
        }

        return v;
    }
}
