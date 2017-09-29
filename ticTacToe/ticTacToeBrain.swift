//
//  ticTacToeBrain.swift
//  ticTacToe
//
//  Created by C4Q  on 9/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum GameStatus {
    enum GameEndStatus {
        case playerOneVictory
        case playerTwoVictory
        case catsGame
    }
    case gameOver(GameEndStatus)
    case playerOneCompletedMove
    case playerTwoCompletedMove
    case invalidMove
}

class ticTacToeBrain {
    func didSelectPosition(row: Int, column: Int) -> GameStatus {
        guard board[row][column] == Square.blank else {
            return .invalidMove
        }
        board[row][column] = isPlayerOneTurn ? Square.x : Square.o
        //Horizontal Win
        if horizontalVictoryCheck(board: board, player: .x) {
            return .gameOver(.playerOneVictory)
        }
        if horizontalVictoryCheck(board: board, player: .o) {
            return .gameOver(.playerTwoVictory)
        }
        //Vertical Win
        var rotatedBoard = board
        for row in 0..<board.count {
            for column in 0..<board[row].count {
                rotatedBoard[column][board[row].count - 1 - row] = board[row][column]
            }
        }
        if horizontalVictoryCheck(board: rotatedBoard, player: .x) {
            return .gameOver(.playerOneVictory)
        }
        if horizontalVictoryCheck(board: rotatedBoard, player: .o) {
            return .gameOver(.playerTwoVictory)
        }
        //Diagonal Win
        if diagonalVictory(board: rotatedBoard, player: .x) {
            return .gameOver(.playerOneVictory)
        }
        if diagonalVictory(board: rotatedBoard, player: .o) {
            return .gameOver(.playerTwoVictory)
        }
        //At least one more space
        for row in board {
            if row.contains(.blank) {
                let status = isPlayerOneTurn ? GameStatus.playerOneCompletedMove : GameStatus.playerTwoCompletedMove
                isPlayerOneTurn = !isPlayerOneTurn
                return status
            }
        }
        //Board is full and there are no winners
        return .gameOver(.catsGame)
    }
    private func horizontalVictoryCheck(board: [[Square]], player: Square) -> Bool {
        for row in 0..<3 {
            if board[row].reduce(true, {$0 && $1 == player}) {
                return true
            }
        }
        return false
    }
    
    private func diagonalVictory(board: [[Square]], player: Square) -> Bool {
        var leftDiag = true
        var rightDiag = true
        for index in 0..<board.count {
            leftDiag = leftDiag && board[index][index] == player
            rightDiag = rightDiag && board[index][board.count - 1 - index] == player
        }
        return leftDiag || rightDiag
    }
    private enum Square {
        case x
        case o
        case blank
    }
    
    private var board = Array(repeatElement([Square.blank, Square.blank, Square.blank], count: 3))
    private var isPlayerOneTurn = true
}
