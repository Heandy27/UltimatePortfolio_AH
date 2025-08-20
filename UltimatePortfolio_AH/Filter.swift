import Foundation

// Definimos una estructura llamada Filter
// Sirve para representar un filtro dentro de la app
struct Filter: Identifiable, Hashable {
    // Cada filtro tiene un id único (UUID)
    var id: UUID
    // Nombre descriptivo del filtro (ej: "All Issues")
    var name: String
    // Nombre del icono SF Symbol que se usará en la UI
    var icon: String
    // Fecha mínima de modificación que tomará en cuenta el filtro
    // Por defecto es "Date.distantPast" (es decir, no limita por fecha)
    var minModificationDate = Date.distantPast
    // Filtro opcional por etiqueta (relacionado con la entidad Tag)
    var tag: Tag?
    
    
    // MARK: - Filtros estáticos predefinidos
    // Filtro que trae todos los elementos (sin restricción)
    
    static var all = Filter(id: UUID(), name: "All Issues", icon: "tray")
    // Filtro que trae solo los elementos modificados en la última semana
    static var recent = Filter(id: UUID(), name: "Recent issues", icon: "clock", minModificationDate: .now.addingTimeInterval(86400 * -7))
    
    
    // MARK: - Conformidad con Hashable
    
    // Método requerido por Hashable
    // Le dice al compilador cómo generar un "hash" para comparar objetos Filter
    
    
    // Swift (y SwiftUI internamente) usa este valor igual que lo hacen
    // estructuras como Set o Dictionary, para identificar elementos de forma única.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    
    // MARK: - Conformidad con Equatable
    
    // Definimos cuándo dos filtros son considerados iguales.
    // En este caso, dos filtros son iguales si comparten el mismo id.
    // Esto evita que existan duplicados en colecciones que dependen de Hashable.
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
    
}
