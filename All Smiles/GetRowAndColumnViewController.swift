//
//  GetRowAndColumnViewController.swift
//  All Smiles
//
//  Created by qml on 2018/12/6.
//

import UIKit

// 获取行数和列数
class GetRowAndColumnViewController: UIViewController {
    
    var rowNumber = 2
    
    var columnNumber = 2
    
    // 委托，用于传递行数和列数
    weak var delegate:GetRowAndColumnDelegate?
    
    @IBOutlet weak var rowSlider: UISlider!
    
    @IBOutlet weak var columnSlider: UISlider!
    
    @IBOutlet weak var rowNumberLabel: UILabel!
    
    @IBOutlet weak var columnNumberLabel: UILabel!
    
    @IBAction func setRowNumber() {
        rowNumber = lround(Double(rowSlider.value))
        rowSlider.value = Float(rowNumber)
        rowNumberLabel.text = String(rowNumber)
    }
    
    @IBAction func setColumnNumber() {
        columnNumber = lround(Double(columnSlider.value))
        columnSlider.value = Float(columnNumber)
        columnNumberLabel.text = String(columnNumber)
    }

    func done() {
        delegate?.getRowAndColumn(self, rowNumber: rowNumber, columnNumber: columnNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 点击 done 会产生从这个 viewController 到自定义模式的 viewController 的 segue
    // 在 storyboard 中将此 segue 的 identifier 设定为 "GetRowAndColumn"
    // 将自定义模式的 viewController 设置为委托
    // 通过 done() 函数调用委托的 getRowAndColumn 函数，达到传递行数和列数的目的
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GetRowAndColumn" {
            let controller = segue.destination as! CustomModeViewController
            self.delegate = controller
            done()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol GetRowAndColumnDelegate:class {
    func getRowAndColumn(_ controller:GetRowAndColumnViewController, rowNumber:Int, columnNumber:Int)
}
