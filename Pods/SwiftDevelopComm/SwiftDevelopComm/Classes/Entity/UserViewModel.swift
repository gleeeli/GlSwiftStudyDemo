//
//  UserViewModel.swift
//  ComicChatSwift
//
//  Created by luo luo on 2020/4/21.
//  Copyright © 2020 GL. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift
import HandyJSON
class UserViewModel<E:HandyJSON>: BaseModel {
    
    var mDisposeBag = DisposeBag()
    
    let provider = MoyaProvider<HttpAPIManager>()
//     public func subscribe(onSuccess: ((Element) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil) -> Disposable {
    func addVistory<E:HandyJSON>( type:E.Type,dict:Dictionary<String, Any>,onSuccess:((E)->Void)?=nil,onError: ((Swift.Error) -> Void)? = nil) -> Void {
        provider.rx.request(.AddVisitor(dict)).filterSuccessfulStatusCodes().mapJSON().subscribe(onSuccess: { (result) in
                   print(result)
            guard result is [String: Any] else {
                print("Http- result is not diction.")
                return
            }
            let object = E.deserialize(from: (result as! NSDictionary))
            onSuccess!(object ?? E())
            
               }) { (error) in
                   print(error)
                
                onError!(NSError.init(domain: "", code: 0, userInfo: nil))
               }.disposed(by: mDisposeBag)
    }
}
