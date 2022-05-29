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
    
    var words: [String : String] = [:]
    
    var wrongAnswers: [String: String] = [:]
    
    var workingDict: [String : String] = [:]
    
    var correctWords = 0
    var progress = 0
    var checkingWord = ""
   
    var answered = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        words = KnowCards.cards
        workingDict = words
        updateUI()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if !answered {
            answered = true
            let wordFromButton = sender.title(for: .normal)
            
            if wordFromButton == checkingWord {
                sender.backgroundColor = Color.green
                correctWords += 1
            } else {
                sender.backgroundColor = Color.red
                for button in answerButtons {
                    if button.title(for: .normal) == checkingWord {
                        button.backgroundColor = Color.green
                        wrongAnswers[textOfTest.text ?? ""] = checkingWord
                        print(wrongAnswers)
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.nextQuestion()
                self.answered = false
                for button in self.answerButtons {
                    button.backgroundColor = Color.blue
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.wordsCount = words.count
        resultVC.correctWords = correctWords
        resultVC.wrongAnswers = wrongAnswers
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
        let index = workingDict.index(workingDict.startIndex, offsetBy: progress)
        let word = workingDict[index]
        
        workingDict.removeValue(forKey: word.key)
        checkingWord = word.value
        
        let progressive = Float(progress) / Float(words.count)
        progressView.setProgress(progressive, animated: true)
        
        textOfTest.text = word.key
        stackViewButtons.isHidden = false
        
        setTextForButtons(word.value)
        
    }
    
    private func setTextForButtons(_ word: String) {
        let randomIndex = Int.random(in: 0...3)
        
        for (index, button) in zip(0...3, answerButtons) {
            if index == randomIndex {
                button.setTitle(word, for: .normal)
            } else {
                guard let randomWord = workingDict.randomElement() else { return }
                button.setTitle(randomWord.value, for: .normal)
                workingDict.removeValue(forKey: randomWord.key)
            }
        }
    }
    
    
    private func nextQuestion() {
        progress += 1
        
        if progress < words.count {
            workingDict = words
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
        
        progress = 0
        correctWords = 0
        progressView.setProgress(0, animated: true)
        wrongAnswers = [:]
    }
    
}
