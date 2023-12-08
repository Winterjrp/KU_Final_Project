// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipesModelAdapter extends TypeAdapter<RecipesModel> {
  @override
  final int typeId = 7;

  @override
  RecipesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipesModel(
      recipesID: fields[0] as String,
      recipesName: fields[1] as String,
      petTypeName: fields[2] as String,
      ingredientInRecipes: (fields[3] as List).cast<IngredientInRecipesModel>(),
      nutrient: (fields[4] as List).cast<NutrientModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.recipesID)
      ..writeByte(1)
      ..write(obj.recipesName)
      ..writeByte(2)
      ..write(obj.petTypeName)
      ..writeByte(3)
      ..write(obj.ingredientInRecipes)
      ..writeByte(4)
      ..write(obj.nutrient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
