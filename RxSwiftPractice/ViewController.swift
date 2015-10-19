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
        

        self.firstNameTextField.rx_text.bindTo(self.firstNameLabel.rx_text)
        self.lastNameTextField.rx_text.bindTo(self.lastNameLabel.rx_text)
        
        let combine = combineLatest(self.firstNameTextField.rx_text, self.lastNameTextField.rx_text) {
            return $0 + $1
        }
        
        combine.bindTo(self.nameLabel.rx_text)
        combine.bindTo(self.rx_name)        
    }

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var rx_name: ObserverOf<String> {
        return ObserverOf<String> { event in
            
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

