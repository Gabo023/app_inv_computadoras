import 'package:flutter/material.dart';
import '../services/computer_service.dart';
import '../models/computer.dart';
import 'computer_form_screen.dart'; // Importa la pantalla de formulario

class ComputerListScreen extends StatefulWidget {
  const ComputerListScreen({super.key});

  @override
  State<ComputerListScreen> createState() => _ComputerListScreenState();
}

class _ComputerListScreenState extends State<ComputerListScreen> {
  // Inicializa la variable que contendrá el Future con los datos
  late Future<List<Computer>> _computersFuture;
  final ComputerService _service = ComputerService();

  @override
  void initState() {
    super.initState();
    _computersFuture = _service.fetchComputers(); // Carga inicial
  }

  // Función para actualizar la lista después de cualquier operación CRUD
  void _refreshList() {
    setState(() {
      _computersFuture = _service.fetchComputers();
    });
  }

  // Lógica para navegar al formulario y refrescar la lista si hubo cambios
  void _navigateToForm({Computer? computer}) async {
    // El 'await' espera a que se cierre la pantalla de formulario.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComputerFormScreen(computer: computer),
      ),
    );

    // Si el formulario retorna 'true', hubo un cambio (guardar/editar) y refrescamos.
    if (result == true) {
      _refreshList();
    }
  }

  // Función para manejar la eliminación
  void _deleteComputer(int id) async {
    try {
      await _service.deleteComputer(id);
      _refreshList(); // Refresca la lista al eliminar con éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Computadora eliminada con éxito.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al eliminar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Computadoras'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: FutureBuilder<List<Computer>>(
        future: _computersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Muestra carga
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            ); // Muestra error
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay computadoras registradas.'),
            ); // Sin datos
          }

          // Muestra la lista si los datos están listos
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final computer = snapshot.data![index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    '${computer.marca} (${computer.tipo})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'CPU: ${computer.cpu} | RAM: ${computer.ram} | Almacenamiento: ${computer.hddSsd}',
                  ),
                  leading: CircleAvatar(child: Text(computer.id.toString())),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botón de EDICIÓN
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.amber),
                        onPressed: () => _navigateToForm(
                          computer: computer,
                        ), // Pasa el objeto para editar
                      ),
                      // Botón de ELIMINACIÓN
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteComputer(computer.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // Botón para crear nuevo registro
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(), // Sin objeto para crear
        child: const Icon(Icons.add),
      ),
    );
  }
}
