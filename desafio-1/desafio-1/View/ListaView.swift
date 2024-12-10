//
//  ListaView.swift
//  desafio-1
//
//  Created by Ignacio Zenteno on 09-12-24.
//

import SwiftUI

struct ListaView: View {
    @StateObject private var viewModel = TareaViewModel()
    @State private var isAddingTask = false
    @State private var tareaParaEditar: Tarea? = nil

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.tareas.isEmpty {
                    Text("Aún no has agregado tareas.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.tareas) { tarea in
                            HStack {
                                // Botón de Completar
                                Button(action: {
                                    viewModel.alternarTareaCompletada(tarea: tarea)
                                }) {
                                    Image(systemName: tarea.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(tarea.isCompleted ? .green : .gray)
                                }
                                .buttonStyle(PlainButtonStyle()) // Evita efectos secundarios de los botones dentro de una celda

                                // Título de la Tarea
                                Text(tarea.title)
                                    .strikethrough(tarea.isCompleted, color: .gray)
                                    .foregroundColor(tarea.isCompleted ? .gray : .primary)
                                    .onTapGesture {
                                        // Acciones adicionales si quieres que el texto también sea interactivo
                                    }

                                Spacer()

                                // Botón de Editar
                                Button(action: {
                                    tareaParaEditar = tarea
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle()) // Evita efectos secundarios de los botones

                                // Botón de Eliminar
                                Button(action: {
                                    if let index = viewModel.tareas.firstIndex(where: { $0.id == tarea.id }) {
                                        viewModel.tareas.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .contentShape(Rectangle()) // Define el área de toque únicamente para el HStack
                        }
                        .onDelete(perform: viewModel.eliminarTarea)
                    }
                }
            }
            .navigationTitle("Mis tareas")
            .navigationBarItems(trailing: Button(action: {
                isAddingTask = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddingTask) {
                AgregarView(viewModel: viewModel)
            }
            .sheet(item: $tareaParaEditar) { tarea in
                EditarView(viewModel: viewModel, tarea: tarea)
            }
        }
    }
}
