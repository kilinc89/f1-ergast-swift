
import Foundation
import CoreLocation

protocol ChampionManagerDelegate {
    func didUpdateChampions(_ standingManager: StandingManager, standing: StandingModel)
    func didFailWithError(error: Error)
}

struct ChampionManager {
    let f1URL = "http://ergast.com/api/f1/"
    
    var delegate: ChampionManagerDelegate?
    
    func fetchWeather_(cityName: String) {
        let urlString = f1URL+cityName+"/driverStandings"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
             
            }
            task.resume()
        }
    }
    
}



