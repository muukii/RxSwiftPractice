//: [Previous](@previous)

import Foundation
import RxSwift

let a = Variable(1)
let b = Variable(2)
let c = Variable(3)

// とりあえず複数ストリームのハンドリングを共通化したい場合
sequenceOf(a,b,c).merge().subscribeNext { value in
    print(value)
}

a.value = 23
b.value = 1
c.value = 30

//: [Next](@next)
