//
//  ThrowExceptViewController.swift
//  GlSwiftStudyDemo
//
//  Created by gleeeli on 2019/2/13.
//  Copyright © 2019年 gleeeli. All rights reserved.
//

import UIKit



class ThrowExceptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vendingMachine = TEVendingMachine()
        vendingMachine.coinsDeposited = 8
        do {
            
            try vendingMachine.buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        } catch TEVendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch TEVendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch TEVendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch { // 加入一个空的catch，用于关闭catch。否则会报错：Errors thrown from here are not handled because the enclosing catch is not exhaustive
            
        }
    }
}
