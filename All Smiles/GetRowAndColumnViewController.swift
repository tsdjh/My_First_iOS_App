//
//  GetRowAndColumnViewController.swift
//  All Smiles
//
//  Created by 王东宇 on 2018/12/6.
//

import UIKit

class GetRowAndColumnViewController: UIViewController {
    var rowNumber = 2
    var columnNumber = 2
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
//    @IBAction
    func done() {
        delegate?.getRowAndColumn(self, rowNumber: rowNumber, columnNumber: columnNumber)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
