

import Foundation

protocol StandingManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateChampions(_ standingManager: StandingManager, standing: StandingModel)
}

struct StandingManager {
    var delegate: StandingManagerDelegate?

    let f1URL = "https://ergast.com/api/f1/"
    
    func fetchChampions(cityName: String) {
        let urlString = f1URL+cityName+"/driverStandings/1.json"
        performRequest_(with: urlString)
    }
    
  
    
    func performRequest_(with urlString: String) {
        if let url = URL(string: urlString) {
           
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let standing = self.parseJSON_(safeData) {
                        self.delegate?.didUpdateChampions(self, standing: standing)
                    }
                }
             
            }
            task.resume()
        }
    }
    
    func parseJSON_(_ championData: Data) -> StandingModel? {
        let decoder = JSONDecoder()
       
        do {
            let decodedData = try decoder.decode(ChampionData.self, from: championData)
            let name = decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings[0].Driver.givenName
            let lastName = decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings[0].Driver.familyName
            let points=decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings[0].points
            let wins=decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings[0].wins
            let constractor=decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings[0].Constructors[0].name
            let standing = StandingModel(name:name,lastName:lastName,constractor:constractor, points:points, wins:wins)
            return standing

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}


