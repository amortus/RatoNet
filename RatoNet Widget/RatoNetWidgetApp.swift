import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in _: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in _: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in _: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct RatoNetWidgetAppEntryView: View {
    @Environment(\.widgetRenderingMode) var renderingMode
    var entry: Provider.Entry

    var body: some View {
        switch renderingMode {
        case .accented:
            Image("AppIconAccented")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .widgetAccentable(true)
        default:
            Image("AppIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
    }
}

@main
struct RatoNetWidgetApp: Widget {
    let kind: String = "RatoNetWidgetApp"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                RatoNetWidgetAppEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                RatoNetWidgetAppEntryView(entry: entry)
            }
        }
        .configurationDisplayName("RatoNet")
        .description("RatoNet widget.")
    }
}
