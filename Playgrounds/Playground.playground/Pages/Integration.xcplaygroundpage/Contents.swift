//: [Previous](@previous)

import Foundation
import RxSwift

func asyncA(completion: () -> Void) {
    
    //
    completion()
    //
}

func asyncB(completion: (String) -> Void) {
    
    //
    completion("hello")
    //
}

func rx_asyncA() -> Observable<Void> {
    return create { observer in
        
        asyncA {
            observer.onNext(())
            observer.onCompleted()
        }
        
        return NopDisposable.instance
    }
}

func rx_asyncB() -> Observable<String> {
    return create { observer in
        
        asyncB { value in
            observer.onNext(value)
            observer.onCompleted()
        }
        
        return NopDisposable.instance
    }
}


//: [Next](@next)
