import SwiftUI

@main
struct RatoNetWatchApp: App {
    @StateObject var model: Model
    static var globalModel: Model?

    init() {
        RatoNetWatchApp.globalModel = Model()
        _model = StateObject(wrappedValue: RatoNetWatchApp.globalModel!)
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(model)
        }
    }
}
