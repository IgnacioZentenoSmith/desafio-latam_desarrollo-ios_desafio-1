//
//  Tarea.swift
//  desafio-1
//
//  Created by Ignacio Zenteno on 09-12-24.
//

import Foundation

struct Tarea: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
