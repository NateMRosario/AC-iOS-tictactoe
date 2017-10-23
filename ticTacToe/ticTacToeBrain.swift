//
//  ticTacToeBrain.swift
//  ticTacToe
//
//  Created by C4Q  on 9/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//


//var arrayOfArray = [[0,1,2,3,5], [8,8,3,4,5], [3,7,8,9,5]]
//return [3,5]


import Foundation

class TicTacToeBrain {
    var num = 0
    var winningCombo = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var player = 1 //1 = X, 2 = O
    var board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var game = true
    var playerXScore = 0
    var playerOScore = 0
    
    func Condition() {
        for combo in winningCombo {
            if board[combo[0]] != 0 && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] {
                game = false
                if board[combo[0]] == 1 {
                    playerXScore += 1
                    num = 1
                } else {
                    playerOScore += 1
                    num = 2
                }
            }
        }
        if num == 1 || num == 2 {
        } else if !board.contains(0) {
                num = 3
            }
        }
    
    func restart() {
        num = 0
        player = 1
        game = true
        board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
    func reset() {
        playerXScore = 0
        playerOScore = 0
    }
}

