//
//  DetailView.swift
//  Scrumdinger
//
//  Created by George Mapaya on 2022-06-18.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section("Meeting Info") {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Meeting Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            
            Section("Attendees") {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView()
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel", role: .cancel) {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Edit") {
                    isPresentingEditView = true
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let scrum = DailyScrum.sampleData[0]
    static var previews: some View {
        NavigationView {
            DetailView(scrum: scrum)
        }
    }
}
