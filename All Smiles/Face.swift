//
//  Face.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class Face{
    var isSad:Bool{
        didSet{
            if isSad {
                setSadStyle()
            }
            else
            {
                setSmileStyle()
            }
        }
    }
    
    var isStepOfSolution:Bool{
        didSet{
            if isStepOfSolution{
                setSolutionStepStyle()
            }
            else{
                cancelSolutionStepStyle()
            }
        }
    }
    
    var button:UIButton
    
    init(width:CGFloat,height:CGFloat)
    {
        button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant:width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        isStepOfSolution = false
        if Int(arc4random() % 2) == 0{
            isSad = true
            setSadStyle()
        }
        else{
            isSad = false
            setSmileStyle()
        }
    }
    
    func setSmileStyle(){
        button.backgroundColor = UIColor.red
        button.setBackgroundImage(UIImage(named: "Smile")!, for: .normal)
    }
    
    func setSadStyle(){
        button.backgroundColor = UIColor.green
        button.setBackgroundImage(UIImage(named: "Sad")!, for: .normal)
    }
    
    func setSolutionStepStyle(){
        button.setImage(UIImage(named: "Tick"), for: .normal)
    }
    
    func cancelSolutionStepStyle(){
        button.setImage(nil, for: .normal)
    }
}
