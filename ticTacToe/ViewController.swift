//
//  ViewController.swift
//  ticTacToe
//
//  Created by C4Q  on 9/27/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ticTacToeView: UIView!
    var isPlayerOneTurn = true
    
    @IBOutlet weak var gameInfoLabel: UILabel!
    
    enum Square: String {
        case x = "X"
        case o = "O"
        case blank = ""
    }
    
    enum GameStatus {
        case playerOneVictory, playerTwoVictory, catsGame, inProgress
    }
    
    var board = Array(repeatElement([Square.blank, Square.blank, Square.blank], count: 3)) 
    
    @IBAction func ticTacToeButtonPressed(_ sender: UIButton) {
        let column: Int = sender.tag % 3
        let row: Int
        switch sender.tag {
        case 0...2:
            row = 0
        case 3...5:
            row = 1
        case 6...8:
            row = 2
        default:
            print("ERROR")
            row = -1
        }
        guard board[row][column] == Square.blank else {
            return
        }
        if isPlayerOneTurn {
            board[row][column] = Square(rawValue: "X")!
            sender.setTitle("X", for: .normal)
            sender.titleLabel?.text = Square.x.rawValue
        } else {
            board[row][column] = Square(rawValue: "O")!
            sender.setTitle("O", for: .normal)
        }
        switch statusCheck() {
        case .inProgress:
            isPlayerOneTurn = !isPlayerOneTurn
            gameInfoLabel.text = (isPlayerOneTurn ? "Player One's Turn" : "Player Two's Turn")
        case .playerOneVictory:
            toggleButtons(.off)
            gameInfoLabel.text = "Player One Wins!"
        case .playerTwoVictory:
            toggleButtons(.off)
            gameInfoLabel.text = "Player Two Wins"
        case .catsGame:
            toggleButtons(.off)
            gameInfoLabel.text = "Cat's Game!"
        }
    }
    enum NewButtonState {
        case on, off
    }
    func toggleButtons(_ state: NewButtonState) {
        for view in ticTacToeView.subviews {
            if let button = view as? UIButton {
                switch state {
                case .on:
                    button.isEnabled = true
                    button.setTitle("", for: .normal)
                    board = Array(repeatElement([Square.blank, Square.blank, Square.blank], count: 3))
                case .off:
                    button.isEnabled = false
                }
            }
        }
    }
    
    func horizontalVictoryCheck(board: [[Square]], player: Square) -> Bool {
        for row in 0..<3 {
            if board[row].reduce(true, {$0 && $1 == player}) {
                return true
            }
        }
        return false
    }
    
    func diagonalVictory(board: [[Square]], player: Square) -> Bool {
        var leftDiag = true
        var rightDiag = true
        for index in 0..<board.count {
            leftDiag = leftDiag && board[index][index] == player
            rightDiag = rightDiag && board[index][board.count - 1 - index] == player
        }
        return leftDiag || rightDiag
    }
    
    func statusCheck() -> GameStatus {
        //Horizontal Win
        if horizontalVictoryCheck(board: board, player: .x) {
            return .playerOneVictory
        }
        if horizontalVictoryCheck(board: board, player: .o) {
            return .playerTwoVictory
        }
        //Vertical Win
        var rotatedBoard = board
        for row in 0..<board.count {
            for column in 0..<board[row].count {
                rotatedBoard[column][board[row].count - 1 - row] = board[row][column]
            }
        }
        if horizontalVictoryCheck(board: rotatedBoard, player: .x) {
            return .playerOneVictory
        }
        if horizontalVictoryCheck(board: rotatedBoard, player: .o) {
            return .playerTwoVictory
        }
        //Diagonal Win
        if diagonalVictory(board: rotatedBoard, player: .x) {
            return .playerOneVictory
        }
        if diagonalVictory(board: rotatedBoard, player: .o) {
            return .playerTwoVictory
        }
        //At least one more space
        for row in board {
            if row.contains(.blank) {
                return .inProgress
            }
        }
        //Board is full and there are no winners
        return .catsGame
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        toggleButtons(.on)
    }
}

