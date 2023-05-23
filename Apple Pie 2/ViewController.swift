//
//  ViewController.swift
//  Apple Pie 2
//
//  Created by Alireza Karimi on 2023-05-23.
//

import UIKit

var listOfwords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
let incorrectMovesAllowed = 7



class ViewController: UIViewController {
  
  var totalWins = 0 {
    didSet {
      newRound()
    }
  }
  
  var totalLosses = 0 {
    didSet {
      newRound()
    }
  }
  
  @IBOutlet weak var treeImageView: UIImageView!
  @IBOutlet weak var correctWordLable: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var letterButtons: [UIButton]!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    newRound()
  }
  
  var currentGame: Game!
  
  func newRound() {
    if !listOfwords.isEmpty {
      let newword = listOfwords.removeFirst()
      currentGame = Game(word: newword,incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
      enableLetterButtons(true)
      updateUI()
    }
    else {
      enableLetterButtons(false)
    }
  }
  func enableLetterButtons(_ enable: Bool){
    for button in letterButtons {
      button.isEnabled = enable
    }
  }
  
  func updateUI() {
    var letters = [String]()
    for letter in currentGame.formattedWord{
      letters.append(String(letter))
    }
    let wordwithSpacing = letters.joined(separator: " ")
    correctWordLable.text = currentGame.formattedWord
    scoreLabel.text = "Wins: \(totalWins), Loses: \(totalLosses)"
    treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
  }

  @IBAction func letterButtonPressed(_ sender: UIButton) {
    sender.isEnabled = false
    
    let letterString = sender.configuration!.title!
    let letter = Character(letterString.lowercased())
    currentGame.playerGuessed(letter: letter)
    updateGameState()
  }
  
  func updateGameState(){
    if currentGame.incorrectMovesRemaining == 0 {
      totalLosses += 1
    }
    else if currentGame.word == currentGame.formattedWord{
      totalWins += 1
    } else {
      updateUI()
    }
  }
  
}

