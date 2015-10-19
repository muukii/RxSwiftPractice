//: [Previous](@previous)

import Foundation
import RxSwift

let disposeBag = DisposeBag()

//: Multiple Delegate

let rx_enabledSubject = PublishSubject<Bool>()
var rx_enabled: Observable<Bool> {
    return rx_enabledSubject
}

rx_enabled.subscribeNext { enabled in
    
    print("1", enabled)
    }
    .addDisposableTo(disposeBag)

rx_enabled.subscribeNext { enabled in
    
    print("2", enabled)
    }
    .addDisposableTo(disposeBag)

rx_enabled.subscribeNext { enabled in
    
    print("3", enabled)
    }
    .addDisposableTo(disposeBag)

rx_enabledSubject.on(.Next(true))
rx_enabledSubject.on(.Next(false))
rx_enabledSubject.on(.Completed)
rx_enabledSubject.on(.Next(false)) // もう届かない

//: [Next](@next)
