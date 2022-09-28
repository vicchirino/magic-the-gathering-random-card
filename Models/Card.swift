//
//  Card.swift
//  magic-database
//
//  Created by Victor Chirino on 28/09/2022.
//

import Foundation
import Combine


struct Card: Decodable {
    let id: String
    let name: String
    let layout: String
    let type: String
    let oracleText: String
    let flavorText: String?
    let artist: String
    let rarity: String
    let setName: String
    
    struct CardImageURIs: Decodable {
        let small: String
        let normal: String
        let large: String
        let artCrop: String
        
        enum CodingKeys: String, CodingKey {
            case small
            case normal
            case large
            case artCrop = "art_crop"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            small = try values.decode(String.self, forKey: .small)
            normal = try values.decode(String.self, forKey: .normal)
            large = try values.decode(String.self, forKey: .large)
            artCrop = try values.decode(String.self, forKey: .artCrop)
        }
    }

    let imageURIs: CardImageURIs
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case layout
        case artist
        case rarity
        case setName = "set_name"
        case type = "type_line"
        case oracleText = "oracle_text"
        case imageURIs = "image_uris"
        case flavorText = "flavor_text"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        rarity = try values.decode(String.self, forKey: .rarity)
        artist = try values.decode(String.self, forKey: .artist)
        layout = try values.decode(String.self, forKey: .layout)
        type = try values.decode(String.self, forKey: .type)
        setName = try values.decode(String.self, forKey: .setName)
        var _flavorText: String?
        do {
            _flavorText = try values.decode(String.self, forKey: .flavorText)
        } catch {
            _flavorText = nil
        }
        flavorText = _flavorText
        oracleText = try values.decode(String.self, forKey: .oracleText)
        imageURIs = try values.decode(CardImageURIs.self, forKey: .imageURIs)
    }
    
}
