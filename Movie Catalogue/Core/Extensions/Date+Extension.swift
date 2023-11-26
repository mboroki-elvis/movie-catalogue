import Foundation

extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var toMovieYearString: String? {
        Self.formatter.string(from: self)
    }
}
