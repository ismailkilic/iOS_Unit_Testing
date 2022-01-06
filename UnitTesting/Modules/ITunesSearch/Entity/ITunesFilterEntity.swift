//
//  ITunesFilterEntity.swift
//  UnitTesting


import Foundation

enum ITunesFilterEntity {
    case movies
    case musics
    case apps
    case books

    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .musics:
            return "Musics"
        case .apps:
            return "Apps"
        case .books:
            return "Books"
        }
    }

    var paramValue: String {
        switch self {
        case .movies:
            return "movie"
        case .musics:
            return "song"
        case .apps:
            return "software"
        case .books:
            return "ebook"
        }
    }
}
