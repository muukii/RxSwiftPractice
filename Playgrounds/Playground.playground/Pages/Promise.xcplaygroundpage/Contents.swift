//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

enum ValueError: ErrorType {
    case Unknown
}

create
    { (observer: AnyObserver<Int>) in
        
        observer.onNext(2)
        observer.onCompleted()
        return NopDisposable.instance
    }
    .catchErrorJustReturn(3)
    .map { value in
        
        return create { (observer: AnyObserver<Int>) in
            
//            observer.onNext(3)
            print("Map1")
            observer.onError(ValueError.Unknown)
            observer.onCompleted()
            return NopDisposable.instance
        }
    }
    .switchLatest()
    .catchErrorJustReturn(5)
    .map { value in
        
        return create { (observer: AnyObserver<Int>) in
            
            print("Map2")
            observer.onNext(value)
            observer.onCompleted()
            return NopDisposable.instance
        }
    }
    .switchLatest()
    .subscribe { event in
        
        switch event {
        case .Next(let value):
            print(value)
        case .Error(let error):
            print(error)
        case .Completed:
            print("completed")
        }
}





//: [Next](@next)
