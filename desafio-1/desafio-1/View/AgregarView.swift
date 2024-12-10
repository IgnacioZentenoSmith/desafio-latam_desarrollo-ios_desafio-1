//
//  AgregarView.swift
//  desafio-1
//
//  Created by Ignacio Zenteno on 09-12-24.
//

import SwiftUI

struct AgregarView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var tareaTitle: String = "" // Título inicial de la tarea
    @State private var isCompleted: Bool = false // Estado inicial de la tarea
    @ObservedObject var viewModel: TareaViewModel // Referencia al ViewModel

    var body: some View {
        NavigationView {
            Form {
                // Campo de Título
                Section(header: Text("Título")) {
                    TextField("Escribe el título de la tarea", text: $tareaTitle)
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
            .navigationTitle("Nueva Tarea")
            .navigationBarItems(leading: Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Agregar") {
                if !tareaTitle.isEmpty {
                    viewModel.agregarTarea(title: tareaTitle, isCompleted: isCompleted)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
