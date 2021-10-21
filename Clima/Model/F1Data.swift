
import Foundation

struct ChampionData: Codable {
    let MRData:MRData
}

struct MRData: Codable {
    let series:String
    let StandingsTable:StandingsTable
}

struct StandingsTable: Codable {
    let season:String
    let StandingsLists: [StandingsLists]
}

struct StandingsLists: Codable {

    let DriverStandings:[DriverStandings]
}

struct DriverStandings: Codable {
    let points:String
    let wins:String
    let Driver:Driver
    let Constructors:[Constructors]
}

struct Driver: Codable {
    let givenName:String
    let familyName:String
}

struct Constructors: Codable {
    let name:String
        
}
