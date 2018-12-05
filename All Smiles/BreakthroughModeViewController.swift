//
//  ViewController.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/2.
//

import UIKit

class BreakthroughModeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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
        if level <= 8{
            level += 1
            view.viewWithTag(1)!.removeFromSuperview()
            FaceMatrix.removeAll()
            makeFaceCellMatrix()
        }
    }
    
    @IBOutlet weak var solveButton: UIButton!
    @IBAction func askForSolution(_ sender: UIButton) {
        solveChance -= 1
        solve()
        for (i,j) in solution{
            face(i, j).isStepOfSolution = true
        }
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
    var solveChance = 3{
        didSet{
            if solveChance <= 0{
                disableButton(solveButton)
            }
        }
    }
    let rowAndColumnInAllLevels = [(2,2),(3,2),(3,3),(4,3),(4,4),(5,5),(6,6),(7,7),(8,8)]
    var solution = [(Int,Int)]()
    var changeState = [(Int,Int)]()
    
    func makeFaceCellMatrix(){
        disableButton(nextLevelButton)
        (row,column) = rowAndColumnInAllLevels[level - 1]
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
            ensureSolutionExists()
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
        face(i0,j0).isStepOfSolution = false
        for i in 0..<row{
            face(i,j0).isSad = !face(i, j0).isSad
        }
        for j in 0..<column{
            face(i0,j).isSad = !face(i0, j).isSad
        }
        face(i0,j0).isSad = !face(i0, j0).isSad
        if checkAllSmiles(){
            enableButton(nextLevelButton)
        }
    }
    
    func checkAllSmiles() -> Bool
    {
        for face in FaceMatrix{
            if face.isSad{
                return false
            }
        }
        return true
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
    
    func ensureSolutionExists(){
        solve()
        for (i,j) in changeState{
            face(i, j).isSad = !face(i, j).isSad
        }
    }
    
    func solve(){
        changeState = []
        solution = []
        var temp = false
        var tempRow = Array(repeating: false, count: column)
        var tempColumn = Array(repeating: false, count: row)
        if row % 2 == 0 && column % 2 == 0{
            for i in 0..<row{
                for j in 0..<column{
                    tempColumn[i] ^= face(i, j).isSad
                }
            }
            for j in 0..<column{
                for i in 0..<row{
                    tempRow[j] ^= face(i, j).isSad
                }
            }
            for i in 0..<row{
                for j in 0..<column{
                    if tempRow[j] ^ tempColumn[i] ^ face(i, j).isSad {
                        solution.append((i,j))
                    }
                }
            }
        }
        
        else if row % 2 == 1 && column % 2 == 0{
            for i in 0..<row - 1{
                for j in 0..<column{
                    tempColumn[i] ^= face(i, j).isSad
                }
            }
            for j in 0..<column{
                for i in 0..<row - 1{
                    tempRow[j] ^= face(i, j).isSad
                }
            }
            tempColumn[row - 1] = tempRow[0] ^ face(row - 1, 0).isSad
            temp = tempColumn[row - 1]
            for i in 0..<row - 1{
                temp ^= tempColumn[i]
            }
            for j in 1..<column{
                if tempColumn[row - 1] ^ face(row - 1, j).isSad ^ tempRow[j]{
                    changeState.append((row - 1,j))
                }
            }
            for i in 0..<row - 1{
                if tempRow[0] ^ face(i, 0).isSad ^ tempColumn[i]{
                    solution.append((i,0))
                }
            }
            if temp{
                solution.append((row - 1,0))
            }
            for i in 0..<row - 1{
                for j in 1..<column{
                    if temp ^ tempColumn[i] ^ face(i, j).isSad ^ tempRow[j]{
                        solution.append((i,j))
                    }
                }
            }
        }
        
        else if row % 2 == 0 && column % 2 == 1{
            for j in 0..<column - 1{
                for i in 0..<row{
                    tempRow[j] ^= face(i, j).isSad
                }
            }
            for i in 0..<row{
                for j in 0..<column - 1{
                    tempColumn[i] ^= face(i, j).isSad
                }
            }
            tempRow[column - 1] = tempColumn[0] ^ face(0, column - 1).isSad
            temp = tempRow[column - 1]
            for j in 0..<column - 1{
                temp ^= tempRow[j]
            }
            for i in 1..<row{
                if tempRow[column - 1] ^ face(i, column - 1).isSad ^ tempColumn[i]{
                    changeState.append((i,column - 1))
                }
            }
            for j in 0..<column - 1{
                if tempColumn[0] ^ face(0, j).isSad ^ tempRow[j]{
                    solution.append((0,j))
                }
            }
            if temp{
                solution.append((0,column - 1))
            }
            for j in 0..<column - 1{
                for i in 1..<row{
                    if temp ^ tempColumn[i] ^ face(i, j).isSad ^ tempRow[j]{
                        solution.append((i,j))
                    }
                }
            }
        }
            
        else {
            for i in 1..<row{
                for j in 1..<column{
                    tempColumn[i] ^= face(i, j).isSad
                }
            }
            for j in 1..<column{
                for i in 1..<row{
                    tempRow[j] ^= face(i, j).isSad
                }
            }
            temp = face(0, 0).isSad
            for i in 1..<row{
                temp ^= tempColumn[i]
            }
            for i in 1..<row{
                if temp ^ tempColumn[i] ^ face(i, 0).isSad{
                    changeState.append((i,0))
                }
            }
            for j in 1..<column{
                if temp ^ tempRow[j] ^ face(0, j).isSad{
                    changeState.append((0,j))
                }
            }
            for i in 1..<row{
                for j in 1..<column{
                    if tempColumn[i] ^ tempRow[j] ^ face(i, j).isSad{
                        solution.append((i,j))
                    }
                }
            }
            if face(0, 0).isSad{
                solution.append((0,0))
            }
        }
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
    
    static func ^=(left: inout Bool, right: Bool) {
        left = left ^ right
    }
}
