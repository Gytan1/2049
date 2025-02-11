import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GestureDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    let gestureManager = GestureManager()
    var gridManager: GridManager!
    
    @IBOutlet weak var score: UITextField!
    @IBOutlet weak var highScore: UITextField!
    
    var score_val: Int = 0
    var highScore_val: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridManager = GridManager()
        gridManager.viewController = self  // Passer la référence de ViewController à GridManager
        
        score.isUserInteractionEnabled = false
        highScore.isUserInteractionEnabled = false
        
        updateScoreLabels()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TileCell.self, forCellWithReuseIdentifier: "cell")
        
        gestureManager.delegate = self
        gestureManager.addSwipeGestures(to: view)
        
        gridManager.startGame()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TileCell
        cell.configure(value: gridManager.grid[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let totalSpacing: CGFloat = 10 * 3  // 3 espaces de 10 points entre les cellules
        let cellWidth = (collectionView.frame.width - totalSpacing) / 4
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func didSwipe(_ direction: UISwipeGestureRecognizer.Direction) {
        var directionString: String
        
        switch direction {
        case .left: directionString = "left"
        case .right: directionString = "right"
        case .up: directionString = "up"
        case .down: directionString = "down"
        default: return
        }
        
        if gridManager.isMoveValid(directionString) {
            switch direction {
            case .left: gridManager.moveLeft()
            case .right: gridManager.moveRight()
            case .up: gridManager.moveUp()
            case .down: gridManager.moveDown()
            default: break
            }
            gridManager.addRandomTile()
            collectionView.reloadData()
        }
    }
    
    func increaseScore(val: Int){
        self.score_val += val
        updateScoreLabels()
    }
    
    func updateScoreLabels() {
        score.text = "\(score_val)"
        highScore.text = "\(highScore_val)"
    }
    
    func restartGame(){
        gridManager.startGame()
        if (score_val > highScore_val){
            highScore_val = score_val
        }
        score_val = 0
        updateScoreLabels()
        
        collectionView.reloadData()
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        showRestartAlert()
    }
    
    func showRestartAlert() {
        // Créer l'alerte
        let alert = UIAlertController(title: "new game",
                                      message: "are you sure about that pal ?",
                                      preferredStyle: .alert)

        // Ajouter le bouton de confirmation (OK)
        let confirmAction = UIAlertAction(title: "Yep", style: .destructive) { _ in
            // Relancer la partie
            self.restartGame()
        }

        // Ajouter le bouton d'annulation (Annuler)
        let cancelAction = UIAlertAction(title: "Nope", style: .cancel, handler: nil)

        // Ajouter les actions à l'alerte
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        // Afficher l'alerte
        present(alert, animated: true, completion: nil)
    }


}
