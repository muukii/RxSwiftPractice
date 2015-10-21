//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

let a: Observable<String> = create { observer in
    
    observer.onNext("a")
    return AnonymousDisposable {
        
    }
}

let b: Observable<String> = create { observer in
    
    return AnonymousDisposable {
        
    }
}

let d: AnyObserver<String> = AnyObserver<String> { (event) -> Void in
    
}

let c: Observable<String> = create { observer in
    observer.onNext("a")
    return AnonymousDisposable {
        
    }
}

c.bindTo(AnyObserver<String> { (event) -> Void in
    
    if case .Next(let value) = event {
        print(value)
    }
    
    })




//: [Next](@next)
