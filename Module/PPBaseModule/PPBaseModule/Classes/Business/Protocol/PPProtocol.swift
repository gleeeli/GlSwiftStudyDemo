//
//  PPDictionary to model.swift
//  AdModule
//
//  Created by WJK on 2022/6/20.
//

import UIKit
import HBPublic

let USERINFTicketId =  XHBConfigure.ticketId()

public protocol PeiPeiExtension {
    associatedtype Base
    var base: Base {get}
}

public struct PeiPei<Base>: PeiPeiExtension {
    public var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol PeiPeiExtensionProtocol {}

public extension PeiPeiExtensionProtocol {

     var peiPei: PeiPei<Self> {
        return PeiPei(self)
    }

     static var peiPei: PeiPei<Self>.Type {
        return PeiPei<Self>.self
    }
}

extension NSObject: PeiPeiExtensionProtocol {}
