//
//  PPBaseCollectionViewCell.swift
//  LoginModule
//
//  Created by 他趣 on 2022/3/18.
//

import UIKit
import RxSwift
import PPBaseModule

open class PPBaseCollectionViewCell: UICollectionViewCell, PPBaseCollectionViewCellProperty {

    // cell复用记得要释放
    public lazy var disposeBag: DisposeBag = DisposeBag()

}

open class PPBaseTableViewCell: UITableViewCell, PPBaseTableViewCellProperty {
    // cell复用记得要释放
    public lazy var disposeBag: DisposeBag = DisposeBag()
}
