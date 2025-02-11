import Foundation

class GridManager {
    var viewController: ViewController?
    
    var grid = Array(repeating: 0, count: 16)
    
    func startGame() {
        grid = Array(repeating: 0, count: 16)
        addRandomTile()
        addRandomTile()
    }
    
    func addRandomTile() {
        let emptyCells = grid.indices.filter { grid[$0] == 0 }
        guard let randomIndex = emptyCells.randomElement() else { return }
        grid[randomIndex] = [2, 4].randomElement() ?? 2
    }
    
    func compressRow(_ row: [Int]) -> [Int] {
        let filtered = row.filter { $0 != 0 } // Supprime les 0
        let missing = Array(repeating: 0, count: 4 - filtered.count) // Complète avec des 0
        return filtered + missing
    }
    
    func mergeRow(_ row: [Int]) -> [Int] {
        var newRow = compressRow(row)
        var i = 0
        
        while i < newRow.count - 1 {
            if newRow[i] == newRow[i + 1] && newRow[i] != 0 {
                viewController?.increaseScore(val: newRow[i])
                newRow[i] *= 2  // Fusionner les tuiles
                newRow[i + 1] = 0  // Laisser la case vide après fusion
                i += 2  // Sauter une case après la fusion
            } else {
                i += 1
            }
        }
        return compressRow(newRow)  // Compress encore pour faire disparaître les cases vides
    }
    
    func isMoveValid(_ direction: String) -> Bool {
        // Cloner la grille avant le mouvement
        let initialGrid = grid
        
        // Appliquer le mouvement sur la grille clonée
        switch direction {
        case "left":
            moveLeft()
        case "right":
            moveRight()
        case "up":
            moveUp()
        case "down":
            moveDown()
        default:
            return false
        }
        
        // Vérifier si la grille a changé
        let isValidMove = grid != initialGrid
        
        // Si la grille n'a pas changé, annuler le mouvement
        if !isValidMove {
            grid = initialGrid
        }
        
        return isValidMove
    }

    
    func moveLeft() {
        for i in 0..<4 {
            let start = i * 4
            let row = Array(grid[start..<start+4]) // Récupère une ligne
            let newRow = mergeRow(row) // Compresse les cases
            for j in 0..<4 {
                grid[start + j] = newRow[j] // Remplace dans la grille
            }
        }
    }

    func moveRight() {
        for i in 0..<4 {
            let start = i * 4
            let row = Array(grid[start..<start+4])
            let newRow = Array(mergeRow(Array(row.reversed())).reversed()) // On inverse 2 fois
            for j in 0..<4 {
                grid[start + j] = newRow[j]
            }
        }
    }

    func moveUp() {
        for col in 0..<4 {
            let column = (0..<4).map { grid[$0 * 4 + col] }
            let newColumn = mergeRow(column)
            for row in 0..<4 {
                grid[row * 4 + col] = newColumn[row]
            }
        }
    }

    func moveDown() {
        for col in 0..<4 {
            let column = (0..<4).map { grid[$0 * 4 + col] }
            let newColumn = Array(mergeRow(Array(column.reversed())).reversed())
            for row in 0..<4 {
                grid[row * 4 + col] = newColumn[row]
            }
        }
    }

}
