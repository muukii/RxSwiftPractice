//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

class MyClass {
    var name: String = ""
    deinit {
        print("deinit")
    }
}

let subject1 = PublishSubject<Void>()

func leak() {

    let myclass = MyClass()
    myclass.name = "abc"
    
    subject1.subscribe { event in
            
        myclass.name = "cde"
    }
}

let subject2 = PublishSubject<Void>()

func nonleak1() {

    let myclass = MyClass()
    myclass.name = "abc"
    
    subject2.subscribe { event in
        
        myclass.name = "cde"
    }
    
    subject2.onCompleted()
}

let subject3 = PublishSubject<Void>()

func nonleak2() {
    
    let myclass = MyClass()
    myclass.name = "abc"
    
    let disposable = subject3.subscribe { event in
        
        myclass.name = "cde"
    }
    
    disposable.dispose()
    
}

func nonleak3() {
    
    let disposable = subject3.subscribe { event in
       
    }
    
    create { (observer: AnyObserver<Void>) in
        
        let myclass = MyClass()
        myclass.name = "myclass3"
        return NopDisposable.instance
        }.subscribeNext {
            
    }
}

//leak()
//nonleak1()
//nonleak2()
nonleak3()

//: [Next](@next)
