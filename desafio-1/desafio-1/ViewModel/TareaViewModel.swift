//
//  TareaViewModel.swift
//  desafio-1
//
//  Created by Ignacio Zenteno on 09-12-24.
//

import Foundation

class TareaViewModel: ObservableObject {
    @Published var tareas: [Tarea] = [] // Lista de tareas observables

    // Agregar una nueva tarea
    func agregarTarea(title: String, isCompleted: Bool = false) {
        guard !title.isEmpty else { return }
        let nuevaTarea = Tarea(title: title, isCompleted: isCompleted)
        tareas.append(nuevaTarea)
    }
    
    // Cambiar el estado de la tarea -> recibe el objeto tarea
    func alternarTareaCompletada(tarea: Tarea) {
        if let index = tareas.firstIndex(where: { $0.id == tarea.id }) {
            tareas[index].isCompleted.toggle()
        }
    }

    // Eliminar tarea
    func eliminarTarea(at offsets: IndexSet) {
        tareas.remove(atOffsets: offsets)
    }
    
    // Editar tarea existente
    func editarTarea(tarea: Tarea, title: String, isCompleted: Bool) {
        if let index = tareas.firstIndex(where: { $0.id == tarea.id }) {
            tareas[index].title = title
            tareas[index].isCompleted = isCompleted
        }
    }
}
