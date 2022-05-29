//
//  RxExampleViewController.swift
//  SwiftFrameworkDemo
//
//  Created by develop on 2020/11/11.
//  Copyright © 2020 GL. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxExampleViewController: UIViewController {
    var disposeBag  = DisposeBag()
    let safeTitleLab = UILabel(frame: CGRect(x: 0, y: 88, width: 100, height: 50))
    let textField = UITextField()
    let mybuton = UIButton()
    
    let scrollview = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        safeTitleLab.text = "123456"
        safeTitleLab.font = UIFont.systemFont(ofSize: 13)
        safeTitleLab.textColor = UIColor.red
        self.view.addSubview(safeTitleLab)
        
        
        textField.frame = CGRect(x: 0, y:  safeTitleLab.frame.maxY + 5, width:100, height: 50)
        textField.placeholder = "请输入"
        self.view.addSubview(textField)
        
        mybuton.frame = CGRect(x: 0, y: textField.frame.maxY + 5, width: 100, height: 50)
        mybuton.backgroundColor = UIColor.green
        self.view.addSubview(mybuton)
        
//        testEmpty()
//        testQuery()
//        testInterval()
//        testCreate()
//        testStartWith()
//        testCombineLatest()
//        testMap()
        
//        testNoRepeat()
//        testSkip()
//        toArray()
//        testMulticastConnectOperators()
        testBind()
//        testDriver()
    }
    
    //将值绑定到UI上
    func testDriver() {
        let result2 = self.textField.rx.text.orEmpty
        result2.bind(to: self.safeTitleLab.rx.text)
            .disposed(by: disposeBag)
        
        //
        let result = self.textField.rx.text.orEmpty
            .asDriver() // 普通序列转化为
            .throttle(.milliseconds(500))//在指定的时间内，只接受第一条和最新的数据。适用于输入框限制搜索次数
//            .flatMap {
//                self.dealwithData(inputText: $0)
//                    .asDriver(onErrorJustReturn: "检测到了错误")
//        }

        // 绑定到label上面
        result.map { "长度:\(($0 as! String).count)" }
            .drive(self.safeTitleLab.rx.text)
            .disposed(by: disposeBag)
        
        // 绑定到button上面
        result.map { ($0 as! String) }
            .drive(self.mybuton.rx.title())
            .disposed(by: disposeBag)

    }
    
    func test() {
        safeTitleLab.rx.observe(String.self, "text").subscribe(onNext: {
            (str: String?) in
            print(str!)
            
        }).disposed(by: disposeBag)//所有者释放的时候，自动释放监听
        
        safeTitleLab.rx.observe(CGRect.self, "frame").subscribe(onNext: { (rect: CGRect?) in
            print(rect!.width)
            
        }).disposed(by: disposeBag)
        
        
//        safeTitleLab.rx.text.
    }
    
    func scrollViewOb() {
        scrollview.contentSize = CGSize(width: 1000, height:0)
        scrollview.rx.contentOffset.subscribe(onNext: { (point : CGPoint) in
            print(point)
            
        }).disposed(by: disposeBag)
    }
    
    func testBind()  {
        let observer : AnyObserver<Bool> = AnyObserver { (event) in
            print("observer当前线程:\(Thread.current)")
            switch event{
            case .next(let isHidden) :
                print("来了,请看label的状态")
                print("observer当前线程:\(Thread.current)")
//                self.safeTitleLab.isHidden = isHidden
            case .error(let error) :
                print("\(error)")
            case .completed :
                print("完成了")
            }
        }
        

        //Binder默认在主线程
        let binder = Binder<Bool>(self.safeTitleLab) { (lab, isHidden) in
            print("Binder当前线程:\(Thread.current)")
            lab.isHidden = isHidden
        }

        let observable = Observable<Bool>.create { (ob) -> Disposable in
            print("create当前线程:\(Thread.current)")
            ob.onNext(false)
//            ob.onError(NSError.init(domain: "com.lgcoooci.cn", code: 10086, userInfo: nil))
            ob.onCompleted()
            return Disposables.create()
            }.observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))

         observable.bind(to: observer).disposed(by: self.disposeBag)
