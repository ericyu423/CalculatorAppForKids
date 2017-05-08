//
//  CustomLabel.swift
//  CalculatorAppForKids
//
//  Created by eric yu on 5/7/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

protocol CustomViewDataSource {
    func adjustLabelOffset(constant: CGFloat)
}

class CustomView: UIView,UIGestureRecognizerDelegate {
    
    fileprivate let displayDict = [
        1 : ["D|10"],
        2 : ["D|10","D|11"],
        3 : ["E|9","E|10","E|11"],
        4 : ["D|10","E|9","E|10","E|11"],
        //      d-10
        //  e-9,e-10,e-11
        5 :["D|9","D|11","E|9","E|10","E|11"],
        //  d-9     ,d-11
        //  e-9,e-10,e-11
        6 :["D|9","D|10","D|11","E|9","E|10","E|11"],
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        7 :["C|10","D|9","D|10","D|11","E|9","E|10","E|11"],
        //      c-10
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        8 :["C|9","C|11","D|9","D|10","D|11","E|9","E|10","E|11"],
        //  c-9      d-11
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        9 : ["C|9","C|10","C|11","D|9","D|10","D|11","E|9","E|10","E|11"],
        //  c-9,c-10,c-11
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        
        10 : ["B|10","C|9","C|10","C|11","D|9","D|10","D|11","E|9","E|10","E|11"]
        //       b10
        //  c-9,c-10,c-11
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
    ]
    
    //MARK: Vars
    fileprivate let letterArray = "_ABCDEFGH".characters.flatMap { $0 }
    var delegate: CustomViewDataSource?
    fileprivate var selectV: UIView?
    fileprivate var cells = [String: UIView]()
    fileprivate var viewPerRow = 20
    fileprivate var viewPerCol = 7
    fileprivate var width: CGFloat {
        get {
            return bounds.width / 20
        }
    }
    
    //MARK: Outlets
    fileprivate var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        setupLabel()
        displayBlocks()
    }
    
    //TODO: need this to do something else in the future
    private func setupLabel(){
        addSubview(label)
        label.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 50, height: 100)
    }
    
    //TODO: need to refactor this function
    private func displayBlocks(){
        for j in 0..<viewPerCol{
            for i in 0..<viewPerRow{
                let v = UIView()
                addSubview(v)
                v.backgroundColor = .white
                v.layer.borderColor = UIColor.black.cgColor
                v.layer.borderWidth = 0.5
                v.accessibilityIdentifier = "\(letterArray[j+1])|\(i+1)"
                
                let key = "\(letterArray[j+1])|\(i+1)"
                //print(key)
                cells.updateValue(v, forKey: key)
                
                v.anchor(top:topAnchor, left: leftAnchor, bottom: nil,right: nil, paddingTop: CGFloat(j) * width, paddingLeft: CGFloat(i) * width, paddingBottom: 10, paddingRight: 10, width: width, height: width)
                
            }
        }
        
        //TODO: Tap is to test if the correct block is mapped
        //if there is time put this in Test Module
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        
        adjustSuperView()
        
    }
    
    @objc private func handleTapGesture(gesture: UITapGestureRecognizer){
        let loc:CGPoint = gesture.location(in: self)
        
        let i = Int(loc.x / width) + 1
        let j = letterArray[Int(loc.y / width) + 1]
        
        let key = "\(i)|\(j)"
        
        guard let cellV = cells[key] else {return}
        
        print(cellV)//current frame
        
        
        
    }
    
    private func adjustSuperView(){
        if bounds.height > CGFloat(viewPerCol) * width {
            
            let offset =  bounds.height - CGFloat(viewPerCol) * width
            
            delegate?.adjustLabelOffset(constant: offset)
        }
    }
}


extension CustomView { //public function
    
    func display(number: Int){
        guard let keys = displayDict[number] else {return}
        for key in keys {
            guard let cellV = cells[key] else {return}
            cellV.backgroundColor = .black
        }
    }
    
    //TODO: might need to be deleted
    func setTitle(text: String)
    {
        label.text = text
    }
}

/* block map
 
 A
 B
 C
 D
 E
 F
 G
 0 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20
 */
