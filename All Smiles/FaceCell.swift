//
//  FaceCollectionViewCell.swift
//  All Smiles
//
//  Created by qml on 2018/12/2.
//

import UIKit

// collectionView 的单元格
class FaceCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
//        contentView.addSubview(face)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    var face = UIButton()
}
