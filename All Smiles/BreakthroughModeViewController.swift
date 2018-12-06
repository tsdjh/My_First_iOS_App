//
//  ViewController.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class BreakthroughModeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let common = Common()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return common.faces.FaceMatrix.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return common.collectionView(collectionView, indexPath)
    }
    
    @IBOutlet weak var nextLevelButton: UIButton!
    @IBAction func nextLevel(_ sender: UIButton) {
        if level <= 8{
            level += 1
            view.viewWithTag(1)!.removeFromSuperview()
            makeFaceCellMatrix()
        }
    }
    
    @IBOutlet weak var solveButton: UIButton!
    @IBAction func askForSolution(_ sender: UIButton) {
        solveChance -= 1
        common.askForSolution()
    }
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeFaceCellMatrix()
    }
    
    var level = 1
    var solveChance = 30{
        didSet{
            if solveChance <= 0{
                disableButton(solveButton)
            }
        }
    }
    let rowAndColumnInAllLevels = [(2,2),(3,2),(3,3),(4,3),(4,4),(5,5),(6,6),(7,7),(8,8)]
    
    func makeFaceCellMatrix(){
        disableButton(nextLevelButton)
        (common.row,common.column) = rowAndColumnInAllLevels[level - 1]
        let FaceCellMatrix = common.makeFaceCellMatrix(self)
        FaceCellMatrix.delegate = self
        FaceCellMatrix.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        common.collectionView(collectionView, didSelectItemAt:indexPath)
        if common.faces.checkAllSmiles(){
            enableButton(nextLevelButton)
        }
    }
    
    func disableButton(_ button: UIButton){
        button.isUserInteractionEnabled = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.lightGray
    }
    
    func enableButton(_ button: UIButton){
        button.isUserInteractionEnabled = true
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.green
    }
    
}


