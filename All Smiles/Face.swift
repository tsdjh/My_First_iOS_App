//
//  Face.swift
//  All Smiles
//
//  Created by qml on 2018/12/2.
//

import UIKit

// collectionView 中单元格的数据
class Face{
    
    // 微笑还是沮丧
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
    
    // 是否是解矩阵的一部分，用于给玩家提供提示
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
        // 这里使按钮不响应用户点击，将响应用户点击的活交给 collectionView
        // 如果让按钮响应用户点击，将会拦截点击事件，这样 collectionView 将接收不到点击事件
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant:width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        isStepOfSolution = false
        // 随机初始化表情
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
