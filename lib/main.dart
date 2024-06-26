import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/hive_models/ingredient_in_recipes_model.dart';
import 'package:untitled1/hive_models/ingredient_model.dart';
import 'package:untitled1/hive_models/pet_profile_model.dart';
import 'package:untitled1/hive_models/pet_type_info_model.dart';
import 'package:untitled1/hive_models/nutrient_limit_info_model.dart';
import 'package:untitled1/hive_models/recipes_model.dart';
import 'package:untitled1/modules/admin/admin_get_recipe/admin_get_recipe_view.dart';
import 'package:untitled1/modules/normal/login/responsive_login_view.dart';
import 'package:untitled1/modules/normal/my_pet_with_no_authen/my_pet_with_no_authen_view.dart';
import 'package:untitled1/modules/test.dart';
import 'package:untitled1/provider/authentication_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PetProfileModelAdapter());
  Hive.registerAdapter(IngredientModelAdapter());
  Hive.registerAdapter(NutrientModelAdapter());
  Hive.registerAdapter(PetTypeInfoModelAdapter());
  Hive.registerAdapter(PetChronicDiseaseModelAdapter());
  Hive.registerAdapter(NutrientLimitInfoModelAdapter());
  Hive.registerAdapter(IngredientInRecipeModelAdapter());
  Hive.registerAdapter(RecipeModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    bool isAuthen = true;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.mitrTextTheme(),
      ),
      home: ChangeNotifierProvider(
        create: (_) => AuthenticationProvider(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return const MyPetWithNoAuthenticationView();
            }
            return const AdminGetRecipeView();
            return const LoginView();
          },
        ),
      ),
    );
  }
}
