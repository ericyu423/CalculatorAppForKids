//
//  ViewController.swift
//  CalculatorAppForKids
//
//  Created by eric yu on 5/7/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numberOfButtons = 14
    
    let label: CustomLabel = {
        var l = CustomLabel()
        
        
        return l
    }()
    
    lazy var button: [CustomButton] = {
        
        var pb = [CustomButton]()
        
        
        for i in 0 ..< self.numberOfButtons {
            let b = CustomButton()
            
            b.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
            b.tag = i
            pb.append(b)

        }
        return pb
    }()
    
    func buttonTapped(_ sender: CustomButton){
         print(sender.tag)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        
    }

}

//layouts
extension ViewController {
    //label
    
    func layoutWithCode(){
        
    }

    
    
    
    
}



