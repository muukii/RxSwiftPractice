//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

extension String: ErrorType {
    
}

//create
//    { (observer: AnyObserver<Int>) in
//        
//        observer.onNext(2)
//        observer.onCompleted()
//        return NopDisposable.instance
//    }
//    .map { value in
//        
//        return create { (observer: AnyObserver<Int>) in
//            
//            print("Map1")
//            observer.onError("Error")
//            observer.onCompleted()
//            return NopDisposable.instance
//        }
//    }
//    .switchLatest()
//    .map { value in
//        
//        return create { (observer: AnyObserver<Int>) in
//            
//            print("Map2")
//            observer.onNext(value)
//            observer.onCompleted()
//            return NopDisposable.instance
//        }
//    }
//    .switchLatest()
//    .subscribe { event in
//        
//        switch event {
//        case .Next(let value):
//            print(value)
//        case .Error(let error):
//            print(error)
//        case .Completed:
//            print("completed")
//        }
//}

create
    { (observer: AnyObserver<Int>) in
        
        observer.onNext(2)
        observer.onCompleted()
        return NopDisposable.instance
    }
    .map { value in
        
        return create { (observer: AnyObserver<Int>) in
            
            //            observer.onNext(3)
            print("Map1")
            observer.onError("Error")
            observer.onCompleted()
            return NopDisposable.instance
        }
    }
    .switchLatest()
    .catchError { error in
        
        return failWith("")
    }
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
