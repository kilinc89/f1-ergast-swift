

import UIKit

class StandingViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
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
            self.temperatureLabel.text = standing.lastName
            self.cityLabel.text = standing.name
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


