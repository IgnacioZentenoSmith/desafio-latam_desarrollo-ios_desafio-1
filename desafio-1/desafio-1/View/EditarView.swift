//
//  EditarView.swift
//  desafio-1
//
//  Created by Ignacio Zenteno on 09-12-24.
//

import SwiftUI

struct EditarView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var tareaTitle: String
    @State private var isCompleted: Bool
    @ObservedObject var viewModel: TareaViewModel
    let tarea: Tarea

    init(viewModel: TareaViewModel, tarea: Tarea) {
        self.viewModel = viewModel
        self.tarea = tarea
        _tareaTitle = State(initialValue: tarea.title)
        _isCompleted = State(initialValue: tarea.isCompleted)
    }

    var body: some View {
        NavigationView {
            Form {
                // Campo de Título
                Section(header: Text("Título")) {
                    TextField("Edita el título de la tarea", text: $tareaTitle)
                }

                // Selector de Estado
                Section(header: Text("Estado")) {
                    Picker("Estado", selection: $isCompleted) {
                        Text("Pendiente").tag(false)
                        Text("Completada").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Editar Tarea")
            .navigationBarItems(leading: Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Guardar") {
                viewModel.editarTarea(tarea: tarea, title: tareaTitle, isCompleted: isCompleted)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
