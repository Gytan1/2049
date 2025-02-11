import Foundation

extension Array {
    func get2DIndex(row: Int, col: Int) -> Int {
        return row * 4 + col
    }
}
