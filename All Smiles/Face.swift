//
//  Face.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class Face{
    var issmile:Bool{
        didSet{
            if issmile {
                button.backgroundColor = UIColor.green
            }
            else
            {
                button.backgroundColor = UIColor.red
            }
        }
    }
    var button:UILabel
    init(width:CGFloat,height:CGFloat)
    {
        button = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant:width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        if Int(arc4random() % 2) == 0{
            issmile = false
            button.backgroundColor = UIColor.red
        }
        else{
            issmile = true
            button.backgroundColor = UIColor.green
        }
    }
}
