//
//  FaceCollectionViewCell.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class FaceCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.backgroundColor = UIColor.blue
        face.backgroundColor = UIColor.brown
        contentView.addSubview(face)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    var face = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
}
