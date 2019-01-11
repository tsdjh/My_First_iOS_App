//
//  ViewController.swift
//  All Smiles
//
//  Created by 钦明珑 on 2018/12/2.
//

import UIKit

// 闯关模式
class BreakthroughModeViewController: Common,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    // Common 类集中了两种玩法模式相同的代码
    @IBOutlet weak var nextLevelButton: UIButton!
    
    @IBOutlet weak var solveButton0: UIButton!
    
    @IBOutlet weak var solveButton1: UIButton!
    
    @IBOutlet weak var solveButton2: UIButton!
    
    @IBAction func nextLevel() {
        // 进入下一关
        if level <= 8{
            level += 1
            savedLevel = level
            // 删除原来的 collectionView
            view.viewWithTag(1)!.removeFromSuperview()
            createFaceCellMatrix()
        }else{
            // 如果通关，则移除所有除背景图片以外的子视图，并显示祝贺文字
            for subview in view.subviews{
                if subview.tag != 2{
                    subview.removeFromSuperview()
                }
            }
            let width = screenWidth / 2
            let height = UIScreen.main.bounds.height / 3
            let congratulateMessage = UITextView(frame: CGRect(x: width / 2, y: height, width: width, height: height))
            congratulateMessage.font = UIFont(name: "Arial", size: 20)
            congratulateMessage.text = "祝贺你！\n你已经通过了所有关卡！"
            congratulateMessage.isEditable = false
            congratulateMessage.textColor = UIColor.yellow
            congratulateMessage.backgroundColor = nil
            view.addSubview(congratulateMessage)
            // 通关之后玩家可以再次闯关
            savedLevel = 1
        }
    }
    
    @IBAction func askForSolution(_ button: UIButton) {
        button.isEnabled = false
        if solveButtonsEnabled[0]{
            solveButtonsEnabled[0] = false
        }else if solveButtonsEnabled[1]{
            solveButtonsEnabled[1] = false
        }else{
            solveButtonsEnabled[2] = false
        }
        askForSolution()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        solveButton0.isEnabled = solveButtonsEnabled[0]
        solveButton1.isEnabled = solveButtonsEnabled[1]
        solveButton2.isEnabled = solveButtonsEnabled[2]
        createFaceCellMatrix()
    }
    
    var level = savedLevel
    // 记录所有关卡的行数和列数
    let rowAndColumnInAllLevels = [(2,2),(3,2),(3,3),(4,3),(4,4),(5,5),(6,6),(7,7),(8,8)]
    
    func createFaceCellMatrix(){
        nextLevelButton.isEnabled = false
        (row,column) = rowAndColumnInAllLevels[level - 1]
        let FaceCellMatrix = makeFaceCellMatrix()
        FaceCellMatrix.delegate = self
        FaceCellMatrix.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt:indexPath)
        // 如果达到过关要求，可以进入下一关
        if faces.checkAllSmiles(){
            nextLevelButton.isEnabled = true
        }
    }
}

// 全局变量，暂存通关进度，关闭 app 后失效
var savedLevel = 1

var solveButtonsEnabled = [true,true,true]
