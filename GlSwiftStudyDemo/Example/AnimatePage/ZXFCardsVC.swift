//
//  ZXFCardsVC.swift
//  ZXFCardsTurnArround
//
//  Created by 赵希帆 on 16/6/1.
//  Copyright © 2016年 赵希帆. All rights reserved.
//

import UIKit

class ZXFCardsVC: UIViewController,CardCountDelegate,UIAlertViewDelegate {
    
    var imgView : UIImageView!
    var cards : [ZXFCardView]!
    var image1 : UIImage!
    var CardImage : [String] = [String]()
    var cardcount : Int?                         //卡片数量
    var cardviews : [ZXFCardView]?               //移除的卡片
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        //将图片名称命名为card1,card2...
        for i in 0...4 {
            CardImage.insert("card\(i+1).jpg", at: i)
        }
        cardcount = CardImage.count
        cards = Array()
        cardviews = Array()
        self.initCards()
        self.DrawCardsVC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func DrawCardsVC() -> Void {
        self.view.backgroundColor = UIColor.white
        imgView = UIImageView.init(frame: CGRectMake(0, 0, Gloab.Screen_Width, Gloab.Screen_Height))
        imgView.image = UIImage.init(named: "bgImage.jpg")
        self.view.addSubview(imgView)
        
        for card in cards{
            card.bounds.size = CGSizeMake(150, 200)
            card.center = self.view.center
            self.view.addSubview(card)
        }
    }
    
    func initCards() -> Void {
        for i in 0...4 {
            let card = ZXFCardView()
            card.isUserInteractionEnabled = true
            card.delegate = self
            image1 = UIImage.init(named: "\(CardImage[(CardImage.count - i - 1)])")//第一张图在视图最上面
            card.initCardImage(image: image1,center: self.view.center)
            cards.append(card)
        }
    }
    
    func CardCountReduce(cardview: ZXFCardView) {
        cardcount! -= 1
        cardviews?.append(cardview)
        if cardcount == 0 {
            let alert = UIAlertView(title: "提醒", message: "还没撸完？", delegate: self, cancelButtonTitle: "好咯")
            alert.show()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            for cardview in cardviews! {
                cardview.isHidden = false
                cardcount = CardImage.count
            }
            
        default: break
            
        }
    }
    
}
