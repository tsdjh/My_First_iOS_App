//
//  CommonFunctions.swift
//  All Smiles
//
//  Created by qml on 2018/12/6.
//

import UIKit

// 两种玩法模式的公共代码部分
class Common:UIViewController,UICollectionViewDataSource {
    let screenWidth = UIScreen.main.bounds.width
    var faces = FaceMatrix()
    var row = 2
    var column = 2
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faces.FaceMatrix.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let facecell = collectionView.dequeueReusableCell(withReuseIdentifier: "FaceCell", for: indexPath) as! FaceCell
        facecell.face = faces.FaceMatrix[indexPath.item].button
        facecell.contentView.addSubview(facecell.face)
        return facecell
    }
    
    // 显示表情阵列
    func makeFaceCellMatrix() -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        
        // 计算表情之间的空隙
        var margin = screenWidth / CGFloat(11 * max(column,row) + 3)
        if margin > 10{
            margin = 10
        }
        
        // 表情边长
        let sidelength = 10 * margin
        
        layout.itemSize = CGSize(width: sidelength, height: sidelength)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        // collectionView 的长宽
        let MatrixWidth = (CGFloat)(column * 11 - 1) * margin + 1
        let MatrixHeight = (CGFloat)(row * 11 - 1) * margin + 1
        let FaceCellMatrix = UICollectionView(frame: CGRect(x: 0, y: 0, width: MatrixWidth, height: MatrixHeight), collectionViewLayout: layout)
        FaceCellMatrix.center = view.center
        FaceCellMatrix.tag = 1
        FaceCellMatrix.register(FaceCell.self, forCellWithReuseIdentifier: "FaceCell")
        FaceCellMatrix.translatesAutoresizingMaskIntoConstraints = false
        
        // 如果随机生成的阵列正好全部是微笑，那么重新生成阵列
        repeat{
            faces = FaceMatrix(row: row,column: column,sidelength: sidelength)
            faces.ensureSolutionExists()
        }while faces.checkAllSmiles()
        
        view.addSubview(FaceCellMatrix)
        return FaceCellMatrix
    }
    
    // 一维索引转成二维索引
    func get2dIndex(_ index:Int) -> (Int,Int){
        return (index / column,index % column)
    }
    
    // 响应用户点击
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
