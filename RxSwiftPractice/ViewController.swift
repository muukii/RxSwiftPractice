//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by Hiroshi Kimura on 10/19/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.firstNameTextField.rx_text.bindTo(self.firstNameLabel.rx_text).addDisposableTo(self.disposeBag)
        self.lastNameTextField.rx_text.bindTo(self.lastNameLabel.rx_text).addDisposableTo(self.disposeBag)
        
        let combine = combineLatest(self.firstNameTextField.rx_text, self.lastNameTextField.rx_text) {
            return $0 + $1
        }
        
        combine.bindTo(self.nameLabel.rx_text).addDisposableTo(self.disposeBag)
        
        
        self.firstNameTextField.rx_text.subscribeNext { value in
            
            print(value)
        }.addDisposableTo(self.disposeBag)
                
        self.firstNameTextField.rx_text.bindTo(self.rx_name).addDisposableTo(self.disposeBag)
        
        let scheduler = SerialDispatchQueueScheduler(globalConcurrentQueuePriority: DispatchQueueSchedulerPriority.Default)
        
        self.firstNameTextField.rx_text.observeOn(scheduler).bindTo(self.rx_name).addDisposableTo(self.disposeBag)
     
        self.promiss()
        
        
        self.rx_observeWeakly("")
            .takeUntil(rx_deallocated)
            .subscribeNext { (a: Bool?) -> Void in }
            .addDisposableTo(self.disposeBag)
    }

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    private var rx_name: AnyObserver<String> {
        return AnyObserver<String> { event in
            
            switch event {
            case .Next(let value):
                
                print(value)
            case .Error(let error):
                break
            case .Completed:
                break
            }
        }
    }
    
    enum SampleError: ErrorType {
        case SomethingError
    }
    
    let value = Variable(1)
    private func promiss() {
            
        value.map
            { value in
                
                create { (observer: AnyObserver<Int>) in
                    
                    let delay = 1.0 * Double(NSEC_PER_SEC)
                    let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), {
                        
                        print("map:1 \(value) \(NSDate())")
//                        observer.onNext(value + 1)
                        observer.onError(SampleError.SomethingError)
                        observer.onCompleted()
                    })
                    
                    return NopDisposable.instance
                }.catchErrorJustReturn(4)
            }
            .merge()
            .map { value in
                create { (observer: AnyObserver<Int>) in
                    
                    let delay = 1.0 * Double(NSEC_PER_SEC)
                    let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        
                        print("map:2 \(value) \(NSDate())")
                        observer.onNext(value + 1)
                        observer.onCompleted()
                    }
                    
                    return NopDisposable.instance
                }
            }
            .merge()
            .catchError { error in
                
                just(0)
            }
            .subscribeNext { value in
                
                print("result \(value) \(NSDate())")
            }.addDisposableTo(self.disposeBag)
        
        do {
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                
                self.value.value = 3
            }
        }
        
        do {
            let delay = 1 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                
                self.value.value = 4
            }
        }
        do {
            let delay = 1.2 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                
                self.value.value = 4
            }
        }
    }
    
    
    func foo() {
        
        
        let number = Variable(1)
        
        number.map
            { number in
            return number + 1
            }
            .map { number in
                return number * 2
            }
            .subscribeNext { number in
             
                // number = 4
        }
    }
}