//        observable.bind(to: binder).disposed(by: self.disposeBag)
        
    }
    
    //一个事件两个对象订阅
    func testMulticastConnectOperators(){
        print("*****multicast*****")
        let subject = PublishSubject<Any>()
        subject.subscribe{print("00:\($0)")}
            .disposed(by: disposeBag)
        
        let netOB = Observable<Any>.create { (observer) -> Disposable in
                sleep(2)// 模拟网络延迟
                print("我开始请求网络了")
                observer.onNext("请求到的网络数据")
                observer.onNext("请求到的本地")
                observer.onCompleted()
                return Disposables.create {
                    print("销毁回调了")
                }
            }.publish()
        
        netOB.subscribe(onNext: { (anything) in
                print("订阅1:",anything)
            })
            .disposed(by: disposeBag)

        // 我们有时候不止一次网络订阅,因为有时候我们的数据可能用在不同的额地方
        // 所以在订阅一次 会出现什么问题?
        netOB.subscribe(onNext: { (anything) in
                print("订阅2:",anything)
            })
            .disposed(by: disposeBag)
        
        _ = netOB.connect()
    }
    
    //合成数组
    func toArray() {
        print("*****toArray*****")
        Observable.range(start: 1, count: 10)
            .toArray()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    //跳过元素
    func testSkip() {
        print("*****skip*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .skip(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //去掉重复元素
    func testNoRepeat() {
        print("*****distinctUntilChanged*****")
        Observable.of("1", "2", "2", "2", "3", "3", "4")
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //遍历数组，经过处理后，再在订阅输出
    func testMap() {
        print("*****map*****")
        //of
        //此方法创建一个新的可观察实例，该实例具有可变数量的元素。
        //该方法可以接受可变数量的参数（必需要是同类型的）
        let ob = Observable.of(1,2,3,4)
        ob.map { (number) -> Int in
            return number+2
            }
            .subscribe{
                print("\($0)")
            }
            .disposed(by: disposeBag)
    }
    
    //合并两个事件，两个事件任何一个改变都将触发
    func testCombineLatest() {
        print("*****combineLatest*****")
        let stringSub = PublishSubject<String>()
        let intSub = PublishSubject<Int>()
        Observable.combineLatest(stringSub, intSub) { strElement, intElement in
                "\(strElement) -- \(intElement)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)

        stringSub.onNext("L") // 存一个 L
        stringSub.onNext("G") // 存了一个覆盖 - 和zip不一样
        intSub.onNext(1)      // 发现strOB也有G 响应 G 1
        intSub.onNext(2)      // 覆盖1 -> 2 发现strOB 有值G 响应 G 2
        stringSub.onNext("Cooci") // 覆盖G -> Cooci 发现intOB 有值2 响应 Cooci 2
        // combineLatest 比较zip 会覆盖
        // 应用非常频繁: 比如账户和密码同时满足->才能登陆. 不关系账户密码怎么变化的只要查看最后有值就可以 loginEnable
    }
    
    //在前面插入元素
    func testStartWith() {
        print("*****startWith*****")
        Observable.of("1", "2", "3", "4")
            .startWith("A")
            .startWith("B")
            .startWith("C", "a", "b")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        //效果: CabBA1234
    }
    
    func testCreate() {
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
         
        //订阅测试
        observable.subscribe {
            print($0)
        }
    }
    
    //定时器
    func testInterval() {
        print("********interval********")
        //MARK:  interval
        // 定时器
        Observable<Int>.interval(2, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            }
            //.disposed(by: disposeBag)
    }
    
    func testEmpty()  {
        print("********emty********")
        //订阅的同时就发送完成
        let emtyOb = Observable<Int>.empty()
        _ = emtyOb.subscribe(onNext: { (number) in
            print("订阅:",number)
        }, onError: { (error) in
            print("error:",error)
        }, onCompleted: {
            print("完成回调")
        }) {
            print("释放回调")
        }
    }
    
    
    func testQuery() {
        //订阅就触发next事件，再完成
        //MARK:  just
        // 单个信号序列创建
        let array = ["LG_Cooci","LG_Kody"]
        Observable<[String]>.just(array)
            .subscribe { (event) in
                
                print("current:\(event)")
                print(event)
        }.disposed(by: disposeBag)

        _ = Observable<[String]>.just(array).subscribe(onNext: { (number) in
            print("订阅:",number)
        }, onError: { (error) in
            print("error:",error)
        }, onCompleted: {
            print("完成回调")
        }) {
            print("释放回调")
        }
    }

    

}
