//
//  CustomModeViewController.swift
//  All Smiles
//
//  Created by qml on 2018/12/5.
//

import UIKit

// 自定义模式
class CustomModeViewController: Common,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GetRowAndColumnDelegate {
    
    // 通过 Delegate 机制，从上一个 viewController 中获得行数和列数
    func getRowAndColumn(_ controller: GetRowAndColumnViewController, rowNumber: Int, columnNumber: Int) {
        row = rowNumber
        column = columnNumber
    }
    
    @IBAction func askForSolution(_ sender: UIButton) {
        super.askForSolution()
    }
    
    // 重新生成随机阵列，行数和列数不变
    @IBAction func reset(_ sender: UIButton) {
        view.viewWithTag(1)!.removeFromSuperview()
        createFaceCellMatrix()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createFaceCellMatrix()
    }
    
    func createFaceCellMatrix(){
        let FaceCellMatrix = makeFaceCellMatrix()
        FaceCellMatrix.delegate = self
        FaceCellMatrix.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView,didSelectItemAt:indexPath)
    }
}
