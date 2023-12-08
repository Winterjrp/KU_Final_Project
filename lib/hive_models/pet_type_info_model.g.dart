// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_type_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetTypeInfoModelAdapter extends TypeAdapter<PetTypeInfoModel> {
  @override
  final int typeId = 3;

  @override
  PetTypeInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetTypeInfoModel(
      petTypeID: fields[0] as String,
      petTypeName: fields[1] as String,
      petChronicDisease: (fields[2] as List).cast<PetChronicDiseaseModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PetTypeInfoModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.petTypeID)
      ..writeByte(1)
      ..write(obj.petTypeName)
      ..writeByte(2)
      ..write(obj.petChronicDisease);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetTypeInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PetChronicDiseaseModelAdapter
    extends TypeAdapter<PetChronicDiseaseModel> {
  @override
  final int typeId = 4;

  @override
  PetChronicDiseaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetChronicDiseaseModel(
      petChronicDiseaseID: fields[0] as String,
      petChronicDiseaseName: fields[1] as String,
      nutrientLimitInfo: (fields[2] as List).cast<NutrientLimitInfoModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PetChronicDiseaseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.petChronicDiseaseID)
      ..writeByte(1)
      ..write(obj.petChronicDiseaseName)
      ..writeByte(2)
      ..write(obj.nutrientLimitInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetChronicDiseaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
