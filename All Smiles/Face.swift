//
//  Face.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class Face{
    var issmile = 0{
        didSet{
            if issmile == 0{
                button.backgroundColor = UIColor.red
            }
            else
            {
                button.backgroundColor = UIColor.green
            }
        }
    }
    var button:UIButton
    init(width:CGFloat,height:CGFloat)
    {
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant:width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        button.backgroundColor = UIColor.brown
    }
}
