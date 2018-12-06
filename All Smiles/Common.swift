//
//  CommonFunctions.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/6.
//

import UIKit

class Common {
    let screenWidth = UIScreen.main.bounds.width
    var faces = FaceMatrix()
    var row = 2
    var column = 2
    
    func collectionView(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let facecell = collectionView.dequeueReusableCell(withReuseIdentifier: "FaceCell", for: indexPath) as! FaceCell
        facecell.face = faces.FaceMatrix[indexPath.item].button
        facecell.contentView.addSubview(facecell.face)
        return facecell
    }
    
    func makeFaceCellMatrix(_ viewController: UIViewController) -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        var margin = screenWidth / CGFloat(11 * column + 3)
        if margin > 10{
            margin = 10
        }
        let sidelength = 10 * margin
        layout.itemSize = CGSize(width: sidelength, height: sidelength)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        let MatrixWidth = (CGFloat)(column * 11 - 1) * margin + 1
        let MatrixHeight = (CGFloat)(row * 11 - 1) * margin + 1
        let FaceCellMatrix = UICollectionView(frame: CGRect(x: 0, y: 0, width: MatrixWidth, height: MatrixHeight), collectionViewLayout: layout)
        FaceCellMatrix.center = viewController.view.center
        FaceCellMatrix.tag = 1
            
        FaceCellMatrix.register(FaceCell.self, forCellWithReuseIdentifier: "FaceCell")
        FaceCellMatrix.translatesAutoresizingMaskIntoConstraints = false
        while faces.checkAllSmiles(){
            faces = FaceMatrix(row: row,column: column,sidelength: sidelength)
            faces.ensureSolutionExists()
        }
        viewController.view.addSubview(FaceCellMatrix)
        return FaceCellMatrix
    }
    
    func get2dIndex(_ index:Int) -> (Int,Int){
        return (index / column,index % column)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let (i0,j0) = get2dIndex(indexPath.item)
        faces.face(i0,j0).isStepOfSolution = false
        for i in 0..<row{
            faces.face(i,j0).isSad = !faces.face(i, j0).isSad
        }
        for j in 0..<column{
            faces.face(i0,j).isSad = !faces.face(i0, j).isSad
        }
        faces.face(i0,j0).isSad = !faces.face(i0, j0).isSad
    }
    
    func askForSolution(){
        let (_,solution) = faces.solve()
        for (i,j) in solution{
            faces.face(i, j).isStepOfSolution = !faces.face(i, j).isStepOfSolution
        }
    }
}
