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
    
    //MARK: Vars
    let letterArray = "_ABCDEFGH".characters.flatMap { $0 }
    var delegate: CustomViewDataSource?
    
    var selectV: UIView?
    var cells = [String: UIView]()

    
    var viewPerRow = 20
    var viewPerCol = 7
    var width: CGFloat {
        get {
            return bounds.width / 20
        }
    }
 
    //MARK: Outlets
    var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    override func draw(_ rect: CGRect) {
         setupLabel()
         displayBlocks()
    }
    
    //MARK: functions
    //TODO: might need to be deleted
    func setTitle(text: String)
    {
        label.text = text
    }
 
    //TODO: for test only, to be deleted
    func setupLabel(){
        addSubview(label)
        label.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 50, height: 100)
    }
    
    
    //TODO: function too long i loop probably should be in it's own function
    func displayBlocks(){
        for j in 0..<viewPerCol{
            for i in 0..<viewPerRow{
                let v = UIView()
                addSubview(v)
                v.backgroundColor = .white
                v.layer.borderColor = UIColor.black.cgColor
                v.layer.borderWidth = 0.5
                
                let key = "\(i+1)|\(letterArray[j+1])"
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
    
    func handleTapGesture(gesture: UITapGestureRecognizer){
        let loc:CGPoint = gesture.location(in: self)
        
        let i = Int(loc.x / width) + 1
        let j = letterArray[Int(loc.y / width) + 1]
        
        let key = "\(i)|\(j)"
        
        print(key)
        
        
        guard let cellV = cells[key] else {return}
        
        print(cellV)//current frame
        

        
    }
    
    func adjustSuperView(){
        if bounds.height > CGFloat(viewPerCol) * width {
            
            let offset =  bounds.height - CGFloat(viewPerCol) * width
            
            delegate?.adjustLabelOffset(constant: offset)
        }
    }
}

extension CustomView {
    
    func display1(){
        //d-11
        
    }
    func display2(){
        //d-10,d-11
    }
    func display3(){
        //d-9,d-10,d11
    }
    func display4(){
        //      d-10
        //  e-9,e-10,e-11
        
    }
    func display5(){
        //  d-9     ,d-11
        //  e-9,e-10,e-11

        
    }
    func display6(){
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        
    }
    func display7(){
        //      c-10
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        
    }
    func display8(){
        //  c-9      d-11
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        
    }
    func display9(){
        //  c-9,c-10,c-11
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        
    }
    func display10(){
        //       b10
        //  c-9,c-10,c-11
        //  d-9,d-10,d-11
        //  e-9,e-10,e-11
        
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
