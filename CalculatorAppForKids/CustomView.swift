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

class CustomView: UIView {
    
    //MARK: Vars
    let letterArray = "_ABCDEFGH".characters.flatMap { $0 }
    var delegate: CustomViewDataSource?
    
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
                print(key)
                //cells.updateValue(v, forKey: key)*/
                
                v.anchor(top:topAnchor, left: leftAnchor, bottom: nil,right: nil, paddingTop: CGFloat(j) * width, paddingLeft: CGFloat(i) * width, paddingBottom: 10, paddingRight: 10, width: width, height: width)
            }
        }
        
        adjustSuperView()
    }
    
    
    func adjustSuperView(){
        if bounds.height > CGFloat(viewPerCol) * width {
            
            let offset =  bounds.height - CGFloat(viewPerCol) * width
            
            delegate?.adjustLabelOffset(constant: offset)
        }
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
