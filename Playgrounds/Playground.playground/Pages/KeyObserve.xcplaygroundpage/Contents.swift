//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

let progress = NSProgress(totalUnitCount: 10)
progress.completedUnitCount = 0

progress.rx_observeWeakly("fractionCompleted").subscribeNext { (value: Double?) in
    
    print(value)
}

progress.completedUnitCount = 1
progress.completedUnitCount = 2
progress.completedUnitCount = 3
progress.completedUnitCount = 4
progress.completedUnitCount = 5


//: [Next](@next)

