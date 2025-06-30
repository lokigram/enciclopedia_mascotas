class ItemMascota {

  final String tipo;
  final String imagen;
  final String sonido;
  final String caracteristica;

  ItemMascota({
    required this.tipo,
    required this.imagen,
    required this.sonido,
    required this.caracteristica,
  });

  Map<String, dynamic> toJson() {
      return {
        'tipo': tipo,
        'imagen': imagen,
        'sonido': sonido,
        'caracteristica': caracteristica,
      };
  }

  factory ItemMascota.fromJson(Map<String, dynamic> json) {
    return ItemMascota(
      tipo: json['tipo'],
      imagen: json['imagen'],
      sonido: json['sonido'],
      caracteristica: json['caracteristica'],
    );
  }
    
}

abstract class Mascota {
  final String rasgo;
  final String color;
  final String retrato;
  bool esFavorito;

  Mascota({
    required this.rasgo,
    required this.color,
    required this.retrato,
    this.esFavorito = false,
  });

  String get tipo;
  String get descripcion;

  Map<String, dynamic> toJson();
}

class Cat extends Mascota {

  final String raza;

  Cat({
    required super.rasgo,
    required super.color,
    required super.retrato,
    required this.raza,
    super.esFavorito,
  });

  @override
  String get tipo => 'GATO';

  @override
  String get descripcion => 
      '$rasgo\nColor: $color';

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      raza: json['raza'],
      color: json['color'],
      rasgo: json['rasgo'],
      retrato: json['retrato'],
      esFavorito: json['esFavorito'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'raza': raza,
      'color': color,
      'rasgo': rasgo,
      'retrato': retrato,
      'esFavorito': esFavorito,
    };
  }
}

class Dog extends Mascota{
    final String raza;

  Dog({
    required super.rasgo,
    required super.color,
    required super.retrato,
    required this.raza,
    super.esFavorito,
  });

  @override
  String get tipo => 'PERRO';

  @override
  String get descripcion => 
      '$rasgo\nColor: $color';

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      color: json['color'],
      raza: json['raza'],
      rasgo: json['rasgo'],
      retrato: json['retrato'],
      esFavorito: json['esFavorito'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'raza': raza,
      'rasgo': rasgo,
      'retrato': retrato,
      'esFavorito': esFavorito
    };
  }
}

class Fish extends Mascota{
  final String especie;

  Fish( {
    required super.rasgo,
    required super.color,
    required super.retrato,
    required this.especie,
    super.esFavorito,
  });

  @override
  String get tipo => 'PESCADO';

  @override
  String get descripcion => 
      '$rasgo\nColor: $color';

  factory Fish.fromJson(Map<String, dynamic> json) {
    return Fish(

      rasgo: json['rasgo'],
      esFavorito: json['esFavorito'],
      especie: json['especie'],
      color: json['color'],
      retrato: json['retrato'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'rasgo': rasgo,
      'esFavorito': esFavorito,
      'especie': especie,
      'color': color,
      'retrato': retrato,
    };
  }
} 

class Hamster extends Mascota{
  final String raza;

  Hamster( {
    required super.rasgo,
    required super.color,
    required super.retrato,
    required this.raza,
    super.esFavorito,
  });

  @override
  String get tipo => 'HAMSTER';

  @override
  String get descripcion => 
      '$rasgo\nColor: $color';

  factory Hamster.fromJson(Map<String, dynamic> json) {
    return Hamster(
      rasgo: json['rasgo'],
      esFavorito: json['esFavorito'],
      raza: json['raza'],
      color: json['color'],
      retrato: json['retrato'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'rasgo': rasgo,
      'esFavorito': esFavorito,
      'raza': raza,
      'color': color,
      'retrato': retrato,
    };
  }
}

class Parrot extends Mascota{
  final String especie;

  Parrot( {
    required super.rasgo,
    super.esFavorito,
    required super.color,
    required super.retrato,
    required this.especie,
  });

  @override
  String get tipo => 'LORO';

  @override
  String get descripcion => 
      '$rasgo\nColor: $color';

  factory Parrot.fromJson(Map<String, dynamic> json) {
    return Parrot(
      rasgo: json['rasgo'],
      esFavorito: json['esFavorito'],
      especie: json['especie'],
      color: json['color'],
      retrato: json['retrato'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'rasgo': rasgo,
      'esFavorito': esFavorito,
      'especie': especie,
      'color': color,
      'retrato': retrato,
    };
  }
}

class Rabbit extends Mascota{
  final String raza;

  Rabbit( {
    required super.rasgo,
    super.esFavorito,
    required super.color,
    required super.retrato,
    required this.raza,
  });

  @override
  String get tipo => 'CONEJO';

  @override
  String get descripcion => 
      '$rasgo\nColor: $color';

  factory Rabbit.fromJson(Map<String, dynamic> json) {
    return Rabbit(
      rasgo: json['rasgo'],
      esFavorito: json['esFavorito'],
      raza: json['raza'],
      color: json['color'],
      retrato: json['retrato'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'rasgo': rasgo,
      'esFavorito': esFavorito,
      'raza': raza,
      'color': color,
      'retrato': retrato,
    };
  }
}

class Tortoise extends Mascota{
  final String especie;

  Tortoise( {
    required super.rasgo,
    super.esFavorito,
    required super.color,
    required super.retrato,
    required this.especie,
  });

  @override
  String get tipo => 'TORTUGA';

  @override
  String get descripcion => 
      '$rasgo\nColor: $color';
  
  factory Tortoise.fromJson(Map<String, dynamic> json) {
    return Tortoise(
      rasgo: json['rasgo'],
      esFavorito: json['esFavorito'],
      especie: json['especie'],
      color: json['color'],
      retrato: json['retrato'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'rasgo': rasgo,
      'esFavorito': esFavorito,
      'especie': especie,
      'color': color,
      'retrato': retrato,
    };
  }
}