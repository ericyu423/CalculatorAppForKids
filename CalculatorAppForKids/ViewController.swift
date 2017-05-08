//
//  ViewController.swift
//  CalculatorAppForKids
//
//  Created by eric yu on 5/7/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomViewDataSource {
    
    //MARK: Vars
    let numberOfButtons = 14
    let dStackSpacing = 10
    let numberOfButtonIndButtonStack = 10
    var labelAnchorContant: NSLayoutConstraint!
    var labelAnchorHeight: NSLayoutConstraint!
    
    
    //MARK: Outlets
    lazy var dbuttonStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 10 //CGFloat(dStackSpacing): does not work - iOS bug
        sv.heightAnchor.constraint(equalTo: sv.widthAnchor)
        sv.backgroundColor = .red
        return sv
    }()
    
    lazy var label: CustomView = {
        var l = CustomView()
        l.delegate = self
        
        l.backgroundColor = .gray

        return l
    }()
    
    lazy var button: [CustomButton] = {
        
        var pb = [CustomButton]()

        for i in 0 ..< self.numberOfButtons {
            
            let b = CustomButton(type: .system)
            
            b.layer.borderColor = UIColor.black.cgColor
            b.layer.borderWidth = 1
            b.layer.cornerRadius = 3
            b.setTitle("\(i)", for: UIControlState.normal)
            b.setTitleColor(.black, for: UIControlState.normal)
            b.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            b.tag = i

            pb.append(b)
            
        }
        return pb
    }()
    
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        layoutWithCode()
  
    }
    
    //MARK: functions
    
    func buttonTapped(_ sender: CustomButton){
        
        label.setTitle(text: "\(sender.tag)")
        
    }
    
    func adjustLabelOffset(constant: CGFloat){
        
        labelAnchorContant.constant = constant/2
        
        labelAnchorHeight.constant -= constant
        
        //dbuttonStack.updateConstraints()
        //view.updateConstraints()
        //view.layoutIfNeeded()
        //view.setNeedsDisplay()
    
    }
    
    
    

}

//layouts
extension ViewController {

    
    func layoutWithCode(){
        
        let labelHeight = view.frame.height * 3/5
        //display label (uiview)
       
        view.addSubview(label)
        label.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        labelAnchorHeight = label.heightAnchor.constraint(equalToConstant: labelHeight)
        labelAnchorHeight.isActive = true
        
        labelAnchorContant = label.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10)
        labelAnchorContant!.isActive = true
        
        
        //display digit buttons
        for i in 0...(numberOfButtonIndButtonStack - 1) {
            dbuttonStack.addArrangedSubview(button[i])
        }
        view.addSubview(dbuttonStack)
        
        
        let totalSpace = CGFloat((numberOfButtonIndButtonStack - 1) * (dStackSpacing)) - 10 - 10
        
        let height = (view.frame.width - totalSpace) / CGFloat(numberOfButtonIndButtonStack)
        
        //height independent of label anchor because label can move down//
        dbuttonStack.anchor(top: topLayoutGuide.bottomAnchor, left: label.leftAnchor, bottom: nil, right: label.rightAnchor, paddingTop: labelHeight + 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: height)
   
    }

    
    
    
    
}



