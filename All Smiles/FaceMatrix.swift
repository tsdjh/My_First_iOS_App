//
//  FaceMatrix.swift
//  All Smiles
//
//  Created by qml on 2018/12/6.
//

import UIKit

// 阵列存储以及解题算法
class FaceMatrix{
    let row:Int
    let column:Int
    var FaceMatrix = [Face]()
    
    init(row:Int,column:Int,sidelength:CGFloat){
        self.row = row
        self.column = column
        for _ in 0..<row * column{
            let face = Face(width: sidelength, height: sidelength)
            FaceMatrix.append(face)
        }
    }
    
    init(){
        row = 2
        column = 2
        FaceMatrix = []
    }
    
    // 检查是否满足通关条件
    func checkAllSmiles() -> Bool
    {
        for face in FaceMatrix{
            if face.isSad{
                return false
            }
        }
        return true
    }
    
    func face(_ i:Int,_ j:Int) -> Face{
        return FaceMatrix[i * column + j]
    }
    
    // 如果随机产生的阵列无解，那么改变其中的一些表情，使阵列有解
    func ensureSolutionExists(){
        let (changeState,_) = solve()
        for (i,j) in changeState{
            face(i, j).isSad = !face(i, j).isSad
        }
    }
    
    // 主算法
    func solve() -> ([(Int,Int)],[(Int,Int)]){
        // 如果无解，存储需要改变的表情的位置
        var changeState = [(Int,Int)]()
        
        // 存储解，以便提示玩家
        var solution = [(Int,Int)]()
        
        var temp = false
        
        // 给阵列额外添加一行和一列，用于存储中间数据
        var tempRow = Array(repeating: false, count: column)
        var tempColumn = Array(repeating: false, count: row)
        
        // 分情况讨论：行数和列数都是偶数；一奇一偶；都是奇数
        // 详细的算法需要用到线性代数的知识，这里不写了
        // 都是偶数（必然有解）：
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
            
        // 行奇列偶：
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
            
            // 行偶列奇，和行奇列偶的情况几乎完全一样
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
            
            // 都是奇数
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
        
        return (changeState,solution)
    }
}

// 为了方便运算，给 bool 型添加异或运算
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
