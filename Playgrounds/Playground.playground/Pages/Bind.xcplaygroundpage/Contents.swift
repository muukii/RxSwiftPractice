//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

class View {
    
    var rx_text: ObserverOf<String> {
        return ObserverOf<String> { event in
            
            // MainScheduler validation
            MainScheduler.ensureExecutingOnScheduler()
            
            if case .Next(let value) = event {
                
                print("Display ",value)
            }
        }
    }
}

class Controller {
    
    var name: Variable<String> = Variable<String>("test")
    let view = View()
    
    init() {
        
        self.name.bindTo(view.rx_text)
        
    }
}

let controller = Controller()
controller.name.value = "hi"


//: [Next](@next)
