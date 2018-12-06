//
//  CustomModeViewController.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/5.
//

import UIKit

class CustomModeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func replay(_ sender: UIButton) {
        InputRowAndColumn()
        makeFaceCellMatrix()
    }
    
    func InputRowAndColumn(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        InputRowAndColumn()
        makeFaceCellMatrix()
    }
    
    func makeFaceCellMatrix(){
        let FaceCellMatrix = common.makeFaceCellMatrix(self)
        FaceCellMatrix.delegate = self
        FaceCellMatrix.dataSource = self
    }

}
