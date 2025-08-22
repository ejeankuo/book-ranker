//
//  RankingEngine.swift
//  book rating
//
//  Created by Ejean Kuo on 8/19/25.
//
//  pairwise ranking engine
//      -- inspired by Bradley-Terry model
//      -- assigns scores to fixed set of books based on pairwise comparisons
//         of these items; odds of book A betaing book B calculated by difference
//         in their scores
//
import Foundation

final class RankingEngine {
    private let alpha: Double = 0.15 // learning rate
    
    // sigmoid function
    //     -- predict the chance that book A beats book B
    //     -- take diff in their 'skills' and apply sigmoid equation
    // p(A beats B) = sigmoid (skillA - skillB)
    //     -- if skillA == skillB ; probability stays around 0.5
    //     -- if skillA > skillB  ; probabiltiy moves towards 1
    //     -- if skillB < skillA ; probability moves towards 0
    private func sigmoid(_ x: Double) -> Double {
        if x >= 0 {
            let z = Foundation.exp(-x)
            return 1.0 / (1.0 + z)
        } else {
            let z = Foundation.exp(x)
            return z / (1.0 + z)
        }
    }
    
    // updating winner/loser skills
    func update(winner: inout Book, loser: inout Book) {
        let pWin = sigmoid(winner.skill - loser.skill) // model's predicted winner wins
        // when the results are surprising, we want a bigger update
        let delta = alpha * (1.0 - pWin) // surprise factor
        winner.skill += delta
        loser.skill -= delta
        winner.wins += 1
        loser.losses += 1
    }
    
    // normalize skills
    func bucketScores(for books: [Book]) -> [UUID: Double] {
        guard let minS = books.map(\.skill).min(),
              let maxS = books.map(\.skill).max(),
              maxS > minS else {
            return Dictionary(uniqueKeysWithValues: books.map {($0.id, 5.0)})
        }
        return Dictionary(uniqueKeysWithValues: books.map { b in
            let norm = (b.skill - minS) / (maxS - minS)
            return (b.id, 10.0 * norm)
        })
    }
    
    // assign starting skills by sentiment so new books have reasonable skills
    static func seedSkill(for sentiment: Sentiment) -> Double {
        switch sentiment {
        // seed gap value of 1.2 ~~ 0.77 liked beats fine
        //   -- testing values:
        //   -- 0.85 - 1.0 = smaller gap
        //   -- 1.2 - 1.4 = larger gap
        case .liked: return 1.2 // starts favored
        case .fine: return 0.0 // neutral
        case .disliked: return -1.2 // unfavored
        }
    }
}

