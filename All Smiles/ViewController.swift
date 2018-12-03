//
//  ViewController.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FaceMatrix.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let facecell = collectionView.dequeueReusableCell(withReuseIdentifier: "FaceCell", for: indexPath) as! FaceCell
        facecell.face = FaceMatrix[indexPath.item].button
        return facecell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeFaceCellMatrix()
    }
    
    let screenWidth = UIScreen.main.bounds.width
    let margin:CGFloat = 10.0
    var FaceMatrix = [Face]()
    
    func makeFaceCellMatrix(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (screenWidth-50)/4, height: (screenWidth-50)/4)
        let FaceCellMatrix = UICollectionView(frame: CGRect(x: margin, y: 200, width: screenWidth - 2.0 * margin, height: screenWidth - 2.0 * margin), collectionViewLayout: layout)
        FaceCellMatrix.delegate = self
        FaceCellMatrix.dataSource = self
        FaceCellMatrix.register(FaceCell.self, forCellWithReuseIdentifier: "FaceCell")
        for _ in 0..<16{
            let face = Face(width: (screenWidth-50)/8, height: (screenWidth-50)/8)
            face.issmile = Int(arc4random() % 2)
            FaceMatrix.append(face)
        }
        view.addSubview(FaceCellMatrix)
    }

}

