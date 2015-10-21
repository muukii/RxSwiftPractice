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
}

