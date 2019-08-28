//
//  main.swift
//  LeetCode
//
//  Created by gshopper on 2019/10/29.
//  Copyright © 2019 mozihen. All rights reserved.
//

import Foundation
//import UIKit


// mark: - 两数之和

/// 暴力遍历法
/// - Parameter nums: 预选数组
/// - Parameter target: 目标数
/// return 元组形式的两个数的下标
func towSum(_ nums: Array<Int>, target: Int) -> (Int, Int)? {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[j] == target - nums[i] {
                return (i, j)
            }
        }
    }
    return nil;
}
/// 哈希法
/// 将元素放入哈希表中，因为哈希查找时只需要近似O(1)的时间，这样减去了暴力法的内层循环O(n)的时间。
func towSumHashMap(_ nums: Array<Int>, target: Int) -> (Int, Int)? {
    var lookMap = Dictionary<Int, Int>()
    for i in 0..<nums.count {
        lookMap[nums[i]] = i;
    }
    for i in 0..<nums.count {
        let complement = target - nums[i];
        
        if lookMap.keys.contains(complement) && lookMap[complement] != i {
            let j = lookMap[complement]!;
            return (i, j)
        }
    }
    fatalError("Not found!")
}

/// 组合两个循环，只需要一次遍历就可以实现
func towSumHashMap2(_ nums: Array<Int>, target: Int) -> (Int, Int)? {
    var lookMap = Dictionary<Int, Int>()
    for i in 0..<nums.count {
        let complement = target - nums[i];
        if lookMap.keys.contains(complement) {
            let j = lookMap[complement]!;
            return (i, j)
        }
        lookMap[nums[i]] = i;
    }
    fatalError("Not found!")
}

/// 题1：
/// 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
///
/// 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。
func towSumTest()throws {
    let nums = [8, 82, 29, 26, 38, 2];
    let target = 10;
    guard let result = towSum(nums, target: target) else {
        fatalError("Not found!")
    }
    print("target:\(target) = \(nums[result.0]) + \(nums[result.1])")
    
    guard let hashResult = towSumHashMap(nums, target: target) else {
        fatalError("Not found!(Hash)")
    }
    print("target:\(target) = \(nums[hashResult.0]) + \(nums[hashResult.1])(Hash)")
    
    guard let hashResult2 = towSumHashMap(nums, target: target) else {
        fatalError("Not found!(Hash2)")
    }
    print("target:\(target) = \(nums[hashResult2.0]) + \(nums[hashResult2.1])(Hash2)")
}

do {
    try towSumTest()
}
catch {
    print(error)
}

/// 题2：
/// 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
///
/// 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
/// 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
///
/// 示例：
///
/// 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
/// 输出：7 -> 0 -> 8
/// 原因：342 + 465 = 807
///

 public class ListNode {
     var val: Int
     var next: ListNode?
     init (_ val: Int) {
         self.val = val
         self.next = nil
     }
 }

extension Decimal {
    var intVal: Int? {
        return Int(self.description)
    }
}

class SolutionForAddTwoNums {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var sumList: ListNode?
        var list1 = l1
        var list2 = l2
        var carry = 0
        var sumArray: Array<Int> = Array()
        while (list1 != nil || list2 != nil) {
            let v1 = list1?.val ?? 0
            let v2 = list2?.val ?? 0
            let val = (v1 + v2)
            sumArray.append(val % 10)
            carry = val / 10
            if carry == 1 { // 进位
                if (sumArray.count == 1) {
                    sumArray.insert(carry, at: 0)
                }
                else {
                    sumArray[sumArray.count - 2] = sumArray[sumArray.count - 2] + carry;
                }
            }
            list1 = list1?.next
            list2 = list2?.next
        }
        if sumArray.count == 0 { return nil }
        // 将数组逆向转为链表
        var nextNode: ListNode?
        sumList = ListNode(sumArray.popLast()!)
        nextNode = sumList
        let count = sumArray.count
        for _ in 0..<count {
            let tmpNode = ListNode(sumArray.popLast()!)
            nextNode?.next = tmpNode
            nextNode = tmpNode
        }
        return sumList;
    }
    func addTwoNumsTest() -> Void {
        let l1 = self.generateList([2,4,5])
        let l2 = self.generateList([5,6,3])
        let resultList = self.addTwoNumbers(l1, l2)
        self.printList(resultList)
    }
    func generateList(_ nums: [Int]) -> ListNode? {
        guard let num = nums.first else {
            return nil
        }
        let node = ListNode(num)
        var next: ListNode = node
        for i in 1..<nums.count {
            let tmpNode = ListNode(nums[i])
            next.next = tmpNode
            next = tmpNode
        }
        return node
    }
    func printList (_ list: ListNode?) {
        guard let ls = list else {
            return
        }
        print(ls.val, separator: "", terminator: "");
        printList(ls.next)
    }
}
SolutionForAddTwoNums().addTwoNumsTest()
