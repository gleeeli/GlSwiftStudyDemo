//
//  TEVendingMachine.swift
//  GlSwiftStudyDemo
//
//  Created by 小柠檬 on 2019/2/13.
//  Copyright © 2019年 gleeeli. All rights reserved.
//

import UIKit

struct Item {
    var price: Int
    var count: Int
}

enum TEVendingMachineError: Error {
    case invalidSelection                     //选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock                             //缺货
}

class TEVendingMachine: NSObject {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
        ]
    
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw TEVendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw TEVendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw TEVendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
    
    
    func buyFavoriteSnack(person: String, vendingMachine: TEVendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }
}
