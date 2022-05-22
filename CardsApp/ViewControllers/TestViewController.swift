//
//  TestViewController.swift
//  CardsApp
//
//  Created by Илья Гусаров on 23.05.2022.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet var textOfTest: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var stackViewButtons: UIStackView!
    @IBOutlet var answerButtons: [UIButton]!
    
    let words = ["cat": "кошка", "dog": "собака", "eye": "глаз", "leg": "нога", "tea": "чай", "cake": "торт", "laptop": "ноутбук", "apple": "яблоко", "snake": "змея", "milk": "молоко"]
    
    var getWord: [String : String] = [:]
    
    var countOfQuestions: Int {
        words.count
    }
    
    var knowWords = 0
    var timingWord = ""
    var progress = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWord = words
        
        updateUI()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let wordValue = sender.title(for: .normal)
        
        if wordValue == timingWord {
            knowWords += 1
            print(knowWords)
        }
        
        nextQuestion()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.wordsCount = countOfQuestions
        resultVC.knowWords = knowWords
    }

    @IBAction func unwind( _ seg: UIStoryboardSegue) {}

}

extension TestViewController {
    
    private func updateUI() {
        if words.count < 6 {
            textOfTest.text = "Тест временно не готов. Попробуйте изучить больше слов"
            stackViewButtons.isHidden = true
            return
        }
        guard let word = getWord.randomElement() else { return }
        getWord.removeValue(forKey: word.key)
        timingWord = word.value
        
        let progressive = Float(progress) / Float(countOfQuestions)
        progressView.setProgress(progressive, animated: true)
        
        textOfTest.text = word.key
        stackViewButtons.isHidden = false
        
        setTextForButtons(word.value)
        
    }
    
    private func nextQuestion() {
        progress += 1
        
        if progress < countOfQuestions {
            getWord = words
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
        
        progress = 0
        knowWords = 0
        progressView.setProgress(0, animated: true)
    }
    
    private func setTextForButtons(_ word: String) {
        let randomIndex = Int.random(in: 0...3)
        
        for (index, button) in zip(0...3, answerButtons) {
            if index == randomIndex {
                button.setTitle(word, for: .normal)
            } else {
                guard let randomWord = getWord.randomElement() else { return }
                button.setTitle(randomWord.value, for: .normal)
                getWord.removeValue(forKey: randomWord.key)
            }
        }
    }
    
    
}
