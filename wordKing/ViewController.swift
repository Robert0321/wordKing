//
//  ViewController.swift
//  wordKing
//
//  Created by user on 23/1/23.
//

import UIKit
import CodableCSV

extension Word {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "word")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
            }
        }
        return array
    }
}


class ViewController: UIViewController {
    
    
    var word = Word.data.shuffled()
    
    //用變數紀錄第N題 從第一題開始
    var index = 0
    //統計問答的總數
    var count:Int = 1
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var wordOpen: UIImageView!
    @IBOutlet weak var wordOff: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //預設值
        questionLabel.text = word[index].question
        answerLabel.text = ""
        
        //統計題目
        //totalLabel.text = String(bunny.count)
        let total = String(word.count)
        //統計題目
        totalLabel.text = String(index+1) + "/" + total
        word.shuffled()
    }
    
    
    @IBAction func showAnswer(_ sender: Any) {
        answerLabel.text = word[index].answer
        wordOpen.isHidden = false
        wordOff.isHidden = true
    }

    @IBAction func next(_ sender: Any) {
        index = (index + 1) % word.count
        questionLabel.text = word[index].question
        answerLabel.text = ""
        // 題目累加
        //count = count + 1
        let total = String(word.count)
        //統計題目
        totalLabel.text = String(index+1) + "/" + total
        
        //顯示未答題的兔子狀態
        wordOpen.isHidden = true
        wordOff.isHidden = false
        //進度條
        progressSlider.value = Float(index)
    }
    
    @IBAction func replay(_ sender: Any) {
        var index = 0
        var count:Int = 1
        questionLabel.text = word[index].question
        answerLabel.text = ""
        let total = String(word.count)
        totalLabel.text = String(index+1) + "/" + total
    }
    
}



