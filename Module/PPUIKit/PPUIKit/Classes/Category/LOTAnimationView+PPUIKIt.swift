//
//  LOTAnimationView+PPUIKIt.swift
//  PPUIKit
//
//  Created by WJK on 2022/6/13.
//

import Foundation
import Lottie

public extension LOTAnimationView {

   public func pp_setAnimationNamed(_ animation: String?) {
        if let a = animation?.isEmpty, !a {
            self.setAnimation(named: animation!, bundle: .pp_resourceBundle)
        }
    }

}
