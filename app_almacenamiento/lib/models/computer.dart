class Computer {
  final int? id; // Nullable para cuando es un nuevo registro
  final String tipo;
  final String marca;
  final String cpu;
  final String ram;
  final String hddSsd;

  Computer({
    this.id,
    required this.tipo,
    required this.marca,
    required this.cpu,
    required this.ram,
    required this.hddSsd,
  });

  // Método para crear un objeto Computer desde un JSON (usado al LEER datos)
  factory Computer.fromJson(Map<String, dynamic> json) {
    return Computer(
      id: json['id'],
      tipo: json['tipo'],
      marca: json['marca'],
      cpu: json['cpu'],
      ram: json['ram'],
      hddSsd: json['hdd_ssd'],
    );
  }

  // Método para convertir el objeto Computer a un JSON (usado al CREAR/ACTUALIZAR datos)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'marca': marca,
      'cpu': cpu,
      'ram': ram,
      'hdd_ssd': hddSsd,
    };
  }
}
