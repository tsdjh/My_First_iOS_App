//
//  CustomModeViewController.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/5.
//

import UIKit

class CustomModeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GetRowAndColumnDelegate {
    func getRowAndColumn(_ controller: GetRowAndColumnViewController, rowNumber: Int, columnNumber: Int) {
        common.row = rowNumber
        common.column = columnNumber
    }
    
    let common = Common()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return common.faces.FaceMatrix.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return common.collectionView(collectionView, indexPath)
    }
    
    @IBAction func askForSolution(_ sender: UIButton) {
        common.askForSolution()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        view.viewWithTag(1)!.removeFromSuperview()
        makeFaceCellMatrix()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeFaceCellMatrix()
    }
    
    func makeFaceCellMatrix(){
        let FaceCellMatrix = common.makeFaceCellMatrix(self)
        FaceCellMatrix.delegate = self
        FaceCellMatrix.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        common.collectionView(collectionView, didSelectItemAt:indexPath)
    }
}
