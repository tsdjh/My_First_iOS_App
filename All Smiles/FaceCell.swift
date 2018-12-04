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
//        contentView.addSubview(face)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    var face = UILabel()
}
