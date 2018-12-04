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
        facecell.contentView.addSubview(facecell.face)
        return facecell
    }
    
    @IBOutlet weak var nextLevelButton: UIButton!
    @IBAction func nextLevel(_ sender: UIButton) {
        level += 1
        if level < 10{
            (row,column) = rowAndColumnInAllLevels[level - 2]
        }
        view.viewWithTag(1)!.removeFromSuperview()
        FaceMatrix.removeAll()
        makeFaceCellMatrix()
    }
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeFaceCellMatrix()
    }
    
    let screenWidth = UIScreen.main.bounds.width
    var FaceMatrix = [Face]()
    var level = 1
    var row = 2
    var column = 2
    var solveChance = 3
    let rowAndColumnInAllLevels = [(3,2),(3,3),(4,3),(4,4),(5,5),(6,6),(7,7),(8,8)]
    var solution = [(Int,Int)]()
    
    func makeFaceCellMatrix(){
        disableNextLevelButton()
        let layout = UICollectionViewFlowLayout()
        var sidelength = screenWidth / (1.1 * CGFloat(column) + 0.1)
        if sidelength > 100{
            sidelength = 100
        }
        let margin = sidelength * 0.1
        layout.itemSize = CGSize(width: sidelength, height: sidelength)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        let MatrixWidth = CGFloat(column) * sidelength + (CGFloat(column) - 1) * margin
        let MatrixHeight = CGFloat(row) * sidelength + (CGFloat(row) - 1) * margin
        let FaceCellMatrix = UICollectionView(frame: CGRect(x: 0, y: 0, width: MatrixWidth, height: MatrixHeight), collectionViewLayout: layout)
        FaceCellMatrix.tag = 1
        FaceCellMatrix.delegate = self
        FaceCellMatrix.dataSource = self
        FaceCellMatrix.register(FaceCell.self, forCellWithReuseIdentifier: "FaceCell")
        FaceCellMatrix.translatesAutoresizingMaskIntoConstraints = false
        FaceCellMatrix.center = view.center
        while checkAllSmiles(){
            FaceMatrix.removeAll()
            for _ in 0..<row * column{
                let face = Face(width: sidelength, height: sidelength)
                FaceMatrix.append(face)
            }
        }
        view.addSubview(FaceCellMatrix)
    }
        
    func face(_ i:Int,_ j:Int) -> Face{
        return FaceMatrix[i * column + j]
    }
        
    func get2dIndex(_ index:Int) -> (Int,Int){
        return (index / column,index % column)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let (i0,j0) = get2dIndex(indexPath.item)
        for i in 0..<row{
            face(i,j0).issmile = !face(i, j0).issmile
        }
        for j in 0..<column{
            face(i0,j).issmile = !face(i0, j).issmile
        }
        face(i0,j0).issmile = !face(i0, j0).issmile
        if checkAllSmiles(){
            enableNextLevelButton()
        }
    }
    
    func checkAllSmiles() -> Bool
    {
        for face in FaceMatrix{
            if !face.issmile{
                return false
            }
        }
        return true
    }
    
    func disableNextLevelButton(){
        nextLevelButton.isUserInteractionEnabled = false
        nextLevelButton.setTitleColor(UIColor.white, for: .normal)
        nextLevelButton.backgroundColor = UIColor.lightGray
    }
    
    func enableNextLevelButton(){
        nextLevelButton.isUserInteractionEnabled = true
        nextLevelButton.setTitleColor(UIColor.blue, for: .normal)
        nextLevelButton.backgroundColor = UIColor.green
    }
    
    func ensureSolutionExists(){
        
    }
    
}

extension Bool{
    static func ^(left: Bool, right: Bool) -> Bool {
        switch (left,right) {
        case (true,true):
            return false
        case (false,false):
            return false
        default:
            return true
        }
    }
}
