import 'package:flutter/material.dart';
import '../services/computer_service.dart';
import '../models/computer.dart';

class ComputerFormScreen extends StatefulWidget {
  // Recibe el objeto Computer (será null si es CREACIÓN)
  final Computer? computer;

  const ComputerFormScreen({super.key, this.computer});

  @override
  State<ComputerFormScreen> createState() => _ComputerFormScreenState();
}

class _ComputerFormScreenState extends State<ComputerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ComputerService _service = ComputerService();

  // Controladores para los campos de texto
  final _tipoController = TextEditingController();
  final _marcaController = TextEditingController();
  final _cpuController = TextEditingController();
  final _ramController = TextEditingController();
  final _hddSsdController = TextEditingController();

  // Determina si estamos editando o creando
  bool get _isEditing => widget.computer != null;

  @override
  void initState() {
    super.initState();
    // Si está en modo EDICIÓN, precarga los controladores
    if (_isEditing) {
      _tipoController.text = widget.computer!.tipo;
      _marcaController.text = widget.computer!.marca;
      _cpuController.text = widget.computer!.cpu;
      _ramController.text = widget.computer!.ram;
      _hddSsdController.text = widget.computer!.hddSsd;
    }
  }

  void _saveComputer() async {
    // 1. Valida todos los campos del formulario
    if (_formKey.currentState!.validate()) {
      // Crea el objeto con los datos del formulario
      final computerData = Computer(
        id: widget.computer?.id, // Mantiene el ID si estamos editando
        tipo: _tipoController.text,
        marca: _marcaController.text,
        cpu: _cpuController.text,
        ram: _ramController.text,
        hddSsd: _hddSsdController.text,
      );

      try {
        if (_isEditing) {
          // Llama a la función de ACTUALIZAR
          await _service.updateComputer(computerData);
        } else {
          // Llama a la función de CREAR
          await _service.createComputer(computerData);
        }

        // 2. Muestra mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Computadora ${_isEditing ? 'actualizada' : 'creada'} con éxito.',
            ),
          ),
        );

        // 3. Cierra la pantalla y retorna 'true' para refrescar la lista
        Navigator.pop(context, true);
      } catch (e) {
        // Muestra error si falla la comunicación con la API/DB
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al guardar: $e')));
      }
    }
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se destruye
    _tipoController.dispose();
    _marcaController.dispose();
    _cpuController.dispose();
    _ramController.dispose();
    _hddSsdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Computadora' : 'Nueva Computadora'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo TIPO
              TextFormField(
                controller: _tipoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo (Ej: Laptop, Escritorio)',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el tipo de equipo.' : null,
              ),
              const SizedBox(height: 15),

              // Campo MARCA
              TextFormField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese la marca.' : null,
              ),
              const SizedBox(height: 15),

              // Campo CPU
              TextFormField(
                controller: _cpuController,
                decoration: const InputDecoration(
                  labelText: 'CPU (Ej: i7, M4, Ryzen 7)',
                ),
                validator: (value) => value!.isEmpty ? 'Ingrese el CPU.' : null,
              ),
              const SizedBox(height: 15),

              // Campo RAM
              TextFormField(
                controller: _ramController,
                decoration: const InputDecoration(
                  labelText: 'RAM (Ej: 16 GB, 32 GB)',
                ),
                validator: (value) => value!.isEmpty ? 'Ingrese la RAM.' : null,
              ),
              const SizedBox(height: 15),

              // Campo HDD/SSD
              TextFormField(
                controller: _hddSsdController,
                decoration: const InputDecoration(
                  labelText: 'Almacenamiento (Ej: 1 TB SSD, 500 GB HDD)',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el almacenamiento.' : null,
              ),
              const SizedBox(height: 30),

              // Botón de Guardar
              ElevatedButton.icon(
                onPressed: _saveComputer,
                icon: Icon(_isEditing ? Icons.save : Icons.add),
                label: Text(
                  _isEditing ? 'ACTUALIZAR' : 'GUARDAR',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
