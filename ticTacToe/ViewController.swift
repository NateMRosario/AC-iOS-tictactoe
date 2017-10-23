//
//  ViewController.swift
//  ticTacToe
//
//  Created by C4Q  on 9/27/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrayOfButtons: [UIButton] = []
    var brain = TicTacToeBrain()
    var buttons = GameButton()
    @IBOutlet weak var scoreX: UILabel!
    @IBOutlet weak var scoreO: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var one: GameButton!
    @IBOutlet weak var two: GameButton!
    @IBOutlet weak var three: GameButton!
    @IBOutlet weak var four: GameButton!
    @IBOutlet weak var five: GameButton!
    @IBOutlet weak var six: GameButton!
    @IBOutlet weak var seven: GameButton!
    @IBOutlet weak var eight: GameButton!
    @IBOutlet weak var nine: GameButton!
    @IBOutlet weak var splatAnimation: UIImageView!
    
    override func viewDidLoad() {
        `switch`.isUserInteractionEnabled = false
        arrayOfButtons = [one, two, three, four, five, six, seven, eight, nine]
        super.viewDidLoad()
    }
    func scoreUpdate() {
        scoreX.text = brain.playerXScore.description
        scoreO.text = brain.playerOScore.description
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        if brain.board[sender.tag] == 0 && brain.game == true {
            brain.board[sender.tag] = brain.player
            if brain.player == 1 {
                sender.setBackgroundImage(#imageLiteral(resourceName: "X"), for: .normal)
                brain.player = 2
                `switch`.isOn = true
            } else {
                sender.setBackgroundImage(#imageLiteral(resourceName: "O"), for: .normal)
                brain.player = 1
                `switch`.isOn = false
            }
        }
        win()
    }
    func win() {
        brain.Condition()
        let result = brain.num
        switch result {
        case 1:
            winnerLabel.text = "Player X has won!"
        case 2:
            winnerLabel.text = "Player O has won!"
        case 3:
            winnerLabel.text = "It was a draw!"
            winnerLabel.isHidden = false
            for button in arrayOfButtons {
                button.isUserInteractionEnabled = false
            }
        default:
            break
        }
        if result == 1 || result == 2 {
            winnerLabel.isHidden = false
            for button in arrayOfButtons {
                button.isUserInteractionEnabled = false
            }
        } 
        scoreUpdate()
    }
    
    @IBAction func resetScore(_ sender: UIButton) {
        brain.reset()
        scoreUpdate()
    }
    @IBAction func retry(_ sender: UIButton) {
        brain.restart()
        `switch`.isOn = false
        winnerLabel.isHidden = true
        for button in arrayOfButtons {
            button.setBackgroundImage(nil, for: .normal)
            button.isUserInteractionEnabled = true
        }
    }
}
