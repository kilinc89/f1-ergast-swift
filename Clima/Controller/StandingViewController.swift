

import UIKit

class StandingViewController: UIViewController {
    
   
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsTextLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var winsTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    var SsandingManager = StandingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SsandingManager.delegate = self
        searchTextField.delegate = self
    }

}

//MARK: - UITextFieldDelegate

extension StandingViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            SsandingManager.fetchChampions(cityName: city)
        }
        
        searchTextField.text = ""
        
    }
}

//MARK: - SsandingManagerDelegate


extension StandingViewController: StandingManagerDelegate {
    func didUpdateChampions(_ SsandingManager:StandingManager, standing: StandingModel) {
        DispatchQueue.main.async {
            self.pointsLabel.text = standing.points
            self.pointsTextLabel.text="points"
            self.winsLabel.text = standing.wins
            self.winsTextLabel.text="wins"
            self.nameLabel.text = standing.name
            self.lastNameLabel.text = standing.lastName
            
            self.brandLabel.text=standing.constractor
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


