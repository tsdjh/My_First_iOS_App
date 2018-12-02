//
//  FaceCollectionViewCell.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class FaceCollectionViewCell: UICollectionViewCell {
    var FaceButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    func initview(){
        self.addSubview(FaceButton)
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        FaceButton.backgroundColor = UIColor.gray
        self.addSubview(FaceButton)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
