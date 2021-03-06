//: [Previous](@previous)

//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

//: Button handling

let button = UIButton()
button.rx_tap.subscribeNext {
    
    // Tap
    }
    .addDisposableTo(disposeBag)


//: Text Field handling
let textFiled = UITextField()
textFiled.rx_text.subscribeNext { text in
    // textFiled.textの値が変更されるたびに呼び出される
    }
    .addDisposableTo(disposeBag)



textFiled.rx_text
    .map { $0.characters.count }
    .subscribeNext { count in
        
        // textFiled.textの値が変更されるたびに呼び出される
        // 文字数が届く
    }
    .addDisposableTo(disposeBag)



textFiled.rx_text
    .map { $0.characters.count }
    .filter { $0 > 3 }
    .subscribeNext { count in
        
        // textFiled.textの値が変更されるたびに呼び出される
        // 文字数が届く
        // 4文字以上の場合のみ
    }
    .addDisposableTo(disposeBag)




textFiled.rx_text
    .map { $0.characters.count }
    .filter { $0 > 3 }
    .distinctUntilChanged()
    .subscribeNext { count in
        
        // textFiled.textの値が前回と異なった場合呼び出される
        // 文字数が届く
        // 4文字以上の場合のみ
    }
    .addDisposableTo(disposeBag)



textFiled.rx_text
    .map { $0.characters.count }
    .filter { $0 > 3 }
    .take(2)
    .ski
    .subscribeNext { count in
        
        // textFiled.textの値が変更されるたびに呼び出される
        // 文字数が届く
        // 4文字以上の場合のみ
        // 2回よばれたら終わり
    }
    .addDisposableTo(disposeBag)

//: [Next](@next)
