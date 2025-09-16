// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoodsTable extends Foods with TableInfo<$FoodsTable, Food> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameKoMeta = const VerificationMeta('nameKo');
  @override
  late final GeneratedColumn<String> nameKo = GeneratedColumn<String>(
      'name_ko', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _subcategoryMeta =
      const VerificationMeta('subcategory');
  @override
  late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
      'subcategory', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _kcalPer100gMeta =
      const VerificationMeta('kcalPer100g');
  @override
  late final GeneratedColumn<double> kcalPer100g = GeneratedColumn<double>(
      'kcal_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _carbsPer100gMeta =
      const VerificationMeta('carbsPer100g');
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
      'carbs_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _proteinPer100gMeta =
      const VerificationMeta('proteinPer100g');
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
      'protein_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fatPer100gMeta =
      const VerificationMeta('fatPer100g');
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
      'fat_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fiberPer100gMeta =
      const VerificationMeta('fiberPer100g');
  @override
  late final GeneratedColumn<double> fiberPer100g = GeneratedColumn<double>(
      'fiber_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sugarPer100gMeta =
      const VerificationMeta('sugarPer100g');
  @override
  late final GeneratedColumn<double> sugarPer100g = GeneratedColumn<double>(
      'sugar_per100g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sodiumPer100gMeta =
      const VerificationMeta('sodiumPer100g');
  @override
  late final GeneratedColumn<double> sodiumPer100g = GeneratedColumn<double>(
      'sodium_per100g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _ingredientsMeta =
      const VerificationMeta('ingredients');
  @override
  late final GeneratedColumn<String> ingredients = GeneratedColumn<String>(
      'ingredients', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1000),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _allergensMeta =
      const VerificationMeta('allergens');
  @override
  late final GeneratedColumn<String> allergens = GeneratedColumn<String>(
      'allergens', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _isVerifiedMeta =
      const VerificationMeta('isVerified');
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
      'is_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_verified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameKo,
        nameEn,
        category,
        subcategory,
        brand,
        kcalPer100g,
        carbsPer100g,
        proteinPer100g,
        fatPer100g,
        fiberPer100g,
        sugarPer100g,
        sodiumPer100g,
        description,
        ingredients,
        allergens,
        isVerified,
        isActive,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods';
  @override
  VerificationContext validateIntegrity(Insertable<Food> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_ko')) {
      context.handle(_nameKoMeta,
          nameKo.isAcceptableOrUnknown(data['name_ko']!, _nameKoMeta));
    } else if (isInserting) {
      context.missing(_nameKoMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('subcategory')) {
      context.handle(
          _subcategoryMeta,
          subcategory.isAcceptableOrUnknown(
              data['subcategory']!, _subcategoryMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('kcal_per100g')) {
      context.handle(
          _kcalPer100gMeta,
          kcalPer100g.isAcceptableOrUnknown(
              data['kcal_per100g']!, _kcalPer100gMeta));
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
          _carbsPer100gMeta,
          carbsPer100g.isAcceptableOrUnknown(
              data['carbs_per100g']!, _carbsPer100gMeta));
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
          _proteinPer100gMeta,
          proteinPer100g.isAcceptableOrUnknown(
              data['protein_per100g']!, _proteinPer100gMeta));
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
          _fatPer100gMeta,
          fatPer100g.isAcceptableOrUnknown(
              data['fat_per100g']!, _fatPer100gMeta));
    }
    if (data.containsKey('fiber_per100g')) {
      context.handle(
          _fiberPer100gMeta,
          fiberPer100g.isAcceptableOrUnknown(
              data['fiber_per100g']!, _fiberPer100gMeta));
    }
    if (data.containsKey('sugar_per100g')) {
      context.handle(
          _sugarPer100gMeta,
          sugarPer100g.isAcceptableOrUnknown(
              data['sugar_per100g']!, _sugarPer100gMeta));
    }
    if (data.containsKey('sodium_per100g')) {
      context.handle(
          _sodiumPer100gMeta,
          sodiumPer100g.isAcceptableOrUnknown(
              data['sodium_per100g']!, _sodiumPer100gMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('ingredients')) {
      context.handle(
          _ingredientsMeta,
          ingredients.isAcceptableOrUnknown(
              data['ingredients']!, _ingredientsMeta));
    }
    if (data.containsKey('allergens')) {
      context.handle(_allergensMeta,
          allergens.isAcceptableOrUnknown(data['allergens']!, _allergensMeta));
    }
    if (data.containsKey('is_verified')) {
      context.handle(
          _isVerifiedMeta,
          isVerified.isAcceptableOrUnknown(
              data['is_verified']!, _isVerifiedMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Food map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Food(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nameKo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ko'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      subcategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subcategory']),
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      kcalPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}kcal_per100g'])!,
      carbsPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_per100g'])!,
      proteinPer100g: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}protein_per100g'])!,
      fatPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_per100g'])!,
      fiberPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fiber_per100g'])!,
      sugarPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sugar_per100g']),
      sodiumPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sodium_per100g']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      ingredients: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ingredients']),
      allergens: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}allergens']),
      isVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_verified'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(attachedDatabase, alias);
  }
}

class Food extends DataClass implements Insertable<Food> {
  final int id;
  final String nameKo;
  final String? nameEn;
  final String category;
  final String? subcategory;
  final String? brand;
  final double kcalPer100g;
  final double carbsPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double fiberPer100g;
  final double? sugarPer100g;
  final double? sodiumPer100g;
  final String? description;
  final String? ingredients;
  final String? allergens;
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Food(
      {required this.id,
      required this.nameKo,
      this.nameEn,
      required this.category,
      this.subcategory,
      this.brand,
      required this.kcalPer100g,
      required this.carbsPer100g,
      required this.proteinPer100g,
      required this.fatPer100g,
      required this.fiberPer100g,
      this.sugarPer100g,
      this.sodiumPer100g,
      this.description,
      this.ingredients,
      this.allergens,
      required this.isVerified,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_ko'] = Variable<String>(nameKo);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || subcategory != null) {
      map['subcategory'] = Variable<String>(subcategory);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    map['kcal_per100g'] = Variable<double>(kcalPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    map['fiber_per100g'] = Variable<double>(fiberPer100g);
    if (!nullToAbsent || sugarPer100g != null) {
      map['sugar_per100g'] = Variable<double>(sugarPer100g);
    }
    if (!nullToAbsent || sodiumPer100g != null) {
      map['sodium_per100g'] = Variable<double>(sodiumPer100g);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || ingredients != null) {
      map['ingredients'] = Variable<String>(ingredients);
    }
    if (!nullToAbsent || allergens != null) {
      map['allergens'] = Variable<String>(allergens);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      id: Value(id),
      nameKo: Value(nameKo),
      nameEn:
          nameEn == null && nullToAbsent ? const Value.absent() : Value(nameEn),
      category: Value(category),
      subcategory: subcategory == null && nullToAbsent
          ? const Value.absent()
          : Value(subcategory),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      kcalPer100g: Value(kcalPer100g),
      carbsPer100g: Value(carbsPer100g),
      proteinPer100g: Value(proteinPer100g),
      fatPer100g: Value(fatPer100g),
      fiberPer100g: Value(fiberPer100g),
      sugarPer100g: sugarPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(sugarPer100g),
      sodiumPer100g: sodiumPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(sodiumPer100g),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      ingredients: ingredients == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredients),
      allergens: allergens == null && nullToAbsent
          ? const Value.absent()
          : Value(allergens),
      isVerified: Value(isVerified),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Food.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Food(
      id: serializer.fromJson<int>(json['id']),
      nameKo: serializer.fromJson<String>(json['nameKo']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      category: serializer.fromJson<String>(json['category']),
      subcategory: serializer.fromJson<String?>(json['subcategory']),
      brand: serializer.fromJson<String?>(json['brand']),
      kcalPer100g: serializer.fromJson<double>(json['kcalPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      fiberPer100g: serializer.fromJson<double>(json['fiberPer100g']),
      sugarPer100g: serializer.fromJson<double?>(json['sugarPer100g']),
      sodiumPer100g: serializer.fromJson<double?>(json['sodiumPer100g']),
      description: serializer.fromJson<String?>(json['description']),
      ingredients: serializer.fromJson<String?>(json['ingredients']),
      allergens: serializer.fromJson<String?>(json['allergens']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameKo': serializer.toJson<String>(nameKo),
      'nameEn': serializer.toJson<String?>(nameEn),
      'category': serializer.toJson<String>(category),
      'subcategory': serializer.toJson<String?>(subcategory),
      'brand': serializer.toJson<String?>(brand),
      'kcalPer100g': serializer.toJson<double>(kcalPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'fiberPer100g': serializer.toJson<double>(fiberPer100g),
      'sugarPer100g': serializer.toJson<double?>(sugarPer100g),
      'sodiumPer100g': serializer.toJson<double?>(sodiumPer100g),
      'description': serializer.toJson<String?>(description),
      'ingredients': serializer.toJson<String?>(ingredients),
      'allergens': serializer.toJson<String?>(allergens),
      'isVerified': serializer.toJson<bool>(isVerified),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Food copyWith(
          {int? id,
          String? nameKo,
          Value<String?> nameEn = const Value.absent(),
          String? category,
          Value<String?> subcategory = const Value.absent(),
          Value<String?> brand = const Value.absent(),
          double? kcalPer100g,
          double? carbsPer100g,
          double? proteinPer100g,
          double? fatPer100g,
          double? fiberPer100g,
          Value<double?> sugarPer100g = const Value.absent(),
          Value<double?> sodiumPer100g = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> ingredients = const Value.absent(),
          Value<String?> allergens = const Value.absent(),
          bool? isVerified,
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Food(
        id: id ?? this.id,
        nameKo: nameKo ?? this.nameKo,
        nameEn: nameEn.present ? nameEn.value : this.nameEn,
        category: category ?? this.category,
        subcategory: subcategory.present ? subcategory.value : this.subcategory,
        brand: brand.present ? brand.value : this.brand,
        kcalPer100g: kcalPer100g ?? this.kcalPer100g,
        carbsPer100g: carbsPer100g ?? this.carbsPer100g,
        proteinPer100g: proteinPer100g ?? this.proteinPer100g,
        fatPer100g: fatPer100g ?? this.fatPer100g,
        fiberPer100g: fiberPer100g ?? this.fiberPer100g,
        sugarPer100g:
            sugarPer100g.present ? sugarPer100g.value : this.sugarPer100g,
        sodiumPer100g:
            sodiumPer100g.present ? sodiumPer100g.value : this.sodiumPer100g,
        description: description.present ? description.value : this.description,
        ingredients: ingredients.present ? ingredients.value : this.ingredients,
        allergens: allergens.present ? allergens.value : this.allergens,
        isVerified: isVerified ?? this.isVerified,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Food copyWithCompanion(FoodsCompanion data) {
    return Food(
      id: data.id.present ? data.id.value : this.id,
      nameKo: data.nameKo.present ? data.nameKo.value : this.nameKo,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      category: data.category.present ? data.category.value : this.category,
      subcategory:
          data.subcategory.present ? data.subcategory.value : this.subcategory,
      brand: data.brand.present ? data.brand.value : this.brand,
      kcalPer100g:
          data.kcalPer100g.present ? data.kcalPer100g.value : this.kcalPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      fatPer100g:
          data.fatPer100g.present ? data.fatPer100g.value : this.fatPer100g,
      fiberPer100g: data.fiberPer100g.present
          ? data.fiberPer100g.value
          : this.fiberPer100g,
      sugarPer100g: data.sugarPer100g.present
          ? data.sugarPer100g.value
          : this.sugarPer100g,
      sodiumPer100g: data.sodiumPer100g.present
          ? data.sodiumPer100g.value
          : this.sodiumPer100g,
      description:
          data.description.present ? data.description.value : this.description,
      ingredients:
          data.ingredients.present ? data.ingredients.value : this.ingredients,
      allergens: data.allergens.present ? data.allergens.value : this.allergens,
      isVerified:
          data.isVerified.present ? data.isVerified.value : this.isVerified,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Food(')
          ..write('id: $id, ')
          ..write('nameKo: $nameKo, ')
          ..write('nameEn: $nameEn, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('brand: $brand, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fiberPer100g: $fiberPer100g, ')
          ..write('sugarPer100g: $sugarPer100g, ')
          ..write('sodiumPer100g: $sodiumPer100g, ')
          ..write('description: $description, ')
          ..write('ingredients: $ingredients, ')
          ..write('allergens: $allergens, ')
          ..write('isVerified: $isVerified, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nameKo,
      nameEn,
      category,
      subcategory,
      brand,
      kcalPer100g,
      carbsPer100g,
      proteinPer100g,
      fatPer100g,
      fiberPer100g,
      sugarPer100g,
      sodiumPer100g,
      description,
      ingredients,
      allergens,
      isVerified,
      isActive,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Food &&
          other.id == this.id &&
          other.nameKo == this.nameKo &&
          other.nameEn == this.nameEn &&
          other.category == this.category &&
          other.subcategory == this.subcategory &&
          other.brand == this.brand &&
          other.kcalPer100g == this.kcalPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.fiberPer100g == this.fiberPer100g &&
          other.sugarPer100g == this.sugarPer100g &&
          other.sodiumPer100g == this.sodiumPer100g &&
          other.description == this.description &&
          other.ingredients == this.ingredients &&
          other.allergens == this.allergens &&
          other.isVerified == this.isVerified &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodsCompanion extends UpdateCompanion<Food> {
  final Value<int> id;
  final Value<String> nameKo;
  final Value<String?> nameEn;
  final Value<String> category;
  final Value<String?> subcategory;
  final Value<String?> brand;
  final Value<double> kcalPer100g;
  final Value<double> carbsPer100g;
  final Value<double> proteinPer100g;
  final Value<double> fatPer100g;
  final Value<double> fiberPer100g;
  final Value<double?> sugarPer100g;
  final Value<double?> sodiumPer100g;
  final Value<String?> description;
  final Value<String?> ingredients;
  final Value<String?> allergens;
  final Value<bool> isVerified;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FoodsCompanion({
    this.id = const Value.absent(),
    this.nameKo = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.category = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.brand = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.fiberPer100g = const Value.absent(),
    this.sugarPer100g = const Value.absent(),
    this.sodiumPer100g = const Value.absent(),
    this.description = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.allergens = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.id = const Value.absent(),
    required String nameKo,
    this.nameEn = const Value.absent(),
    required String category,
    this.subcategory = const Value.absent(),
    this.brand = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.fiberPer100g = const Value.absent(),
    this.sugarPer100g = const Value.absent(),
    this.sodiumPer100g = const Value.absent(),
    this.description = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.allergens = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : nameKo = Value(nameKo),
        category = Value(category);
  static Insertable<Food> custom({
    Expression<int>? id,
    Expression<String>? nameKo,
    Expression<String>? nameEn,
    Expression<String>? category,
    Expression<String>? subcategory,
    Expression<String>? brand,
    Expression<double>? kcalPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? fiberPer100g,
    Expression<double>? sugarPer100g,
    Expression<double>? sodiumPer100g,
    Expression<String>? description,
    Expression<String>? ingredients,
    Expression<String>? allergens,
    Expression<bool>? isVerified,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameKo != null) 'name_ko': nameKo,
      if (nameEn != null) 'name_en': nameEn,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (brand != null) 'brand': brand,
      if (kcalPer100g != null) 'kcal_per100g': kcalPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (fiberPer100g != null) 'fiber_per100g': fiberPer100g,
      if (sugarPer100g != null) 'sugar_per100g': sugarPer100g,
      if (sodiumPer100g != null) 'sodium_per100g': sodiumPer100g,
      if (description != null) 'description': description,
      if (ingredients != null) 'ingredients': ingredients,
      if (allergens != null) 'allergens': allergens,
      if (isVerified != null) 'is_verified': isVerified,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FoodsCompanion copyWith(
      {Value<int>? id,
      Value<String>? nameKo,
      Value<String?>? nameEn,
      Value<String>? category,
      Value<String?>? subcategory,
      Value<String?>? brand,
      Value<double>? kcalPer100g,
      Value<double>? carbsPer100g,
      Value<double>? proteinPer100g,
      Value<double>? fatPer100g,
      Value<double>? fiberPer100g,
      Value<double?>? sugarPer100g,
      Value<double?>? sodiumPer100g,
      Value<String?>? description,
      Value<String?>? ingredients,
      Value<String?>? allergens,
      Value<bool>? isVerified,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return FoodsCompanion(
      id: id ?? this.id,
      nameKo: nameKo ?? this.nameKo,
      nameEn: nameEn ?? this.nameEn,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      brand: brand ?? this.brand,
      kcalPer100g: kcalPer100g ?? this.kcalPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      fiberPer100g: fiberPer100g ?? this.fiberPer100g,
      sugarPer100g: sugarPer100g ?? this.sugarPer100g,
      sodiumPer100g: sodiumPer100g ?? this.sodiumPer100g,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameKo.present) {
      map['name_ko'] = Variable<String>(nameKo.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (subcategory.present) {
      map['subcategory'] = Variable<String>(subcategory.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (kcalPer100g.present) {
      map['kcal_per100g'] = Variable<double>(kcalPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (fiberPer100g.present) {
      map['fiber_per100g'] = Variable<double>(fiberPer100g.value);
    }
    if (sugarPer100g.present) {
      map['sugar_per100g'] = Variable<double>(sugarPer100g.value);
    }
    if (sodiumPer100g.present) {
      map['sodium_per100g'] = Variable<double>(sodiumPer100g.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(ingredients.value);
    }
    if (allergens.present) {
      map['allergens'] = Variable<String>(allergens.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('id: $id, ')
          ..write('nameKo: $nameKo, ')
          ..write('nameEn: $nameEn, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('brand: $brand, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fiberPer100g: $fiberPer100g, ')
          ..write('sugarPer100g: $sugarPer100g, ')
          ..write('sodiumPer100g: $sodiumPer100g, ')
          ..write('description: $description, ')
          ..write('ingredients: $ingredients, ')
          ..write('allergens: $allergens, ')
          ..write('isVerified: $isVerified, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodSynonymsTable extends FoodSynonyms
    with TableInfo<$FoodSynonymsTable, FoodSynonym> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodSynonymsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES foods (id) ON DELETE CASCADE'));
  static const VerificationMeta _synonymMeta =
      const VerificationMeta('synonym');
  @override
  late final GeneratedColumn<String> synonym = GeneratedColumn<String>(
      'synonym', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, foodId, synonym, type, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_synonyms';
  @override
  VerificationContext validateIntegrity(Insertable<FoodSynonym> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('synonym')) {
      context.handle(_synonymMeta,
          synonym.isAcceptableOrUnknown(data['synonym']!, _synonymMeta));
    } else if (isInserting) {
      context.missing(_synonymMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodSynonym map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodSynonym(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      synonym: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synonym'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FoodSynonymsTable createAlias(String alias) {
    return $FoodSynonymsTable(attachedDatabase, alias);
  }
}

class FoodSynonym extends DataClass implements Insertable<FoodSynonym> {
  final int id;
  final int foodId;
  final String synonym;
  final String type;
  final DateTime createdAt;
  const FoodSynonym(
      {required this.id,
      required this.foodId,
      required this.synonym,
      required this.type,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_id'] = Variable<int>(foodId);
    map['synonym'] = Variable<String>(synonym);
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodSynonymsCompanion toCompanion(bool nullToAbsent) {
    return FoodSynonymsCompanion(
      id: Value(id),
      foodId: Value(foodId),
      synonym: Value(synonym),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  factory FoodSynonym.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodSynonym(
      id: serializer.fromJson<int>(json['id']),
      foodId: serializer.fromJson<int>(json['foodId']),
      synonym: serializer.fromJson<String>(json['synonym']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodId': serializer.toJson<int>(foodId),
      'synonym': serializer.toJson<String>(synonym),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FoodSynonym copyWith(
          {int? id,
          int? foodId,
          String? synonym,
          String? type,
          DateTime? createdAt}) =>
      FoodSynonym(
        id: id ?? this.id,
        foodId: foodId ?? this.foodId,
        synonym: synonym ?? this.synonym,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
      );
  FoodSynonym copyWithCompanion(FoodSynonymsCompanion data) {
    return FoodSynonym(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      synonym: data.synonym.present ? data.synonym.value : this.synonym,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodSynonym(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('synonym: $synonym, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, foodId, synonym, type, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodSynonym &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.synonym == this.synonym &&
          other.type == this.type &&
          other.createdAt == this.createdAt);
}

class FoodSynonymsCompanion extends UpdateCompanion<FoodSynonym> {
  final Value<int> id;
  final Value<int> foodId;
  final Value<String> synonym;
  final Value<String> type;
  final Value<DateTime> createdAt;
  const FoodSynonymsCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.synonym = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FoodSynonymsCompanion.insert({
    this.id = const Value.absent(),
    required int foodId,
    required String synonym,
    required String type,
    this.createdAt = const Value.absent(),
  })  : foodId = Value(foodId),
        synonym = Value(synonym),
        type = Value(type);
  static Insertable<FoodSynonym> custom({
    Expression<int>? id,
    Expression<int>? foodId,
    Expression<String>? synonym,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (synonym != null) 'synonym': synonym,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FoodSynonymsCompanion copyWith(
      {Value<int>? id,
      Value<int>? foodId,
      Value<String>? synonym,
      Value<String>? type,
      Value<DateTime>? createdAt}) {
    return FoodSynonymsCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      synonym: synonym ?? this.synonym,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (synonym.present) {
      map['synonym'] = Variable<String>(synonym.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodSynonymsCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('synonym: $synonym, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CommonPortionsTable extends CommonPortions
    with TableInfo<$CommonPortionsTable, CommonPortion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommonPortionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES foods (id) ON DELETE CASCADE'));
  static const VerificationMeta _portionNameMeta =
      const VerificationMeta('portionName');
  @override
  late final GeneratedColumn<String> portionName = GeneratedColumn<String>(
      'portion_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _gramAmountMeta =
      const VerificationMeta('gramAmount');
  @override
  late final GeneratedColumn<double> gramAmount = GeneratedColumn<double>(
      'gram_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, foodId, portionName, gramAmount, description, isDefault, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'common_portions';
  @override
  VerificationContext validateIntegrity(Insertable<CommonPortion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('portion_name')) {
      context.handle(
          _portionNameMeta,
          portionName.isAcceptableOrUnknown(
              data['portion_name']!, _portionNameMeta));
    } else if (isInserting) {
      context.missing(_portionNameMeta);
    }
    if (data.containsKey('gram_amount')) {
      context.handle(
          _gramAmountMeta,
          gramAmount.isAcceptableOrUnknown(
              data['gram_amount']!, _gramAmountMeta));
    } else if (isInserting) {
      context.missing(_gramAmountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommonPortion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommonPortion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      portionName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}portion_name'])!,
      gramAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gram_amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CommonPortionsTable createAlias(String alias) {
    return $CommonPortionsTable(attachedDatabase, alias);
  }
}

class CommonPortion extends DataClass implements Insertable<CommonPortion> {
  final int id;
  final int foodId;
  final String portionName;
  final double gramAmount;
  final String? description;
  final bool isDefault;
  final DateTime createdAt;
  const CommonPortion(
      {required this.id,
      required this.foodId,
      required this.portionName,
      required this.gramAmount,
      this.description,
      required this.isDefault,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_id'] = Variable<int>(foodId);
    map['portion_name'] = Variable<String>(portionName);
    map['gram_amount'] = Variable<double>(gramAmount);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CommonPortionsCompanion toCompanion(bool nullToAbsent) {
    return CommonPortionsCompanion(
      id: Value(id),
      foodId: Value(foodId),
      portionName: Value(portionName),
      gramAmount: Value(gramAmount),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
    );
  }

  factory CommonPortion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommonPortion(
      id: serializer.fromJson<int>(json['id']),
      foodId: serializer.fromJson<int>(json['foodId']),
      portionName: serializer.fromJson<String>(json['portionName']),
      gramAmount: serializer.fromJson<double>(json['gramAmount']),
      description: serializer.fromJson<String?>(json['description']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodId': serializer.toJson<int>(foodId),
      'portionName': serializer.toJson<String>(portionName),
      'gramAmount': serializer.toJson<double>(gramAmount),
      'description': serializer.toJson<String?>(description),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CommonPortion copyWith(
          {int? id,
          int? foodId,
          String? portionName,
          double? gramAmount,
          Value<String?> description = const Value.absent(),
          bool? isDefault,
          DateTime? createdAt}) =>
      CommonPortion(
        id: id ?? this.id,
        foodId: foodId ?? this.foodId,
        portionName: portionName ?? this.portionName,
        gramAmount: gramAmount ?? this.gramAmount,
        description: description.present ? description.value : this.description,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
      );
  CommonPortion copyWithCompanion(CommonPortionsCompanion data) {
    return CommonPortion(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      portionName:
          data.portionName.present ? data.portionName.value : this.portionName,
      gramAmount:
          data.gramAmount.present ? data.gramAmount.value : this.gramAmount,
      description:
          data.description.present ? data.description.value : this.description,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommonPortion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('portionName: $portionName, ')
          ..write('gramAmount: $gramAmount, ')
          ..write('description: $description, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, foodId, portionName, gramAmount, description, isDefault, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommonPortion &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.portionName == this.portionName &&
          other.gramAmount == this.gramAmount &&
          other.description == this.description &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt);
}

class CommonPortionsCompanion extends UpdateCompanion<CommonPortion> {
  final Value<int> id;
  final Value<int> foodId;
  final Value<String> portionName;
  final Value<double> gramAmount;
  final Value<String?> description;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  const CommonPortionsCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.portionName = const Value.absent(),
    this.gramAmount = const Value.absent(),
    this.description = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CommonPortionsCompanion.insert({
    this.id = const Value.absent(),
    required int foodId,
    required String portionName,
    required double gramAmount,
    this.description = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : foodId = Value(foodId),
        portionName = Value(portionName),
        gramAmount = Value(gramAmount);
  static Insertable<CommonPortion> custom({
    Expression<int>? id,
    Expression<int>? foodId,
    Expression<String>? portionName,
    Expression<double>? gramAmount,
    Expression<String>? description,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (portionName != null) 'portion_name': portionName,
      if (gramAmount != null) 'gram_amount': gramAmount,
      if (description != null) 'description': description,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CommonPortionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? foodId,
      Value<String>? portionName,
      Value<double>? gramAmount,
      Value<String?>? description,
      Value<bool>? isDefault,
      Value<DateTime>? createdAt}) {
    return CommonPortionsCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      portionName: portionName ?? this.portionName,
      gramAmount: gramAmount ?? this.gramAmount,
      description: description ?? this.description,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (portionName.present) {
      map['portion_name'] = Variable<String>(portionName.value);
    }
    if (gramAmount.present) {
      map['gram_amount'] = Variable<double>(gramAmount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommonPortionsCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('portionName: $portionName, ')
          ..write('gramAmount: $gramAmount, ')
          ..write('description: $description, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FoodEntriesTable extends FoodEntries
    with TableInfo<$FoodEntriesTable, FoodEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES foods (id)'));
  static const VerificationMeta _mealTypeMeta =
      const VerificationMeta('mealType');
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
      'meal_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _portionGramsMeta =
      const VerificationMeta('portionGrams');
  @override
  late final GeneratedColumn<double> portionGrams = GeneratedColumn<double>(
      'portion_grams', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _portionDescriptionMeta =
      const VerificationMeta('portionDescription');
  @override
  late final GeneratedColumn<String> portionDescription =
      GeneratedColumn<String>('portion_description', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
          type: DriftSqlType.string,
          requiredDuringInsert: false);
  static const VerificationMeta _totalCaloriesMeta =
      const VerificationMeta('totalCalories');
  @override
  late final GeneratedColumn<double> totalCalories = GeneratedColumn<double>(
      'total_calories', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalCarbsMeta =
      const VerificationMeta('totalCarbs');
  @override
  late final GeneratedColumn<double> totalCarbs = GeneratedColumn<double>(
      'total_carbs', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalProteinMeta =
      const VerificationMeta('totalProtein');
  @override
  late final GeneratedColumn<double> totalProtein = GeneratedColumn<double>(
      'total_protein', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalFatMeta =
      const VerificationMeta('totalFat');
  @override
  late final GeneratedColumn<double> totalFat = GeneratedColumn<double>(
      'total_fat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalFiberMeta =
      const VerificationMeta('totalFiber');
  @override
  late final GeneratedColumn<double> totalFiber = GeneratedColumn<double>(
      'total_fiber', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isFromAIMeta =
      const VerificationMeta('isFromAI');
  @override
  late final GeneratedColumn<bool> isFromAI = GeneratedColumn<bool>(
      'is_from_a_i', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_from_a_i" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _recognitionHistoryIdMeta =
      const VerificationMeta('recognitionHistoryId');
  @override
  late final GeneratedColumn<int> recognitionHistoryId = GeneratedColumn<int>(
      'recognition_history_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        foodId,
        mealType,
        timestamp,
        portionGrams,
        portionDescription,
        totalCalories,
        totalCarbs,
        totalProtein,
        totalFat,
        totalFiber,
        notes,
        imageUrl,
        isFromAI,
        recognitionHistoryId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_entries';
  @override
  VerificationContext validateIntegrity(Insertable<FoodEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(_mealTypeMeta,
          mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta));
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('portion_grams')) {
      context.handle(
          _portionGramsMeta,
          portionGrams.isAcceptableOrUnknown(
              data['portion_grams']!, _portionGramsMeta));
    } else if (isInserting) {
      context.missing(_portionGramsMeta);
    }
    if (data.containsKey('portion_description')) {
      context.handle(
          _portionDescriptionMeta,
          portionDescription.isAcceptableOrUnknown(
              data['portion_description']!, _portionDescriptionMeta));
    }
    if (data.containsKey('total_calories')) {
      context.handle(
          _totalCaloriesMeta,
          totalCalories.isAcceptableOrUnknown(
              data['total_calories']!, _totalCaloriesMeta));
    } else if (isInserting) {
      context.missing(_totalCaloriesMeta);
    }
    if (data.containsKey('total_carbs')) {
      context.handle(
          _totalCarbsMeta,
          totalCarbs.isAcceptableOrUnknown(
              data['total_carbs']!, _totalCarbsMeta));
    } else if (isInserting) {
      context.missing(_totalCarbsMeta);
    }
    if (data.containsKey('total_protein')) {
      context.handle(
          _totalProteinMeta,
          totalProtein.isAcceptableOrUnknown(
              data['total_protein']!, _totalProteinMeta));
    } else if (isInserting) {
      context.missing(_totalProteinMeta);
    }
    if (data.containsKey('total_fat')) {
      context.handle(_totalFatMeta,
          totalFat.isAcceptableOrUnknown(data['total_fat']!, _totalFatMeta));
    } else if (isInserting) {
      context.missing(_totalFatMeta);
    }
    if (data.containsKey('total_fiber')) {
      context.handle(
          _totalFiberMeta,
          totalFiber.isAcceptableOrUnknown(
              data['total_fiber']!, _totalFiberMeta));
    } else if (isInserting) {
      context.missing(_totalFiberMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('is_from_a_i')) {
      context.handle(_isFromAIMeta,
          isFromAI.isAcceptableOrUnknown(data['is_from_a_i']!, _isFromAIMeta));
    }
    if (data.containsKey('recognition_history_id')) {
      context.handle(
          _recognitionHistoryIdMeta,
          recognitionHistoryId.isAcceptableOrUnknown(
              data['recognition_history_id']!, _recognitionHistoryIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      mealType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal_type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      portionGrams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}portion_grams'])!,
      portionDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}portion_description']),
      totalCalories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_calories'])!,
      totalCarbs: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_carbs'])!,
      totalProtein: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_protein'])!,
      totalFat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fat'])!,
      totalFiber: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fiber'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      isFromAI: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_from_a_i'])!,
      recognitionHistoryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}recognition_history_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FoodEntriesTable createAlias(String alias) {
    return $FoodEntriesTable(attachedDatabase, alias);
  }
}

class FoodEntry extends DataClass implements Insertable<FoodEntry> {
  final int id;
  final String userId;
  final int foodId;
  final String mealType;
  final DateTime timestamp;
  final double portionGrams;
  final String? portionDescription;
  final double totalCalories;
  final double totalCarbs;
  final double totalProtein;
  final double totalFat;
  final double totalFiber;
  final String? notes;
  final String? imageUrl;
  final bool isFromAI;
  final int? recognitionHistoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodEntry(
      {required this.id,
      required this.userId,
      required this.foodId,
      required this.mealType,
      required this.timestamp,
      required this.portionGrams,
      this.portionDescription,
      required this.totalCalories,
      required this.totalCarbs,
      required this.totalProtein,
      required this.totalFat,
      required this.totalFiber,
      this.notes,
      this.imageUrl,
      required this.isFromAI,
      this.recognitionHistoryId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['food_id'] = Variable<int>(foodId);
    map['meal_type'] = Variable<String>(mealType);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['portion_grams'] = Variable<double>(portionGrams);
    if (!nullToAbsent || portionDescription != null) {
      map['portion_description'] = Variable<String>(portionDescription);
    }
    map['total_calories'] = Variable<double>(totalCalories);
    map['total_carbs'] = Variable<double>(totalCarbs);
    map['total_protein'] = Variable<double>(totalProtein);
    map['total_fat'] = Variable<double>(totalFat);
    map['total_fiber'] = Variable<double>(totalFiber);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_from_a_i'] = Variable<bool>(isFromAI);
    if (!nullToAbsent || recognitionHistoryId != null) {
      map['recognition_history_id'] = Variable<int>(recognitionHistoryId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId: Value(foodId),
      mealType: Value(mealType),
      timestamp: Value(timestamp),
      portionGrams: Value(portionGrams),
      portionDescription: portionDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(portionDescription),
      totalCalories: Value(totalCalories),
      totalCarbs: Value(totalCarbs),
      totalProtein: Value(totalProtein),
      totalFat: Value(totalFat),
      totalFiber: Value(totalFiber),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isFromAI: Value(isFromAI),
      recognitionHistoryId: recognitionHistoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(recognitionHistoryId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodEntry(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      foodId: serializer.fromJson<int>(json['foodId']),
      mealType: serializer.fromJson<String>(json['mealType']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      portionGrams: serializer.fromJson<double>(json['portionGrams']),
      portionDescription:
          serializer.fromJson<String?>(json['portionDescription']),
      totalCalories: serializer.fromJson<double>(json['totalCalories']),
      totalCarbs: serializer.fromJson<double>(json['totalCarbs']),
      totalProtein: serializer.fromJson<double>(json['totalProtein']),
      totalFat: serializer.fromJson<double>(json['totalFat']),
      totalFiber: serializer.fromJson<double>(json['totalFiber']),
      notes: serializer.fromJson<String?>(json['notes']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isFromAI: serializer.fromJson<bool>(json['isFromAI']),
      recognitionHistoryId:
          serializer.fromJson<int?>(json['recognitionHistoryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'foodId': serializer.toJson<int>(foodId),
      'mealType': serializer.toJson<String>(mealType),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'portionGrams': serializer.toJson<double>(portionGrams),
      'portionDescription': serializer.toJson<String?>(portionDescription),
      'totalCalories': serializer.toJson<double>(totalCalories),
      'totalCarbs': serializer.toJson<double>(totalCarbs),
      'totalProtein': serializer.toJson<double>(totalProtein),
      'totalFat': serializer.toJson<double>(totalFat),
      'totalFiber': serializer.toJson<double>(totalFiber),
      'notes': serializer.toJson<String?>(notes),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isFromAI': serializer.toJson<bool>(isFromAI),
      'recognitionHistoryId': serializer.toJson<int?>(recognitionHistoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodEntry copyWith(
          {int? id,
          String? userId,
          int? foodId,
          String? mealType,
          DateTime? timestamp,
          double? portionGrams,
          Value<String?> portionDescription = const Value.absent(),
          double? totalCalories,
          double? totalCarbs,
          double? totalProtein,
          double? totalFat,
          double? totalFiber,
          Value<String?> notes = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          bool? isFromAI,
          Value<int?> recognitionHistoryId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      FoodEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        foodId: foodId ?? this.foodId,
        mealType: mealType ?? this.mealType,
        timestamp: timestamp ?? this.timestamp,
        portionGrams: portionGrams ?? this.portionGrams,
        portionDescription: portionDescription.present
            ? portionDescription.value
            : this.portionDescription,
        totalCalories: totalCalories ?? this.totalCalories,
        totalCarbs: totalCarbs ?? this.totalCarbs,
        totalProtein: totalProtein ?? this.totalProtein,
        totalFat: totalFat ?? this.totalFat,
        totalFiber: totalFiber ?? this.totalFiber,
        notes: notes.present ? notes.value : this.notes,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        isFromAI: isFromAI ?? this.isFromAI,
        recognitionHistoryId: recognitionHistoryId.present
            ? recognitionHistoryId.value
            : this.recognitionHistoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  FoodEntry copyWithCompanion(FoodEntriesCompanion data) {
    return FoodEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      portionGrams: data.portionGrams.present
          ? data.portionGrams.value
          : this.portionGrams,
      portionDescription: data.portionDescription.present
          ? data.portionDescription.value
          : this.portionDescription,
      totalCalories: data.totalCalories.present
          ? data.totalCalories.value
          : this.totalCalories,
      totalCarbs:
          data.totalCarbs.present ? data.totalCarbs.value : this.totalCarbs,
      totalProtein: data.totalProtein.present
          ? data.totalProtein.value
          : this.totalProtein,
      totalFat: data.totalFat.present ? data.totalFat.value : this.totalFat,
      totalFiber:
          data.totalFiber.present ? data.totalFiber.value : this.totalFiber,
      notes: data.notes.present ? data.notes.value : this.notes,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isFromAI: data.isFromAI.present ? data.isFromAI.value : this.isFromAI,
      recognitionHistoryId: data.recognitionHistoryId.present
          ? data.recognitionHistoryId.value
          : this.recognitionHistoryId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('mealType: $mealType, ')
          ..write('timestamp: $timestamp, ')
          ..write('portionGrams: $portionGrams, ')
          ..write('portionDescription: $portionDescription, ')
          ..write('totalCalories: $totalCalories, ')
          ..write('totalCarbs: $totalCarbs, ')
          ..write('totalProtein: $totalProtein, ')
          ..write('totalFat: $totalFat, ')
          ..write('totalFiber: $totalFiber, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isFromAI: $isFromAI, ')
          ..write('recognitionHistoryId: $recognitionHistoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      foodId,
      mealType,
      timestamp,
      portionGrams,
      portionDescription,
      totalCalories,
      totalCarbs,
      totalProtein,
      totalFat,
      totalFiber,
      notes,
      imageUrl,
      isFromAI,
      recognitionHistoryId,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodId == this.foodId &&
          other.mealType == this.mealType &&
          other.timestamp == this.timestamp &&
          other.portionGrams == this.portionGrams &&
          other.portionDescription == this.portionDescription &&
          other.totalCalories == this.totalCalories &&
          other.totalCarbs == this.totalCarbs &&
          other.totalProtein == this.totalProtein &&
          other.totalFat == this.totalFat &&
          other.totalFiber == this.totalFiber &&
          other.notes == this.notes &&
          other.imageUrl == this.imageUrl &&
          other.isFromAI == this.isFromAI &&
          other.recognitionHistoryId == this.recognitionHistoryId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodEntriesCompanion extends UpdateCompanion<FoodEntry> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> foodId;
  final Value<String> mealType;
  final Value<DateTime> timestamp;
  final Value<double> portionGrams;
  final Value<String?> portionDescription;
  final Value<double> totalCalories;
  final Value<double> totalCarbs;
  final Value<double> totalProtein;
  final Value<double> totalFat;
  final Value<double> totalFiber;
  final Value<String?> notes;
  final Value<String?> imageUrl;
  final Value<bool> isFromAI;
  final Value<int?> recognitionHistoryId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FoodEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.mealType = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.portionGrams = const Value.absent(),
    this.portionDescription = const Value.absent(),
    this.totalCalories = const Value.absent(),
    this.totalCarbs = const Value.absent(),
    this.totalProtein = const Value.absent(),
    this.totalFat = const Value.absent(),
    this.totalFiber = const Value.absent(),
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isFromAI = const Value.absent(),
    this.recognitionHistoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FoodEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int foodId,
    required String mealType,
    required DateTime timestamp,
    required double portionGrams,
    this.portionDescription = const Value.absent(),
    required double totalCalories,
    required double totalCarbs,
    required double totalProtein,
    required double totalFat,
    required double totalFiber,
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isFromAI = const Value.absent(),
    this.recognitionHistoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        foodId = Value(foodId),
        mealType = Value(mealType),
        timestamp = Value(timestamp),
        portionGrams = Value(portionGrams),
        totalCalories = Value(totalCalories),
        totalCarbs = Value(totalCarbs),
        totalProtein = Value(totalProtein),
        totalFat = Value(totalFat),
        totalFiber = Value(totalFiber);
  static Insertable<FoodEntry> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? foodId,
    Expression<String>? mealType,
    Expression<DateTime>? timestamp,
    Expression<double>? portionGrams,
    Expression<String>? portionDescription,
    Expression<double>? totalCalories,
    Expression<double>? totalCarbs,
    Expression<double>? totalProtein,
    Expression<double>? totalFat,
    Expression<double>? totalFiber,
    Expression<String>? notes,
    Expression<String>? imageUrl,
    Expression<bool>? isFromAI,
    Expression<int>? recognitionHistoryId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (foodId != null) 'food_id': foodId,
      if (mealType != null) 'meal_type': mealType,
      if (timestamp != null) 'timestamp': timestamp,
      if (portionGrams != null) 'portion_grams': portionGrams,
      if (portionDescription != null) 'portion_description': portionDescription,
      if (totalCalories != null) 'total_calories': totalCalories,
      if (totalCarbs != null) 'total_carbs': totalCarbs,
      if (totalProtein != null) 'total_protein': totalProtein,
      if (totalFat != null) 'total_fat': totalFat,
      if (totalFiber != null) 'total_fiber': totalFiber,
      if (notes != null) 'notes': notes,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isFromAI != null) 'is_from_a_i': isFromAI,
      if (recognitionHistoryId != null)
        'recognition_history_id': recognitionHistoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FoodEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<int>? foodId,
      Value<String>? mealType,
      Value<DateTime>? timestamp,
      Value<double>? portionGrams,
      Value<String?>? portionDescription,
      Value<double>? totalCalories,
      Value<double>? totalCarbs,
      Value<double>? totalProtein,
      Value<double>? totalFat,
      Value<double>? totalFiber,
      Value<String?>? notes,
      Value<String?>? imageUrl,
      Value<bool>? isFromAI,
      Value<int?>? recognitionHistoryId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return FoodEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      mealType: mealType ?? this.mealType,
      timestamp: timestamp ?? this.timestamp,
      portionGrams: portionGrams ?? this.portionGrams,
      portionDescription: portionDescription ?? this.portionDescription,
      totalCalories: totalCalories ?? this.totalCalories,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalProtein: totalProtein ?? this.totalProtein,
      totalFat: totalFat ?? this.totalFat,
      totalFiber: totalFiber ?? this.totalFiber,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
      isFromAI: isFromAI ?? this.isFromAI,
      recognitionHistoryId: recognitionHistoryId ?? this.recognitionHistoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (portionGrams.present) {
      map['portion_grams'] = Variable<double>(portionGrams.value);
    }
    if (portionDescription.present) {
      map['portion_description'] = Variable<String>(portionDescription.value);
    }
    if (totalCalories.present) {
      map['total_calories'] = Variable<double>(totalCalories.value);
    }
    if (totalCarbs.present) {
      map['total_carbs'] = Variable<double>(totalCarbs.value);
    }
    if (totalProtein.present) {
      map['total_protein'] = Variable<double>(totalProtein.value);
    }
    if (totalFat.present) {
      map['total_fat'] = Variable<double>(totalFat.value);
    }
    if (totalFiber.present) {
      map['total_fiber'] = Variable<double>(totalFiber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isFromAI.present) {
      map['is_from_a_i'] = Variable<bool>(isFromAI.value);
    }
    if (recognitionHistoryId.present) {
      map['recognition_history_id'] = Variable<int>(recognitionHistoryId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('mealType: $mealType, ')
          ..write('timestamp: $timestamp, ')
          ..write('portionGrams: $portionGrams, ')
          ..write('portionDescription: $portionDescription, ')
          ..write('totalCalories: $totalCalories, ')
          ..write('totalCarbs: $totalCarbs, ')
          ..write('totalProtein: $totalProtein, ')
          ..write('totalFat: $totalFat, ')
          ..write('totalFiber: $totalFiber, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isFromAI: $isFromAI, ')
          ..write('recognitionHistoryId: $recognitionHistoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FavoritePortionsTable extends FavoritePortions
    with TableInfo<$FavoritePortionsTable, FavoritePortion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePortionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES foods (id) ON DELETE CASCADE'));
  static const VerificationMeta _portionGramsMeta =
      const VerificationMeta('portionGrams');
  @override
  late final GeneratedColumn<double> portionGrams = GeneratedColumn<double>(
      'portion_grams', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _usageCountMeta =
      const VerificationMeta('usageCount');
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
      'usage_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _lastUsedAtMeta =
      const VerificationMeta('lastUsedAt');
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
      'last_used_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        foodId,
        portionGrams,
        nickname,
        usageCount,
        lastUsedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_portions';
  @override
  VerificationContext validateIntegrity(Insertable<FavoritePortion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('portion_grams')) {
      context.handle(
          _portionGramsMeta,
          portionGrams.isAcceptableOrUnknown(
              data['portion_grams']!, _portionGramsMeta));
    } else if (isInserting) {
      context.missing(_portionGramsMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    if (data.containsKey('usage_count')) {
      context.handle(
          _usageCountMeta,
          usageCount.isAcceptableOrUnknown(
              data['usage_count']!, _usageCountMeta));
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
          _lastUsedAtMeta,
          lastUsedAt.isAcceptableOrUnknown(
              data['last_used_at']!, _lastUsedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoritePortion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritePortion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      portionGrams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}portion_grams'])!,
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname']),
      usageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usage_count'])!,
      lastUsedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_used_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FavoritePortionsTable createAlias(String alias) {
    return $FavoritePortionsTable(attachedDatabase, alias);
  }
}

class FavoritePortion extends DataClass implements Insertable<FavoritePortion> {
  final int id;
  final String userId;
  final int foodId;
  final double portionGrams;
  final String? nickname;
  final int usageCount;
  final DateTime lastUsedAt;
  final DateTime createdAt;
  const FavoritePortion(
      {required this.id,
      required this.userId,
      required this.foodId,
      required this.portionGrams,
      this.nickname,
      required this.usageCount,
      required this.lastUsedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['food_id'] = Variable<int>(foodId);
    map['portion_grams'] = Variable<double>(portionGrams);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['usage_count'] = Variable<int>(usageCount);
    map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritePortionsCompanion toCompanion(bool nullToAbsent) {
    return FavoritePortionsCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId: Value(foodId),
      portionGrams: Value(portionGrams),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      usageCount: Value(usageCount),
      lastUsedAt: Value(lastUsedAt),
      createdAt: Value(createdAt),
    );
  }

  factory FavoritePortion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePortion(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      foodId: serializer.fromJson<int>(json['foodId']),
      portionGrams: serializer.fromJson<double>(json['portionGrams']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      lastUsedAt: serializer.fromJson<DateTime>(json['lastUsedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'foodId': serializer.toJson<int>(foodId),
      'portionGrams': serializer.toJson<double>(portionGrams),
      'nickname': serializer.toJson<String?>(nickname),
      'usageCount': serializer.toJson<int>(usageCount),
      'lastUsedAt': serializer.toJson<DateTime>(lastUsedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoritePortion copyWith(
          {int? id,
          String? userId,
          int? foodId,
          double? portionGrams,
          Value<String?> nickname = const Value.absent(),
          int? usageCount,
          DateTime? lastUsedAt,
          DateTime? createdAt}) =>
      FavoritePortion(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        foodId: foodId ?? this.foodId,
        portionGrams: portionGrams ?? this.portionGrams,
        nickname: nickname.present ? nickname.value : this.nickname,
        usageCount: usageCount ?? this.usageCount,
        lastUsedAt: lastUsedAt ?? this.lastUsedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  FavoritePortion copyWithCompanion(FavoritePortionsCompanion data) {
    return FavoritePortion(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      portionGrams: data.portionGrams.present
          ? data.portionGrams.value
          : this.portionGrams,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      usageCount:
          data.usageCount.present ? data.usageCount.value : this.usageCount,
      lastUsedAt:
          data.lastUsedAt.present ? data.lastUsedAt.value : this.lastUsedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePortion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('portionGrams: $portionGrams, ')
          ..write('nickname: $nickname, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, foodId, portionGrams, nickname,
      usageCount, lastUsedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePortion &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodId == this.foodId &&
          other.portionGrams == this.portionGrams &&
          other.nickname == this.nickname &&
          other.usageCount == this.usageCount &&
          other.lastUsedAt == this.lastUsedAt &&
          other.createdAt == this.createdAt);
}

class FavoritePortionsCompanion extends UpdateCompanion<FavoritePortion> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> foodId;
  final Value<double> portionGrams;
  final Value<String?> nickname;
  final Value<int> usageCount;
  final Value<DateTime> lastUsedAt;
  final Value<DateTime> createdAt;
  const FavoritePortionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.portionGrams = const Value.absent(),
    this.nickname = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritePortionsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int foodId,
    required double portionGrams,
    this.nickname = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        foodId = Value(foodId),
        portionGrams = Value(portionGrams);
  static Insertable<FavoritePortion> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? foodId,
    Expression<double>? portionGrams,
    Expression<String>? nickname,
    Expression<int>? usageCount,
    Expression<DateTime>? lastUsedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (foodId != null) 'food_id': foodId,
      if (portionGrams != null) 'portion_grams': portionGrams,
      if (nickname != null) 'nickname': nickname,
      if (usageCount != null) 'usage_count': usageCount,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritePortionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<int>? foodId,
      Value<double>? portionGrams,
      Value<String?>? nickname,
      Value<int>? usageCount,
      Value<DateTime>? lastUsedAt,
      Value<DateTime>? createdAt}) {
    return FavoritePortionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      portionGrams: portionGrams ?? this.portionGrams,
      nickname: nickname ?? this.nickname,
      usageCount: usageCount ?? this.usageCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (portionGrams.present) {
      map['portion_grams'] = Variable<double>(portionGrams.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePortionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('portionGrams: $portionGrams, ')
          ..write('nickname: $nickname, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailyNutritionSummariesTable extends DailyNutritionSummaries
    with TableInfo<$DailyNutritionSummariesTable, DailyNutritionSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyNutritionSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _calorieGoalMeta =
      const VerificationMeta('calorieGoal');
  @override
  late final GeneratedColumn<double> calorieGoal = GeneratedColumn<double>(
      'calorie_goal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbsGoalMeta =
      const VerificationMeta('carbsGoal');
  @override
  late final GeneratedColumn<double> carbsGoal = GeneratedColumn<double>(
      'carbs_goal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinGoalMeta =
      const VerificationMeta('proteinGoal');
  @override
  late final GeneratedColumn<double> proteinGoal = GeneratedColumn<double>(
      'protein_goal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatGoalMeta =
      const VerificationMeta('fatGoal');
  @override
  late final GeneratedColumn<double> fatGoal = GeneratedColumn<double>(
      'fat_goal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalCaloriesMeta =
      const VerificationMeta('totalCalories');
  @override
  late final GeneratedColumn<double> totalCalories = GeneratedColumn<double>(
      'total_calories', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalCarbsMeta =
      const VerificationMeta('totalCarbs');
  @override
  late final GeneratedColumn<double> totalCarbs = GeneratedColumn<double>(
      'total_carbs', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalProteinMeta =
      const VerificationMeta('totalProtein');
  @override
  late final GeneratedColumn<double> totalProtein = GeneratedColumn<double>(
      'total_protein', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalFatMeta =
      const VerificationMeta('totalFat');
  @override
  late final GeneratedColumn<double> totalFat = GeneratedColumn<double>(
      'total_fat', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalFiberMeta =
      const VerificationMeta('totalFiber');
  @override
  late final GeneratedColumn<double> totalFiber = GeneratedColumn<double>(
      'total_fiber', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _breakfastCountMeta =
      const VerificationMeta('breakfastCount');
  @override
  late final GeneratedColumn<int> breakfastCount = GeneratedColumn<int>(
      'breakfast_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lunchCountMeta =
      const VerificationMeta('lunchCount');
  @override
  late final GeneratedColumn<int> lunchCount = GeneratedColumn<int>(
      'lunch_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dinnerCountMeta =
      const VerificationMeta('dinnerCount');
  @override
  late final GeneratedColumn<int> dinnerCount = GeneratedColumn<int>(
      'dinner_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _snackCountMeta =
      const VerificationMeta('snackCount');
  @override
  late final GeneratedColumn<int> snackCount = GeneratedColumn<int>(
      'snack_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        date,
        calorieGoal,
        carbsGoal,
        proteinGoal,
        fatGoal,
        totalCalories,
        totalCarbs,
        totalProtein,
        totalFat,
        totalFiber,
        breakfastCount,
        lunchCount,
        dinnerCount,
        snackCount,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_nutrition_summaries';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyNutritionSummary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('calorie_goal')) {
      context.handle(
          _calorieGoalMeta,
          calorieGoal.isAcceptableOrUnknown(
              data['calorie_goal']!, _calorieGoalMeta));
    } else if (isInserting) {
      context.missing(_calorieGoalMeta);
    }
    if (data.containsKey('carbs_goal')) {
      context.handle(_carbsGoalMeta,
          carbsGoal.isAcceptableOrUnknown(data['carbs_goal']!, _carbsGoalMeta));
    } else if (isInserting) {
      context.missing(_carbsGoalMeta);
    }
    if (data.containsKey('protein_goal')) {
      context.handle(
          _proteinGoalMeta,
          proteinGoal.isAcceptableOrUnknown(
              data['protein_goal']!, _proteinGoalMeta));
    } else if (isInserting) {
      context.missing(_proteinGoalMeta);
    }
    if (data.containsKey('fat_goal')) {
      context.handle(_fatGoalMeta,
          fatGoal.isAcceptableOrUnknown(data['fat_goal']!, _fatGoalMeta));
    } else if (isInserting) {
      context.missing(_fatGoalMeta);
    }
    if (data.containsKey('total_calories')) {
      context.handle(
          _totalCaloriesMeta,
          totalCalories.isAcceptableOrUnknown(
              data['total_calories']!, _totalCaloriesMeta));
    }
    if (data.containsKey('total_carbs')) {
      context.handle(
          _totalCarbsMeta,
          totalCarbs.isAcceptableOrUnknown(
              data['total_carbs']!, _totalCarbsMeta));
    }
    if (data.containsKey('total_protein')) {
      context.handle(
          _totalProteinMeta,
          totalProtein.isAcceptableOrUnknown(
              data['total_protein']!, _totalProteinMeta));
    }
    if (data.containsKey('total_fat')) {
      context.handle(_totalFatMeta,
          totalFat.isAcceptableOrUnknown(data['total_fat']!, _totalFatMeta));
    }
    if (data.containsKey('total_fiber')) {
      context.handle(
          _totalFiberMeta,
          totalFiber.isAcceptableOrUnknown(
              data['total_fiber']!, _totalFiberMeta));
    }
    if (data.containsKey('breakfast_count')) {
      context.handle(
          _breakfastCountMeta,
          breakfastCount.isAcceptableOrUnknown(
              data['breakfast_count']!, _breakfastCountMeta));
    }
    if (data.containsKey('lunch_count')) {
      context.handle(
          _lunchCountMeta,
          lunchCount.isAcceptableOrUnknown(
              data['lunch_count']!, _lunchCountMeta));
    }
    if (data.containsKey('dinner_count')) {
      context.handle(
          _dinnerCountMeta,
          dinnerCount.isAcceptableOrUnknown(
              data['dinner_count']!, _dinnerCountMeta));
    }
    if (data.containsKey('snack_count')) {
      context.handle(
          _snackCountMeta,
          snackCount.isAcceptableOrUnknown(
              data['snack_count']!, _snackCountMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyNutritionSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyNutritionSummary(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      calorieGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calorie_goal'])!,
      carbsGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_goal'])!,
      proteinGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_goal'])!,
      fatGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_goal'])!,
      totalCalories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_calories'])!,
      totalCarbs: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_carbs'])!,
      totalProtein: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_protein'])!,
      totalFat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fat'])!,
      totalFiber: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_fiber'])!,
      breakfastCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}breakfast_count'])!,
      lunchCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lunch_count'])!,
      dinnerCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dinner_count'])!,
      snackCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snack_count'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyNutritionSummariesTable createAlias(String alias) {
    return $DailyNutritionSummariesTable(attachedDatabase, alias);
  }
}

class DailyNutritionSummary extends DataClass
    implements Insertable<DailyNutritionSummary> {
  final int id;
  final String userId;
  final DateTime date;
  final double calorieGoal;
  final double carbsGoal;
  final double proteinGoal;
  final double fatGoal;
  final double totalCalories;
  final double totalCarbs;
  final double totalProtein;
  final double totalFat;
  final double totalFiber;
  final int breakfastCount;
  final int lunchCount;
  final int dinnerCount;
  final int snackCount;
  final DateTime updatedAt;
  const DailyNutritionSummary(
      {required this.id,
      required this.userId,
      required this.date,
      required this.calorieGoal,
      required this.carbsGoal,
      required this.proteinGoal,
      required this.fatGoal,
      required this.totalCalories,
      required this.totalCarbs,
      required this.totalProtein,
      required this.totalFat,
      required this.totalFiber,
      required this.breakfastCount,
      required this.lunchCount,
      required this.dinnerCount,
      required this.snackCount,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['calorie_goal'] = Variable<double>(calorieGoal);
    map['carbs_goal'] = Variable<double>(carbsGoal);
    map['protein_goal'] = Variable<double>(proteinGoal);
    map['fat_goal'] = Variable<double>(fatGoal);
    map['total_calories'] = Variable<double>(totalCalories);
    map['total_carbs'] = Variable<double>(totalCarbs);
    map['total_protein'] = Variable<double>(totalProtein);
    map['total_fat'] = Variable<double>(totalFat);
    map['total_fiber'] = Variable<double>(totalFiber);
    map['breakfast_count'] = Variable<int>(breakfastCount);
    map['lunch_count'] = Variable<int>(lunchCount);
    map['dinner_count'] = Variable<int>(dinnerCount);
    map['snack_count'] = Variable<int>(snackCount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyNutritionSummariesCompanion toCompanion(bool nullToAbsent) {
    return DailyNutritionSummariesCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      calorieGoal: Value(calorieGoal),
      carbsGoal: Value(carbsGoal),
      proteinGoal: Value(proteinGoal),
      fatGoal: Value(fatGoal),
      totalCalories: Value(totalCalories),
      totalCarbs: Value(totalCarbs),
      totalProtein: Value(totalProtein),
      totalFat: Value(totalFat),
      totalFiber: Value(totalFiber),
      breakfastCount: Value(breakfastCount),
      lunchCount: Value(lunchCount),
      dinnerCount: Value(dinnerCount),
      snackCount: Value(snackCount),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyNutritionSummary.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyNutritionSummary(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      calorieGoal: serializer.fromJson<double>(json['calorieGoal']),
      carbsGoal: serializer.fromJson<double>(json['carbsGoal']),
      proteinGoal: serializer.fromJson<double>(json['proteinGoal']),
      fatGoal: serializer.fromJson<double>(json['fatGoal']),
      totalCalories: serializer.fromJson<double>(json['totalCalories']),
      totalCarbs: serializer.fromJson<double>(json['totalCarbs']),
      totalProtein: serializer.fromJson<double>(json['totalProtein']),
      totalFat: serializer.fromJson<double>(json['totalFat']),
      totalFiber: serializer.fromJson<double>(json['totalFiber']),
      breakfastCount: serializer.fromJson<int>(json['breakfastCount']),
      lunchCount: serializer.fromJson<int>(json['lunchCount']),
      dinnerCount: serializer.fromJson<int>(json['dinnerCount']),
      snackCount: serializer.fromJson<int>(json['snackCount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'calorieGoal': serializer.toJson<double>(calorieGoal),
      'carbsGoal': serializer.toJson<double>(carbsGoal),
      'proteinGoal': serializer.toJson<double>(proteinGoal),
      'fatGoal': serializer.toJson<double>(fatGoal),
      'totalCalories': serializer.toJson<double>(totalCalories),
      'totalCarbs': serializer.toJson<double>(totalCarbs),
      'totalProtein': serializer.toJson<double>(totalProtein),
      'totalFat': serializer.toJson<double>(totalFat),
      'totalFiber': serializer.toJson<double>(totalFiber),
      'breakfastCount': serializer.toJson<int>(breakfastCount),
      'lunchCount': serializer.toJson<int>(lunchCount),
      'dinnerCount': serializer.toJson<int>(dinnerCount),
      'snackCount': serializer.toJson<int>(snackCount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyNutritionSummary copyWith(
          {int? id,
          String? userId,
          DateTime? date,
          double? calorieGoal,
          double? carbsGoal,
          double? proteinGoal,
          double? fatGoal,
          double? totalCalories,
          double? totalCarbs,
          double? totalProtein,
          double? totalFat,
          double? totalFiber,
          int? breakfastCount,
          int? lunchCount,
          int? dinnerCount,
          int? snackCount,
          DateTime? updatedAt}) =>
      DailyNutritionSummary(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        calorieGoal: calorieGoal ?? this.calorieGoal,
        carbsGoal: carbsGoal ?? this.carbsGoal,
        proteinGoal: proteinGoal ?? this.proteinGoal,
        fatGoal: fatGoal ?? this.fatGoal,
        totalCalories: totalCalories ?? this.totalCalories,
        totalCarbs: totalCarbs ?? this.totalCarbs,
        totalProtein: totalProtein ?? this.totalProtein,
        totalFat: totalFat ?? this.totalFat,
        totalFiber: totalFiber ?? this.totalFiber,
        breakfastCount: breakfastCount ?? this.breakfastCount,
        lunchCount: lunchCount ?? this.lunchCount,
        dinnerCount: dinnerCount ?? this.dinnerCount,
        snackCount: snackCount ?? this.snackCount,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyNutritionSummary copyWithCompanion(
      DailyNutritionSummariesCompanion data) {
    return DailyNutritionSummary(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      calorieGoal:
          data.calorieGoal.present ? data.calorieGoal.value : this.calorieGoal,
      carbsGoal: data.carbsGoal.present ? data.carbsGoal.value : this.carbsGoal,
      proteinGoal:
          data.proteinGoal.present ? data.proteinGoal.value : this.proteinGoal,
      fatGoal: data.fatGoal.present ? data.fatGoal.value : this.fatGoal,
      totalCalories: data.totalCalories.present
          ? data.totalCalories.value
          : this.totalCalories,
      totalCarbs:
          data.totalCarbs.present ? data.totalCarbs.value : this.totalCarbs,
      totalProtein: data.totalProtein.present
          ? data.totalProtein.value
          : this.totalProtein,
      totalFat: data.totalFat.present ? data.totalFat.value : this.totalFat,
      totalFiber:
          data.totalFiber.present ? data.totalFiber.value : this.totalFiber,
      breakfastCount: data.breakfastCount.present
          ? data.breakfastCount.value
          : this.breakfastCount,
      lunchCount:
          data.lunchCount.present ? data.lunchCount.value : this.lunchCount,
      dinnerCount:
          data.dinnerCount.present ? data.dinnerCount.value : this.dinnerCount,
      snackCount:
          data.snackCount.present ? data.snackCount.value : this.snackCount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyNutritionSummary(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('calorieGoal: $calorieGoal, ')
          ..write('carbsGoal: $carbsGoal, ')
          ..write('proteinGoal: $proteinGoal, ')
          ..write('fatGoal: $fatGoal, ')
          ..write('totalCalories: $totalCalories, ')
          ..write('totalCarbs: $totalCarbs, ')
          ..write('totalProtein: $totalProtein, ')
          ..write('totalFat: $totalFat, ')
          ..write('totalFiber: $totalFiber, ')
          ..write('breakfastCount: $breakfastCount, ')
          ..write('lunchCount: $lunchCount, ')
          ..write('dinnerCount: $dinnerCount, ')
          ..write('snackCount: $snackCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      date,
      calorieGoal,
      carbsGoal,
      proteinGoal,
      fatGoal,
      totalCalories,
      totalCarbs,
      totalProtein,
      totalFat,
      totalFiber,
      breakfastCount,
      lunchCount,
      dinnerCount,
      snackCount,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyNutritionSummary &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.calorieGoal == this.calorieGoal &&
          other.carbsGoal == this.carbsGoal &&
          other.proteinGoal == this.proteinGoal &&
          other.fatGoal == this.fatGoal &&
          other.totalCalories == this.totalCalories &&
          other.totalCarbs == this.totalCarbs &&
          other.totalProtein == this.totalProtein &&
          other.totalFat == this.totalFat &&
          other.totalFiber == this.totalFiber &&
          other.breakfastCount == this.breakfastCount &&
          other.lunchCount == this.lunchCount &&
          other.dinnerCount == this.dinnerCount &&
          other.snackCount == this.snackCount &&
          other.updatedAt == this.updatedAt);
}

class DailyNutritionSummariesCompanion
    extends UpdateCompanion<DailyNutritionSummary> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<double> calorieGoal;
  final Value<double> carbsGoal;
  final Value<double> proteinGoal;
  final Value<double> fatGoal;
  final Value<double> totalCalories;
  final Value<double> totalCarbs;
  final Value<double> totalProtein;
  final Value<double> totalFat;
  final Value<double> totalFiber;
  final Value<int> breakfastCount;
  final Value<int> lunchCount;
  final Value<int> dinnerCount;
  final Value<int> snackCount;
  final Value<DateTime> updatedAt;
  const DailyNutritionSummariesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.calorieGoal = const Value.absent(),
    this.carbsGoal = const Value.absent(),
    this.proteinGoal = const Value.absent(),
    this.fatGoal = const Value.absent(),
    this.totalCalories = const Value.absent(),
    this.totalCarbs = const Value.absent(),
    this.totalProtein = const Value.absent(),
    this.totalFat = const Value.absent(),
    this.totalFiber = const Value.absent(),
    this.breakfastCount = const Value.absent(),
    this.lunchCount = const Value.absent(),
    this.dinnerCount = const Value.absent(),
    this.snackCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyNutritionSummariesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime date,
    required double calorieGoal,
    required double carbsGoal,
    required double proteinGoal,
    required double fatGoal,
    this.totalCalories = const Value.absent(),
    this.totalCarbs = const Value.absent(),
    this.totalProtein = const Value.absent(),
    this.totalFat = const Value.absent(),
    this.totalFiber = const Value.absent(),
    this.breakfastCount = const Value.absent(),
    this.lunchCount = const Value.absent(),
    this.dinnerCount = const Value.absent(),
    this.snackCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        date = Value(date),
        calorieGoal = Value(calorieGoal),
        carbsGoal = Value(carbsGoal),
        proteinGoal = Value(proteinGoal),
        fatGoal = Value(fatGoal);
  static Insertable<DailyNutritionSummary> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<double>? calorieGoal,
    Expression<double>? carbsGoal,
    Expression<double>? proteinGoal,
    Expression<double>? fatGoal,
    Expression<double>? totalCalories,
    Expression<double>? totalCarbs,
    Expression<double>? totalProtein,
    Expression<double>? totalFat,
    Expression<double>? totalFiber,
    Expression<int>? breakfastCount,
    Expression<int>? lunchCount,
    Expression<int>? dinnerCount,
    Expression<int>? snackCount,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (calorieGoal != null) 'calorie_goal': calorieGoal,
      if (carbsGoal != null) 'carbs_goal': carbsGoal,
      if (proteinGoal != null) 'protein_goal': proteinGoal,
      if (fatGoal != null) 'fat_goal': fatGoal,
      if (totalCalories != null) 'total_calories': totalCalories,
      if (totalCarbs != null) 'total_carbs': totalCarbs,
      if (totalProtein != null) 'total_protein': totalProtein,
      if (totalFat != null) 'total_fat': totalFat,
      if (totalFiber != null) 'total_fiber': totalFiber,
      if (breakfastCount != null) 'breakfast_count': breakfastCount,
      if (lunchCount != null) 'lunch_count': lunchCount,
      if (dinnerCount != null) 'dinner_count': dinnerCount,
      if (snackCount != null) 'snack_count': snackCount,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyNutritionSummariesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<DateTime>? date,
      Value<double>? calorieGoal,
      Value<double>? carbsGoal,
      Value<double>? proteinGoal,
      Value<double>? fatGoal,
      Value<double>? totalCalories,
      Value<double>? totalCarbs,
      Value<double>? totalProtein,
      Value<double>? totalFat,
      Value<double>? totalFiber,
      Value<int>? breakfastCount,
      Value<int>? lunchCount,
      Value<int>? dinnerCount,
      Value<int>? snackCount,
      Value<DateTime>? updatedAt}) {
    return DailyNutritionSummariesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      carbsGoal: carbsGoal ?? this.carbsGoal,
      proteinGoal: proteinGoal ?? this.proteinGoal,
      fatGoal: fatGoal ?? this.fatGoal,
      totalCalories: totalCalories ?? this.totalCalories,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalProtein: totalProtein ?? this.totalProtein,
      totalFat: totalFat ?? this.totalFat,
      totalFiber: totalFiber ?? this.totalFiber,
      breakfastCount: breakfastCount ?? this.breakfastCount,
      lunchCount: lunchCount ?? this.lunchCount,
      dinnerCount: dinnerCount ?? this.dinnerCount,
      snackCount: snackCount ?? this.snackCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (calorieGoal.present) {
      map['calorie_goal'] = Variable<double>(calorieGoal.value);
    }
    if (carbsGoal.present) {
      map['carbs_goal'] = Variable<double>(carbsGoal.value);
    }
    if (proteinGoal.present) {
      map['protein_goal'] = Variable<double>(proteinGoal.value);
    }
    if (fatGoal.present) {
      map['fat_goal'] = Variable<double>(fatGoal.value);
    }
    if (totalCalories.present) {
      map['total_calories'] = Variable<double>(totalCalories.value);
    }
    if (totalCarbs.present) {
      map['total_carbs'] = Variable<double>(totalCarbs.value);
    }
    if (totalProtein.present) {
      map['total_protein'] = Variable<double>(totalProtein.value);
    }
    if (totalFat.present) {
      map['total_fat'] = Variable<double>(totalFat.value);
    }
    if (totalFiber.present) {
      map['total_fiber'] = Variable<double>(totalFiber.value);
    }
    if (breakfastCount.present) {
      map['breakfast_count'] = Variable<int>(breakfastCount.value);
    }
    if (lunchCount.present) {
      map['lunch_count'] = Variable<int>(lunchCount.value);
    }
    if (dinnerCount.present) {
      map['dinner_count'] = Variable<int>(dinnerCount.value);
    }
    if (snackCount.present) {
      map['snack_count'] = Variable<int>(snackCount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyNutritionSummariesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('calorieGoal: $calorieGoal, ')
          ..write('carbsGoal: $carbsGoal, ')
          ..write('proteinGoal: $proteinGoal, ')
          ..write('fatGoal: $fatGoal, ')
          ..write('totalCalories: $totalCalories, ')
          ..write('totalCarbs: $totalCarbs, ')
          ..write('totalProtein: $totalProtein, ')
          ..write('totalFat: $totalFat, ')
          ..write('totalFiber: $totalFiber, ')
          ..write('breakfastCount: $breakfastCount, ')
          ..write('lunchCount: $lunchCount, ')
          ..write('dinnerCount: $dinnerCount, ')
          ..write('snackCount: $snackCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RecognitionHistoriesTable extends RecognitionHistories
    with TableInfo<$RecognitionHistoriesTable, RecognitionHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecognitionHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageHashMeta =
      const VerificationMeta('imageHash');
  @override
  late final GeneratedColumn<String> imageHash = GeneratedColumn<String>(
      'image_hash', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _recognizedAtMeta =
      const VerificationMeta('recognizedAt');
  @override
  late final GeneratedColumn<DateTime> recognizedAt = GeneratedColumn<DateTime>(
      'recognized_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _modelVersionMeta =
      const VerificationMeta('modelVersion');
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
      'model_version', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _processingTimeMsMeta =
      const VerificationMeta('processingTimeMs');
  @override
  late final GeneratedColumn<double> processingTimeMs = GeneratedColumn<double>(
      'processing_time_ms', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userConfirmedMeta =
      const VerificationMeta('userConfirmed');
  @override
  late final GeneratedColumn<bool> userConfirmed = GeneratedColumn<bool>(
      'user_confirmed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("user_confirmed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _userCorrectedMeta =
      const VerificationMeta('userCorrected');
  @override
  late final GeneratedColumn<bool> userCorrected = GeneratedColumn<bool>(
      'user_corrected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("user_corrected" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        imagePath,
        imageHash,
        recognizedAt,
        modelVersion,
        processingTimeMs,
        status,
        errorMessage,
        userConfirmed,
        userCorrected,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recognition_histories';
  @override
  VerificationContext validateIntegrity(Insertable<RecognitionHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('image_hash')) {
      context.handle(_imageHashMeta,
          imageHash.isAcceptableOrUnknown(data['image_hash']!, _imageHashMeta));
    }
    if (data.containsKey('recognized_at')) {
      context.handle(
          _recognizedAtMeta,
          recognizedAt.isAcceptableOrUnknown(
              data['recognized_at']!, _recognizedAtMeta));
    }
    if (data.containsKey('model_version')) {
      context.handle(
          _modelVersionMeta,
          modelVersion.isAcceptableOrUnknown(
              data['model_version']!, _modelVersionMeta));
    } else if (isInserting) {
      context.missing(_modelVersionMeta);
    }
    if (data.containsKey('processing_time_ms')) {
      context.handle(
          _processingTimeMsMeta,
          processingTimeMs.isAcceptableOrUnknown(
              data['processing_time_ms']!, _processingTimeMsMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('user_confirmed')) {
      context.handle(
          _userConfirmedMeta,
          userConfirmed.isAcceptableOrUnknown(
              data['user_confirmed']!, _userConfirmedMeta));
    }
    if (data.containsKey('user_corrected')) {
      context.handle(
          _userCorrectedMeta,
          userCorrected.isAcceptableOrUnknown(
              data['user_corrected']!, _userCorrectedMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecognitionHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecognitionHistory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      imageHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_hash']),
      recognizedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}recognized_at'])!,
      modelVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model_version'])!,
      processingTimeMs: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}processing_time_ms']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      userConfirmed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}user_confirmed'])!,
      userCorrected: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}user_corrected'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RecognitionHistoriesTable createAlias(String alias) {
    return $RecognitionHistoriesTable(attachedDatabase, alias);
  }
}

class RecognitionHistory extends DataClass
    implements Insertable<RecognitionHistory> {
  final int id;
  final String userId;
  final String imagePath;
  final String? imageHash;
  final DateTime recognizedAt;
  final String modelVersion;
  final double? processingTimeMs;
  final String status;
  final String? errorMessage;
  final bool userConfirmed;
  final bool userCorrected;
  final DateTime updatedAt;
  const RecognitionHistory(
      {required this.id,
      required this.userId,
      required this.imagePath,
      this.imageHash,
      required this.recognizedAt,
      required this.modelVersion,
      this.processingTimeMs,
      required this.status,
      this.errorMessage,
      required this.userConfirmed,
      required this.userCorrected,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['image_path'] = Variable<String>(imagePath);
    if (!nullToAbsent || imageHash != null) {
      map['image_hash'] = Variable<String>(imageHash);
    }
    map['recognized_at'] = Variable<DateTime>(recognizedAt);
    map['model_version'] = Variable<String>(modelVersion);
    if (!nullToAbsent || processingTimeMs != null) {
      map['processing_time_ms'] = Variable<double>(processingTimeMs);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['user_confirmed'] = Variable<bool>(userConfirmed);
    map['user_corrected'] = Variable<bool>(userCorrected);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecognitionHistoriesCompanion toCompanion(bool nullToAbsent) {
    return RecognitionHistoriesCompanion(
      id: Value(id),
      userId: Value(userId),
      imagePath: Value(imagePath),
      imageHash: imageHash == null && nullToAbsent
          ? const Value.absent()
          : Value(imageHash),
      recognizedAt: Value(recognizedAt),
      modelVersion: Value(modelVersion),
      processingTimeMs: processingTimeMs == null && nullToAbsent
          ? const Value.absent()
          : Value(processingTimeMs),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      userConfirmed: Value(userConfirmed),
      userCorrected: Value(userCorrected),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecognitionHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecognitionHistory(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      imageHash: serializer.fromJson<String?>(json['imageHash']),
      recognizedAt: serializer.fromJson<DateTime>(json['recognizedAt']),
      modelVersion: serializer.fromJson<String>(json['modelVersion']),
      processingTimeMs: serializer.fromJson<double?>(json['processingTimeMs']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      userConfirmed: serializer.fromJson<bool>(json['userConfirmed']),
      userCorrected: serializer.fromJson<bool>(json['userCorrected']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'imagePath': serializer.toJson<String>(imagePath),
      'imageHash': serializer.toJson<String?>(imageHash),
      'recognizedAt': serializer.toJson<DateTime>(recognizedAt),
      'modelVersion': serializer.toJson<String>(modelVersion),
      'processingTimeMs': serializer.toJson<double?>(processingTimeMs),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'userConfirmed': serializer.toJson<bool>(userConfirmed),
      'userCorrected': serializer.toJson<bool>(userCorrected),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecognitionHistory copyWith(
          {int? id,
          String? userId,
          String? imagePath,
          Value<String?> imageHash = const Value.absent(),
          DateTime? recognizedAt,
          String? modelVersion,
          Value<double?> processingTimeMs = const Value.absent(),
          String? status,
          Value<String?> errorMessage = const Value.absent(),
          bool? userConfirmed,
          bool? userCorrected,
          DateTime? updatedAt}) =>
      RecognitionHistory(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        imagePath: imagePath ?? this.imagePath,
        imageHash: imageHash.present ? imageHash.value : this.imageHash,
        recognizedAt: recognizedAt ?? this.recognizedAt,
        modelVersion: modelVersion ?? this.modelVersion,
        processingTimeMs: processingTimeMs.present
            ? processingTimeMs.value
            : this.processingTimeMs,
        status: status ?? this.status,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        userConfirmed: userConfirmed ?? this.userConfirmed,
        userCorrected: userCorrected ?? this.userCorrected,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RecognitionHistory copyWithCompanion(RecognitionHistoriesCompanion data) {
    return RecognitionHistory(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      imageHash: data.imageHash.present ? data.imageHash.value : this.imageHash,
      recognizedAt: data.recognizedAt.present
          ? data.recognizedAt.value
          : this.recognizedAt,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
      processingTimeMs: data.processingTimeMs.present
          ? data.processingTimeMs.value
          : this.processingTimeMs,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      userConfirmed: data.userConfirmed.present
          ? data.userConfirmed.value
          : this.userConfirmed,
      userCorrected: data.userCorrected.present
          ? data.userCorrected.value
          : this.userCorrected,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecognitionHistory(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageHash: $imageHash, ')
          ..write('recognizedAt: $recognizedAt, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('processingTimeMs: $processingTimeMs, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('userConfirmed: $userConfirmed, ')
          ..write('userCorrected: $userCorrected, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      imagePath,
      imageHash,
      recognizedAt,
      modelVersion,
      processingTimeMs,
      status,
      errorMessage,
      userConfirmed,
      userCorrected,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecognitionHistory &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.imagePath == this.imagePath &&
          other.imageHash == this.imageHash &&
          other.recognizedAt == this.recognizedAt &&
          other.modelVersion == this.modelVersion &&
          other.processingTimeMs == this.processingTimeMs &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.userConfirmed == this.userConfirmed &&
          other.userCorrected == this.userCorrected &&
          other.updatedAt == this.updatedAt);
}

class RecognitionHistoriesCompanion
    extends UpdateCompanion<RecognitionHistory> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> imagePath;
  final Value<String?> imageHash;
  final Value<DateTime> recognizedAt;
  final Value<String> modelVersion;
  final Value<double?> processingTimeMs;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<bool> userConfirmed;
  final Value<bool> userCorrected;
  final Value<DateTime> updatedAt;
  const RecognitionHistoriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.imageHash = const Value.absent(),
    this.recognizedAt = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.processingTimeMs = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.userConfirmed = const Value.absent(),
    this.userCorrected = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RecognitionHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String imagePath,
    this.imageHash = const Value.absent(),
    this.recognizedAt = const Value.absent(),
    required String modelVersion,
    this.processingTimeMs = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.userConfirmed = const Value.absent(),
    this.userCorrected = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        imagePath = Value(imagePath),
        modelVersion = Value(modelVersion);
  static Insertable<RecognitionHistory> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? imagePath,
    Expression<String>? imageHash,
    Expression<DateTime>? recognizedAt,
    Expression<String>? modelVersion,
    Expression<double>? processingTimeMs,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<bool>? userConfirmed,
    Expression<bool>? userCorrected,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (imagePath != null) 'image_path': imagePath,
      if (imageHash != null) 'image_hash': imageHash,
      if (recognizedAt != null) 'recognized_at': recognizedAt,
      if (modelVersion != null) 'model_version': modelVersion,
      if (processingTimeMs != null) 'processing_time_ms': processingTimeMs,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (userConfirmed != null) 'user_confirmed': userConfirmed,
      if (userCorrected != null) 'user_corrected': userCorrected,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RecognitionHistoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? imagePath,
      Value<String?>? imageHash,
      Value<DateTime>? recognizedAt,
      Value<String>? modelVersion,
      Value<double?>? processingTimeMs,
      Value<String>? status,
      Value<String?>? errorMessage,
      Value<bool>? userConfirmed,
      Value<bool>? userCorrected,
      Value<DateTime>? updatedAt}) {
    return RecognitionHistoriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      imageHash: imageHash ?? this.imageHash,
      recognizedAt: recognizedAt ?? this.recognizedAt,
      modelVersion: modelVersion ?? this.modelVersion,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userConfirmed: userConfirmed ?? this.userConfirmed,
      userCorrected: userCorrected ?? this.userCorrected,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (imageHash.present) {
      map['image_hash'] = Variable<String>(imageHash.value);
    }
    if (recognizedAt.present) {
      map['recognized_at'] = Variable<DateTime>(recognizedAt.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (processingTimeMs.present) {
      map['processing_time_ms'] = Variable<double>(processingTimeMs.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (userConfirmed.present) {
      map['user_confirmed'] = Variable<bool>(userConfirmed.value);
    }
    if (userCorrected.present) {
      map['user_corrected'] = Variable<bool>(userCorrected.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecognitionHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageHash: $imageHash, ')
          ..write('recognizedAt: $recognizedAt, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('processingTimeMs: $processingTimeMs, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('userConfirmed: $userConfirmed, ')
          ..write('userCorrected: $userCorrected, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RecognitionResultsTable extends RecognitionResults
    with TableInfo<$RecognitionResultsTable, RecognitionResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecognitionResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _historyIdMeta =
      const VerificationMeta('historyId');
  @override
  late final GeneratedColumn<int> historyId = GeneratedColumn<int>(
      'history_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recognition_histories (id) ON DELETE CASCADE'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES foods (id)'));
  static const VerificationMeta _detectedLabelMeta =
      const VerificationMeta('detectedLabel');
  @override
  late final GeneratedColumn<String> detectedLabel = GeneratedColumn<String>(
      'detected_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _confidenceMeta =
      const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
      'confidence', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _boundingBoxXMeta =
      const VerificationMeta('boundingBoxX');
  @override
  late final GeneratedColumn<double> boundingBoxX = GeneratedColumn<double>(
      'bounding_box_x', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _boundingBoxYMeta =
      const VerificationMeta('boundingBoxY');
  @override
  late final GeneratedColumn<double> boundingBoxY = GeneratedColumn<double>(
      'bounding_box_y', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _boundingBoxWidthMeta =
      const VerificationMeta('boundingBoxWidth');
  @override
  late final GeneratedColumn<double> boundingBoxWidth = GeneratedColumn<double>(
      'bounding_box_width', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _boundingBoxHeightMeta =
      const VerificationMeta('boundingBoxHeight');
  @override
  late final GeneratedColumn<double> boundingBoxHeight =
      GeneratedColumn<double>('bounding_box_height', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _estimatedGramsMeta =
      const VerificationMeta('estimatedGrams');
  @override
  late final GeneratedColumn<double> estimatedGrams = GeneratedColumn<double>(
      'estimated_grams', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _portionEstimateMethodMeta =
      const VerificationMeta('portionEstimateMethod');
  @override
  late final GeneratedColumn<String> portionEstimateMethod =
      GeneratedColumn<String>('portion_estimate_method', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _correctedFoodIdMeta =
      const VerificationMeta('correctedFoodId');
  @override
  late final GeneratedColumn<int> correctedFoodId = GeneratedColumn<int>(
      'corrected_food_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES foods (id)'));
  static const VerificationMeta _correctedGramsMeta =
      const VerificationMeta('correctedGrams');
  @override
  late final GeneratedColumn<double> correctedGrams = GeneratedColumn<double>(
      'corrected_grams', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _userNotesMeta =
      const VerificationMeta('userNotes');
  @override
  late final GeneratedColumn<String> userNotes = GeneratedColumn<String>(
      'user_notes', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 300),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        historyId,
        foodId,
        detectedLabel,
        confidence,
        boundingBoxX,
        boundingBoxY,
        boundingBoxWidth,
        boundingBoxHeight,
        estimatedGrams,
        portionEstimateMethod,
        correctedFoodId,
        correctedGrams,
        userNotes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recognition_results';
  @override
  VerificationContext validateIntegrity(Insertable<RecognitionResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('history_id')) {
      context.handle(_historyIdMeta,
          historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta));
    } else if (isInserting) {
      context.missing(_historyIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    }
    if (data.containsKey('detected_label')) {
      context.handle(
          _detectedLabelMeta,
          detectedLabel.isAcceptableOrUnknown(
              data['detected_label']!, _detectedLabelMeta));
    } else if (isInserting) {
      context.missing(_detectedLabelMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
          _confidenceMeta,
          confidence.isAcceptableOrUnknown(
              data['confidence']!, _confidenceMeta));
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('bounding_box_x')) {
      context.handle(
          _boundingBoxXMeta,
          boundingBoxX.isAcceptableOrUnknown(
              data['bounding_box_x']!, _boundingBoxXMeta));
    }
    if (data.containsKey('bounding_box_y')) {
      context.handle(
          _boundingBoxYMeta,
          boundingBoxY.isAcceptableOrUnknown(
              data['bounding_box_y']!, _boundingBoxYMeta));
    }
    if (data.containsKey('bounding_box_width')) {
      context.handle(
          _boundingBoxWidthMeta,
          boundingBoxWidth.isAcceptableOrUnknown(
              data['bounding_box_width']!, _boundingBoxWidthMeta));
    }
    if (data.containsKey('bounding_box_height')) {
      context.handle(
          _boundingBoxHeightMeta,
          boundingBoxHeight.isAcceptableOrUnknown(
              data['bounding_box_height']!, _boundingBoxHeightMeta));
    }
    if (data.containsKey('estimated_grams')) {
      context.handle(
          _estimatedGramsMeta,
          estimatedGrams.isAcceptableOrUnknown(
              data['estimated_grams']!, _estimatedGramsMeta));
    }
    if (data.containsKey('portion_estimate_method')) {
      context.handle(
          _portionEstimateMethodMeta,
          portionEstimateMethod.isAcceptableOrUnknown(
              data['portion_estimate_method']!, _portionEstimateMethodMeta));
    }
    if (data.containsKey('corrected_food_id')) {
      context.handle(
          _correctedFoodIdMeta,
          correctedFoodId.isAcceptableOrUnknown(
              data['corrected_food_id']!, _correctedFoodIdMeta));
    }
    if (data.containsKey('corrected_grams')) {
      context.handle(
          _correctedGramsMeta,
          correctedGrams.isAcceptableOrUnknown(
              data['corrected_grams']!, _correctedGramsMeta));
    }
    if (data.containsKey('user_notes')) {
      context.handle(_userNotesMeta,
          userNotes.isAcceptableOrUnknown(data['user_notes']!, _userNotesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecognitionResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecognitionResult(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      historyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}history_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id']),
      detectedLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detected_label'])!,
      confidence: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}confidence'])!,
      boundingBoxX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bounding_box_x']),
      boundingBoxY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bounding_box_y']),
      boundingBoxWidth: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}bounding_box_width']),
      boundingBoxHeight: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}bounding_box_height']),
      estimatedGrams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}estimated_grams']),
      portionEstimateMethod: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}portion_estimate_method']),
      correctedFoodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}corrected_food_id']),
      correctedGrams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}corrected_grams']),
      userNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RecognitionResultsTable createAlias(String alias) {
    return $RecognitionResultsTable(attachedDatabase, alias);
  }
}

class RecognitionResult extends DataClass
    implements Insertable<RecognitionResult> {
  final int id;
  final int historyId;
  final int? foodId;
  final String detectedLabel;
  final double confidence;
  final double? boundingBoxX;
  final double? boundingBoxY;
  final double? boundingBoxWidth;
  final double? boundingBoxHeight;
  final double? estimatedGrams;
  final String? portionEstimateMethod;
  final int? correctedFoodId;
  final double? correctedGrams;
  final String? userNotes;
  final DateTime createdAt;
  const RecognitionResult(
      {required this.id,
      required this.historyId,
      this.foodId,
      required this.detectedLabel,
      required this.confidence,
      this.boundingBoxX,
      this.boundingBoxY,
      this.boundingBoxWidth,
      this.boundingBoxHeight,
      this.estimatedGrams,
      this.portionEstimateMethod,
      this.correctedFoodId,
      this.correctedGrams,
      this.userNotes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['history_id'] = Variable<int>(historyId);
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<int>(foodId);
    }
    map['detected_label'] = Variable<String>(detectedLabel);
    map['confidence'] = Variable<double>(confidence);
    if (!nullToAbsent || boundingBoxX != null) {
      map['bounding_box_x'] = Variable<double>(boundingBoxX);
    }
    if (!nullToAbsent || boundingBoxY != null) {
      map['bounding_box_y'] = Variable<double>(boundingBoxY);
    }
    if (!nullToAbsent || boundingBoxWidth != null) {
      map['bounding_box_width'] = Variable<double>(boundingBoxWidth);
    }
    if (!nullToAbsent || boundingBoxHeight != null) {
      map['bounding_box_height'] = Variable<double>(boundingBoxHeight);
    }
    if (!nullToAbsent || estimatedGrams != null) {
      map['estimated_grams'] = Variable<double>(estimatedGrams);
    }
    if (!nullToAbsent || portionEstimateMethod != null) {
      map['portion_estimate_method'] = Variable<String>(portionEstimateMethod);
    }
    if (!nullToAbsent || correctedFoodId != null) {
      map['corrected_food_id'] = Variable<int>(correctedFoodId);
    }
    if (!nullToAbsent || correctedGrams != null) {
      map['corrected_grams'] = Variable<double>(correctedGrams);
    }
    if (!nullToAbsent || userNotes != null) {
      map['user_notes'] = Variable<String>(userNotes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecognitionResultsCompanion toCompanion(bool nullToAbsent) {
    return RecognitionResultsCompanion(
      id: Value(id),
      historyId: Value(historyId),
      foodId:
          foodId == null && nullToAbsent ? const Value.absent() : Value(foodId),
      detectedLabel: Value(detectedLabel),
      confidence: Value(confidence),
      boundingBoxX: boundingBoxX == null && nullToAbsent
          ? const Value.absent()
          : Value(boundingBoxX),
      boundingBoxY: boundingBoxY == null && nullToAbsent
          ? const Value.absent()
          : Value(boundingBoxY),
      boundingBoxWidth: boundingBoxWidth == null && nullToAbsent
          ? const Value.absent()
          : Value(boundingBoxWidth),
      boundingBoxHeight: boundingBoxHeight == null && nullToAbsent
          ? const Value.absent()
          : Value(boundingBoxHeight),
      estimatedGrams: estimatedGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedGrams),
      portionEstimateMethod: portionEstimateMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(portionEstimateMethod),
      correctedFoodId: correctedFoodId == null && nullToAbsent
          ? const Value.absent()
          : Value(correctedFoodId),
      correctedGrams: correctedGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(correctedGrams),
      userNotes: userNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(userNotes),
      createdAt: Value(createdAt),
    );
  }

  factory RecognitionResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecognitionResult(
      id: serializer.fromJson<int>(json['id']),
      historyId: serializer.fromJson<int>(json['historyId']),
      foodId: serializer.fromJson<int?>(json['foodId']),
      detectedLabel: serializer.fromJson<String>(json['detectedLabel']),
      confidence: serializer.fromJson<double>(json['confidence']),
      boundingBoxX: serializer.fromJson<double?>(json['boundingBoxX']),
      boundingBoxY: serializer.fromJson<double?>(json['boundingBoxY']),
      boundingBoxWidth: serializer.fromJson<double?>(json['boundingBoxWidth']),
      boundingBoxHeight:
          serializer.fromJson<double?>(json['boundingBoxHeight']),
      estimatedGrams: serializer.fromJson<double?>(json['estimatedGrams']),
      portionEstimateMethod:
          serializer.fromJson<String?>(json['portionEstimateMethod']),
      correctedFoodId: serializer.fromJson<int?>(json['correctedFoodId']),
      correctedGrams: serializer.fromJson<double?>(json['correctedGrams']),
      userNotes: serializer.fromJson<String?>(json['userNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'historyId': serializer.toJson<int>(historyId),
      'foodId': serializer.toJson<int?>(foodId),
      'detectedLabel': serializer.toJson<String>(detectedLabel),
      'confidence': serializer.toJson<double>(confidence),
      'boundingBoxX': serializer.toJson<double?>(boundingBoxX),
      'boundingBoxY': serializer.toJson<double?>(boundingBoxY),
      'boundingBoxWidth': serializer.toJson<double?>(boundingBoxWidth),
      'boundingBoxHeight': serializer.toJson<double?>(boundingBoxHeight),
      'estimatedGrams': serializer.toJson<double?>(estimatedGrams),
      'portionEstimateMethod':
          serializer.toJson<String?>(portionEstimateMethod),
      'correctedFoodId': serializer.toJson<int?>(correctedFoodId),
      'correctedGrams': serializer.toJson<double?>(correctedGrams),
      'userNotes': serializer.toJson<String?>(userNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecognitionResult copyWith(
          {int? id,
          int? historyId,
          Value<int?> foodId = const Value.absent(),
          String? detectedLabel,
          double? confidence,
          Value<double?> boundingBoxX = const Value.absent(),
          Value<double?> boundingBoxY = const Value.absent(),
          Value<double?> boundingBoxWidth = const Value.absent(),
          Value<double?> boundingBoxHeight = const Value.absent(),
          Value<double?> estimatedGrams = const Value.absent(),
          Value<String?> portionEstimateMethod = const Value.absent(),
          Value<int?> correctedFoodId = const Value.absent(),
          Value<double?> correctedGrams = const Value.absent(),
          Value<String?> userNotes = const Value.absent(),
          DateTime? createdAt}) =>
      RecognitionResult(
        id: id ?? this.id,
        historyId: historyId ?? this.historyId,
        foodId: foodId.present ? foodId.value : this.foodId,
        detectedLabel: detectedLabel ?? this.detectedLabel,
        confidence: confidence ?? this.confidence,
        boundingBoxX:
            boundingBoxX.present ? boundingBoxX.value : this.boundingBoxX,
        boundingBoxY:
            boundingBoxY.present ? boundingBoxY.value : this.boundingBoxY,
        boundingBoxWidth: boundingBoxWidth.present
            ? boundingBoxWidth.value
            : this.boundingBoxWidth,
        boundingBoxHeight: boundingBoxHeight.present
            ? boundingBoxHeight.value
            : this.boundingBoxHeight,
        estimatedGrams:
            estimatedGrams.present ? estimatedGrams.value : this.estimatedGrams,
        portionEstimateMethod: portionEstimateMethod.present
            ? portionEstimateMethod.value
            : this.portionEstimateMethod,
        correctedFoodId: correctedFoodId.present
            ? correctedFoodId.value
            : this.correctedFoodId,
        correctedGrams:
            correctedGrams.present ? correctedGrams.value : this.correctedGrams,
        userNotes: userNotes.present ? userNotes.value : this.userNotes,
        createdAt: createdAt ?? this.createdAt,
      );
  RecognitionResult copyWithCompanion(RecognitionResultsCompanion data) {
    return RecognitionResult(
      id: data.id.present ? data.id.value : this.id,
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      detectedLabel: data.detectedLabel.present
          ? data.detectedLabel.value
          : this.detectedLabel,
      confidence:
          data.confidence.present ? data.confidence.value : this.confidence,
      boundingBoxX: data.boundingBoxX.present
          ? data.boundingBoxX.value
          : this.boundingBoxX,
      boundingBoxY: data.boundingBoxY.present
          ? data.boundingBoxY.value
          : this.boundingBoxY,
      boundingBoxWidth: data.boundingBoxWidth.present
          ? data.boundingBoxWidth.value
          : this.boundingBoxWidth,
      boundingBoxHeight: data.boundingBoxHeight.present
          ? data.boundingBoxHeight.value
          : this.boundingBoxHeight,
      estimatedGrams: data.estimatedGrams.present
          ? data.estimatedGrams.value
          : this.estimatedGrams,
      portionEstimateMethod: data.portionEstimateMethod.present
          ? data.portionEstimateMethod.value
          : this.portionEstimateMethod,
      correctedFoodId: data.correctedFoodId.present
          ? data.correctedFoodId.value
          : this.correctedFoodId,
      correctedGrams: data.correctedGrams.present
          ? data.correctedGrams.value
          : this.correctedGrams,
      userNotes: data.userNotes.present ? data.userNotes.value : this.userNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecognitionResult(')
          ..write('id: $id, ')
          ..write('historyId: $historyId, ')
          ..write('foodId: $foodId, ')
          ..write('detectedLabel: $detectedLabel, ')
          ..write('confidence: $confidence, ')
          ..write('boundingBoxX: $boundingBoxX, ')
          ..write('boundingBoxY: $boundingBoxY, ')
          ..write('boundingBoxWidth: $boundingBoxWidth, ')
          ..write('boundingBoxHeight: $boundingBoxHeight, ')
          ..write('estimatedGrams: $estimatedGrams, ')
          ..write('portionEstimateMethod: $portionEstimateMethod, ')
          ..write('correctedFoodId: $correctedFoodId, ')
          ..write('correctedGrams: $correctedGrams, ')
          ..write('userNotes: $userNotes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      historyId,
      foodId,
      detectedLabel,
      confidence,
      boundingBoxX,
      boundingBoxY,
      boundingBoxWidth,
      boundingBoxHeight,
      estimatedGrams,
      portionEstimateMethod,
      correctedFoodId,
      correctedGrams,
      userNotes,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecognitionResult &&
          other.id == this.id &&
          other.historyId == this.historyId &&
          other.foodId == this.foodId &&
          other.detectedLabel == this.detectedLabel &&
          other.confidence == this.confidence &&
          other.boundingBoxX == this.boundingBoxX &&
          other.boundingBoxY == this.boundingBoxY &&
          other.boundingBoxWidth == this.boundingBoxWidth &&
          other.boundingBoxHeight == this.boundingBoxHeight &&
          other.estimatedGrams == this.estimatedGrams &&
          other.portionEstimateMethod == this.portionEstimateMethod &&
          other.correctedFoodId == this.correctedFoodId &&
          other.correctedGrams == this.correctedGrams &&
          other.userNotes == this.userNotes &&
          other.createdAt == this.createdAt);
}

class RecognitionResultsCompanion extends UpdateCompanion<RecognitionResult> {
  final Value<int> id;
  final Value<int> historyId;
  final Value<int?> foodId;
  final Value<String> detectedLabel;
  final Value<double> confidence;
  final Value<double?> boundingBoxX;
  final Value<double?> boundingBoxY;
  final Value<double?> boundingBoxWidth;
  final Value<double?> boundingBoxHeight;
  final Value<double?> estimatedGrams;
  final Value<String?> portionEstimateMethod;
  final Value<int?> correctedFoodId;
  final Value<double?> correctedGrams;
  final Value<String?> userNotes;
  final Value<DateTime> createdAt;
  const RecognitionResultsCompanion({
    this.id = const Value.absent(),
    this.historyId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.detectedLabel = const Value.absent(),
    this.confidence = const Value.absent(),
    this.boundingBoxX = const Value.absent(),
    this.boundingBoxY = const Value.absent(),
    this.boundingBoxWidth = const Value.absent(),
    this.boundingBoxHeight = const Value.absent(),
    this.estimatedGrams = const Value.absent(),
    this.portionEstimateMethod = const Value.absent(),
    this.correctedFoodId = const Value.absent(),
    this.correctedGrams = const Value.absent(),
    this.userNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RecognitionResultsCompanion.insert({
    this.id = const Value.absent(),
    required int historyId,
    this.foodId = const Value.absent(),
    required String detectedLabel,
    required double confidence,
    this.boundingBoxX = const Value.absent(),
    this.boundingBoxY = const Value.absent(),
    this.boundingBoxWidth = const Value.absent(),
    this.boundingBoxHeight = const Value.absent(),
    this.estimatedGrams = const Value.absent(),
    this.portionEstimateMethod = const Value.absent(),
    this.correctedFoodId = const Value.absent(),
    this.correctedGrams = const Value.absent(),
    this.userNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : historyId = Value(historyId),
        detectedLabel = Value(detectedLabel),
        confidence = Value(confidence);
  static Insertable<RecognitionResult> custom({
    Expression<int>? id,
    Expression<int>? historyId,
    Expression<int>? foodId,
    Expression<String>? detectedLabel,
    Expression<double>? confidence,
    Expression<double>? boundingBoxX,
    Expression<double>? boundingBoxY,
    Expression<double>? boundingBoxWidth,
    Expression<double>? boundingBoxHeight,
    Expression<double>? estimatedGrams,
    Expression<String>? portionEstimateMethod,
    Expression<int>? correctedFoodId,
    Expression<double>? correctedGrams,
    Expression<String>? userNotes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (historyId != null) 'history_id': historyId,
      if (foodId != null) 'food_id': foodId,
      if (detectedLabel != null) 'detected_label': detectedLabel,
      if (confidence != null) 'confidence': confidence,
      if (boundingBoxX != null) 'bounding_box_x': boundingBoxX,
      if (boundingBoxY != null) 'bounding_box_y': boundingBoxY,
      if (boundingBoxWidth != null) 'bounding_box_width': boundingBoxWidth,
      if (boundingBoxHeight != null) 'bounding_box_height': boundingBoxHeight,
      if (estimatedGrams != null) 'estimated_grams': estimatedGrams,
      if (portionEstimateMethod != null)
        'portion_estimate_method': portionEstimateMethod,
      if (correctedFoodId != null) 'corrected_food_id': correctedFoodId,
      if (correctedGrams != null) 'corrected_grams': correctedGrams,
      if (userNotes != null) 'user_notes': userNotes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RecognitionResultsCompanion copyWith(
      {Value<int>? id,
      Value<int>? historyId,
      Value<int?>? foodId,
      Value<String>? detectedLabel,
      Value<double>? confidence,
      Value<double?>? boundingBoxX,
      Value<double?>? boundingBoxY,
      Value<double?>? boundingBoxWidth,
      Value<double?>? boundingBoxHeight,
      Value<double?>? estimatedGrams,
      Value<String?>? portionEstimateMethod,
      Value<int?>? correctedFoodId,
      Value<double?>? correctedGrams,
      Value<String?>? userNotes,
      Value<DateTime>? createdAt}) {
    return RecognitionResultsCompanion(
      id: id ?? this.id,
      historyId: historyId ?? this.historyId,
      foodId: foodId ?? this.foodId,
      detectedLabel: detectedLabel ?? this.detectedLabel,
      confidence: confidence ?? this.confidence,
      boundingBoxX: boundingBoxX ?? this.boundingBoxX,
      boundingBoxY: boundingBoxY ?? this.boundingBoxY,
      boundingBoxWidth: boundingBoxWidth ?? this.boundingBoxWidth,
      boundingBoxHeight: boundingBoxHeight ?? this.boundingBoxHeight,
      estimatedGrams: estimatedGrams ?? this.estimatedGrams,
      portionEstimateMethod:
          portionEstimateMethod ?? this.portionEstimateMethod,
      correctedFoodId: correctedFoodId ?? this.correctedFoodId,
      correctedGrams: correctedGrams ?? this.correctedGrams,
      userNotes: userNotes ?? this.userNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (historyId.present) {
      map['history_id'] = Variable<int>(historyId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (detectedLabel.present) {
      map['detected_label'] = Variable<String>(detectedLabel.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (boundingBoxX.present) {
      map['bounding_box_x'] = Variable<double>(boundingBoxX.value);
    }
    if (boundingBoxY.present) {
      map['bounding_box_y'] = Variable<double>(boundingBoxY.value);
    }
    if (boundingBoxWidth.present) {
      map['bounding_box_width'] = Variable<double>(boundingBoxWidth.value);
    }
    if (boundingBoxHeight.present) {
      map['bounding_box_height'] = Variable<double>(boundingBoxHeight.value);
    }
    if (estimatedGrams.present) {
      map['estimated_grams'] = Variable<double>(estimatedGrams.value);
    }
    if (portionEstimateMethod.present) {
      map['portion_estimate_method'] =
          Variable<String>(portionEstimateMethod.value);
    }
    if (correctedFoodId.present) {
      map['corrected_food_id'] = Variable<int>(correctedFoodId.value);
    }
    if (correctedGrams.present) {
      map['corrected_grams'] = Variable<double>(correctedGrams.value);
    }
    if (userNotes.present) {
      map['user_notes'] = Variable<String>(userNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecognitionResultsCompanion(')
          ..write('id: $id, ')
          ..write('historyId: $historyId, ')
          ..write('foodId: $foodId, ')
          ..write('detectedLabel: $detectedLabel, ')
          ..write('confidence: $confidence, ')
          ..write('boundingBoxX: $boundingBoxX, ')
          ..write('boundingBoxY: $boundingBoxY, ')
          ..write('boundingBoxWidth: $boundingBoxWidth, ')
          ..write('boundingBoxHeight: $boundingBoxHeight, ')
          ..write('estimatedGrams: $estimatedGrams, ')
          ..write('portionEstimateMethod: $portionEstimateMethod, ')
          ..write('correctedFoodId: $correctedFoodId, ')
          ..write('correctedGrams: $correctedGrams, ')
          ..write('userNotes: $userNotes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RecognitionFeedbacksTable extends RecognitionFeedbacks
    with TableInfo<$RecognitionFeedbacksTable, RecognitionFeedback> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecognitionFeedbacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _resultIdMeta =
      const VerificationMeta('resultId');
  @override
  late final GeneratedColumn<int> resultId = GeneratedColumn<int>(
      'result_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recognition_results (id) ON DELETE CASCADE'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _feedbackTypeMeta =
      const VerificationMeta('feedbackType');
  @override
  late final GeneratedColumn<String> feedbackType = GeneratedColumn<String>(
      'feedback_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correctnessScoreMeta =
      const VerificationMeta('correctnessScore');
  @override
  late final GeneratedColumn<int> correctnessScore = GeneratedColumn<int>(
      'correctness_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _correctFoodNameMeta =
      const VerificationMeta('correctFoodName');
  @override
  late final GeneratedColumn<String> correctFoodName = GeneratedColumn<String>(
      'correct_food_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actualGramsMeta =
      const VerificationMeta('actualGrams');
  @override
  late final GeneratedColumn<double> actualGrams = GeneratedColumn<double>(
      'actual_grams', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _commentsMeta =
      const VerificationMeta('comments');
  @override
  late final GeneratedColumn<String> comments = GeneratedColumn<String>(
      'comments', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _imageQualityScoreMeta =
      const VerificationMeta('imageQualityScore');
  @override
  late final GeneratedColumn<int> imageQualityScore = GeneratedColumn<int>(
      'image_quality_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imageIssuesMeta =
      const VerificationMeta('imageIssues');
  @override
  late final GeneratedColumn<String> imageIssues = GeneratedColumn<String>(
      'image_issues', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        resultId,
        userId,
        feedbackType,
        correctnessScore,
        correctFoodName,
        actualGrams,
        comments,
        imageQualityScore,
        imageIssues,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recognition_feedbacks';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecognitionFeedback> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('result_id')) {
      context.handle(_resultIdMeta,
          resultId.isAcceptableOrUnknown(data['result_id']!, _resultIdMeta));
    } else if (isInserting) {
      context.missing(_resultIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('feedback_type')) {
      context.handle(
          _feedbackTypeMeta,
          feedbackType.isAcceptableOrUnknown(
              data['feedback_type']!, _feedbackTypeMeta));
    } else if (isInserting) {
      context.missing(_feedbackTypeMeta);
    }
    if (data.containsKey('correctness_score')) {
      context.handle(
          _correctnessScoreMeta,
          correctnessScore.isAcceptableOrUnknown(
              data['correctness_score']!, _correctnessScoreMeta));
    }
    if (data.containsKey('correct_food_name')) {
      context.handle(
          _correctFoodNameMeta,
          correctFoodName.isAcceptableOrUnknown(
              data['correct_food_name']!, _correctFoodNameMeta));
    }
    if (data.containsKey('actual_grams')) {
      context.handle(
          _actualGramsMeta,
          actualGrams.isAcceptableOrUnknown(
              data['actual_grams']!, _actualGramsMeta));
    }
    if (data.containsKey('comments')) {
      context.handle(_commentsMeta,
          comments.isAcceptableOrUnknown(data['comments']!, _commentsMeta));
    }
    if (data.containsKey('image_quality_score')) {
      context.handle(
          _imageQualityScoreMeta,
          imageQualityScore.isAcceptableOrUnknown(
              data['image_quality_score']!, _imageQualityScoreMeta));
    }
    if (data.containsKey('image_issues')) {
      context.handle(
          _imageIssuesMeta,
          imageIssues.isAcceptableOrUnknown(
              data['image_issues']!, _imageIssuesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecognitionFeedback map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecognitionFeedback(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      resultId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}result_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      feedbackType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feedback_type'])!,
      correctnessScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correctness_score']),
      correctFoodName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}correct_food_name']),
      actualGrams: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_grams']),
      comments: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comments']),
      imageQualityScore: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}image_quality_score']),
      imageIssues: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_issues']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RecognitionFeedbacksTable createAlias(String alias) {
    return $RecognitionFeedbacksTable(attachedDatabase, alias);
  }
}

class RecognitionFeedback extends DataClass
    implements Insertable<RecognitionFeedback> {
  final int id;
  final int resultId;
  final String userId;
  final String feedbackType;
  final int? correctnessScore;
  final String? correctFoodName;
  final double? actualGrams;
  final String? comments;
  final int? imageQualityScore;
  final String? imageIssues;
  final DateTime createdAt;
  const RecognitionFeedback(
      {required this.id,
      required this.resultId,
      required this.userId,
      required this.feedbackType,
      this.correctnessScore,
      this.correctFoodName,
      this.actualGrams,
      this.comments,
      this.imageQualityScore,
      this.imageIssues,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['result_id'] = Variable<int>(resultId);
    map['user_id'] = Variable<String>(userId);
    map['feedback_type'] = Variable<String>(feedbackType);
    if (!nullToAbsent || correctnessScore != null) {
      map['correctness_score'] = Variable<int>(correctnessScore);
    }
    if (!nullToAbsent || correctFoodName != null) {
      map['correct_food_name'] = Variable<String>(correctFoodName);
    }
    if (!nullToAbsent || actualGrams != null) {
      map['actual_grams'] = Variable<double>(actualGrams);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<String>(comments);
    }
    if (!nullToAbsent || imageQualityScore != null) {
      map['image_quality_score'] = Variable<int>(imageQualityScore);
    }
    if (!nullToAbsent || imageIssues != null) {
      map['image_issues'] = Variable<String>(imageIssues);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecognitionFeedbacksCompanion toCompanion(bool nullToAbsent) {
    return RecognitionFeedbacksCompanion(
      id: Value(id),
      resultId: Value(resultId),
      userId: Value(userId),
      feedbackType: Value(feedbackType),
      correctnessScore: correctnessScore == null && nullToAbsent
          ? const Value.absent()
          : Value(correctnessScore),
      correctFoodName: correctFoodName == null && nullToAbsent
          ? const Value.absent()
          : Value(correctFoodName),
      actualGrams: actualGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(actualGrams),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      imageQualityScore: imageQualityScore == null && nullToAbsent
          ? const Value.absent()
          : Value(imageQualityScore),
      imageIssues: imageIssues == null && nullToAbsent
          ? const Value.absent()
          : Value(imageIssues),
      createdAt: Value(createdAt),
    );
  }

  factory RecognitionFeedback.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecognitionFeedback(
      id: serializer.fromJson<int>(json['id']),
      resultId: serializer.fromJson<int>(json['resultId']),
      userId: serializer.fromJson<String>(json['userId']),
      feedbackType: serializer.fromJson<String>(json['feedbackType']),
      correctnessScore: serializer.fromJson<int?>(json['correctnessScore']),
      correctFoodName: serializer.fromJson<String?>(json['correctFoodName']),
      actualGrams: serializer.fromJson<double?>(json['actualGrams']),
      comments: serializer.fromJson<String?>(json['comments']),
      imageQualityScore: serializer.fromJson<int?>(json['imageQualityScore']),
      imageIssues: serializer.fromJson<String?>(json['imageIssues']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resultId': serializer.toJson<int>(resultId),
      'userId': serializer.toJson<String>(userId),
      'feedbackType': serializer.toJson<String>(feedbackType),
      'correctnessScore': serializer.toJson<int?>(correctnessScore),
      'correctFoodName': serializer.toJson<String?>(correctFoodName),
      'actualGrams': serializer.toJson<double?>(actualGrams),
      'comments': serializer.toJson<String?>(comments),
      'imageQualityScore': serializer.toJson<int?>(imageQualityScore),
      'imageIssues': serializer.toJson<String?>(imageIssues),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecognitionFeedback copyWith(
          {int? id,
          int? resultId,
          String? userId,
          String? feedbackType,
          Value<int?> correctnessScore = const Value.absent(),
          Value<String?> correctFoodName = const Value.absent(),
          Value<double?> actualGrams = const Value.absent(),
          Value<String?> comments = const Value.absent(),
          Value<int?> imageQualityScore = const Value.absent(),
          Value<String?> imageIssues = const Value.absent(),
          DateTime? createdAt}) =>
      RecognitionFeedback(
        id: id ?? this.id,
        resultId: resultId ?? this.resultId,
        userId: userId ?? this.userId,
        feedbackType: feedbackType ?? this.feedbackType,
        correctnessScore: correctnessScore.present
            ? correctnessScore.value
            : this.correctnessScore,
        correctFoodName: correctFoodName.present
            ? correctFoodName.value
            : this.correctFoodName,
        actualGrams: actualGrams.present ? actualGrams.value : this.actualGrams,
        comments: comments.present ? comments.value : this.comments,
        imageQualityScore: imageQualityScore.present
            ? imageQualityScore.value
            : this.imageQualityScore,
        imageIssues: imageIssues.present ? imageIssues.value : this.imageIssues,
        createdAt: createdAt ?? this.createdAt,
      );
  RecognitionFeedback copyWithCompanion(RecognitionFeedbacksCompanion data) {
    return RecognitionFeedback(
      id: data.id.present ? data.id.value : this.id,
      resultId: data.resultId.present ? data.resultId.value : this.resultId,
      userId: data.userId.present ? data.userId.value : this.userId,
      feedbackType: data.feedbackType.present
          ? data.feedbackType.value
          : this.feedbackType,
      correctnessScore: data.correctnessScore.present
          ? data.correctnessScore.value
          : this.correctnessScore,
      correctFoodName: data.correctFoodName.present
          ? data.correctFoodName.value
          : this.correctFoodName,
      actualGrams:
          data.actualGrams.present ? data.actualGrams.value : this.actualGrams,
      comments: data.comments.present ? data.comments.value : this.comments,
      imageQualityScore: data.imageQualityScore.present
          ? data.imageQualityScore.value
          : this.imageQualityScore,
      imageIssues:
          data.imageIssues.present ? data.imageIssues.value : this.imageIssues,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecognitionFeedback(')
          ..write('id: $id, ')
          ..write('resultId: $resultId, ')
          ..write('userId: $userId, ')
          ..write('feedbackType: $feedbackType, ')
          ..write('correctnessScore: $correctnessScore, ')
          ..write('correctFoodName: $correctFoodName, ')
          ..write('actualGrams: $actualGrams, ')
          ..write('comments: $comments, ')
          ..write('imageQualityScore: $imageQualityScore, ')
          ..write('imageIssues: $imageIssues, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      resultId,
      userId,
      feedbackType,
      correctnessScore,
      correctFoodName,
      actualGrams,
      comments,
      imageQualityScore,
      imageIssues,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecognitionFeedback &&
          other.id == this.id &&
          other.resultId == this.resultId &&
          other.userId == this.userId &&
          other.feedbackType == this.feedbackType &&
          other.correctnessScore == this.correctnessScore &&
          other.correctFoodName == this.correctFoodName &&
          other.actualGrams == this.actualGrams &&
          other.comments == this.comments &&
          other.imageQualityScore == this.imageQualityScore &&
          other.imageIssues == this.imageIssues &&
          other.createdAt == this.createdAt);
}

class RecognitionFeedbacksCompanion
    extends UpdateCompanion<RecognitionFeedback> {
  final Value<int> id;
  final Value<int> resultId;
  final Value<String> userId;
  final Value<String> feedbackType;
  final Value<int?> correctnessScore;
  final Value<String?> correctFoodName;
  final Value<double?> actualGrams;
  final Value<String?> comments;
  final Value<int?> imageQualityScore;
  final Value<String?> imageIssues;
  final Value<DateTime> createdAt;
  const RecognitionFeedbacksCompanion({
    this.id = const Value.absent(),
    this.resultId = const Value.absent(),
    this.userId = const Value.absent(),
    this.feedbackType = const Value.absent(),
    this.correctnessScore = const Value.absent(),
    this.correctFoodName = const Value.absent(),
    this.actualGrams = const Value.absent(),
    this.comments = const Value.absent(),
    this.imageQualityScore = const Value.absent(),
    this.imageIssues = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RecognitionFeedbacksCompanion.insert({
    this.id = const Value.absent(),
    required int resultId,
    required String userId,
    required String feedbackType,
    this.correctnessScore = const Value.absent(),
    this.correctFoodName = const Value.absent(),
    this.actualGrams = const Value.absent(),
    this.comments = const Value.absent(),
    this.imageQualityScore = const Value.absent(),
    this.imageIssues = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : resultId = Value(resultId),
        userId = Value(userId),
        feedbackType = Value(feedbackType);
  static Insertable<RecognitionFeedback> custom({
    Expression<int>? id,
    Expression<int>? resultId,
    Expression<String>? userId,
    Expression<String>? feedbackType,
    Expression<int>? correctnessScore,
    Expression<String>? correctFoodName,
    Expression<double>? actualGrams,
    Expression<String>? comments,
    Expression<int>? imageQualityScore,
    Expression<String>? imageIssues,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resultId != null) 'result_id': resultId,
      if (userId != null) 'user_id': userId,
      if (feedbackType != null) 'feedback_type': feedbackType,
      if (correctnessScore != null) 'correctness_score': correctnessScore,
      if (correctFoodName != null) 'correct_food_name': correctFoodName,
      if (actualGrams != null) 'actual_grams': actualGrams,
      if (comments != null) 'comments': comments,
      if (imageQualityScore != null) 'image_quality_score': imageQualityScore,
      if (imageIssues != null) 'image_issues': imageIssues,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RecognitionFeedbacksCompanion copyWith(
      {Value<int>? id,
      Value<int>? resultId,
      Value<String>? userId,
      Value<String>? feedbackType,
      Value<int?>? correctnessScore,
      Value<String?>? correctFoodName,
      Value<double?>? actualGrams,
      Value<String?>? comments,
      Value<int?>? imageQualityScore,
      Value<String?>? imageIssues,
      Value<DateTime>? createdAt}) {
    return RecognitionFeedbacksCompanion(
      id: id ?? this.id,
      resultId: resultId ?? this.resultId,
      userId: userId ?? this.userId,
      feedbackType: feedbackType ?? this.feedbackType,
      correctnessScore: correctnessScore ?? this.correctnessScore,
      correctFoodName: correctFoodName ?? this.correctFoodName,
      actualGrams: actualGrams ?? this.actualGrams,
      comments: comments ?? this.comments,
      imageQualityScore: imageQualityScore ?? this.imageQualityScore,
      imageIssues: imageIssues ?? this.imageIssues,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (resultId.present) {
      map['result_id'] = Variable<int>(resultId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (feedbackType.present) {
      map['feedback_type'] = Variable<String>(feedbackType.value);
    }
    if (correctnessScore.present) {
      map['correctness_score'] = Variable<int>(correctnessScore.value);
    }
    if (correctFoodName.present) {
      map['correct_food_name'] = Variable<String>(correctFoodName.value);
    }
    if (actualGrams.present) {
      map['actual_grams'] = Variable<double>(actualGrams.value);
    }
    if (comments.present) {
      map['comments'] = Variable<String>(comments.value);
    }
    if (imageQualityScore.present) {
      map['image_quality_score'] = Variable<int>(imageQualityScore.value);
    }
    if (imageIssues.present) {
      map['image_issues'] = Variable<String>(imageIssues.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecognitionFeedbacksCompanion(')
          ..write('id: $id, ')
          ..write('resultId: $resultId, ')
          ..write('userId: $userId, ')
          ..write('feedbackType: $feedbackType, ')
          ..write('correctnessScore: $correctnessScore, ')
          ..write('correctFoodName: $correctFoodName, ')
          ..write('actualGrams: $actualGrams, ')
          ..write('comments: $comments, ')
          ..write('imageQualityScore: $imageQualityScore, ')
          ..write('imageIssues: $imageIssues, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dailyCalorieGoalMeta =
      const VerificationMeta('dailyCalorieGoal');
  @override
  late final GeneratedColumn<double> dailyCalorieGoal = GeneratedColumn<double>(
      'daily_calorie_goal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(2000));
  static const VerificationMeta _dailyCarbsGoalMeta =
      const VerificationMeta('dailyCarbsGoal');
  @override
  late final GeneratedColumn<double> dailyCarbsGoal = GeneratedColumn<double>(
      'daily_carbs_goal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(250));
  static const VerificationMeta _dailyProteinGoalMeta =
      const VerificationMeta('dailyProteinGoal');
  @override
  late final GeneratedColumn<double> dailyProteinGoal = GeneratedColumn<double>(
      'daily_protein_goal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(50));
  static const VerificationMeta _dailyFatGoalMeta =
      const VerificationMeta('dailyFatGoal');
  @override
  late final GeneratedColumn<double> dailyFatGoal = GeneratedColumn<double>(
      'daily_fat_goal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(65));
  static const VerificationMeta _dailyFiberGoalMeta =
      const VerificationMeta('dailyFiberGoal');
  @override
  late final GeneratedColumn<double> dailyFiberGoal = GeneratedColumn<double>(
      'daily_fiber_goal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(25));
  static const VerificationMeta _carbsRatioMeta =
      const VerificationMeta('carbsRatio');
  @override
  late final GeneratedColumn<double> carbsRatio = GeneratedColumn<double>(
      'carbs_ratio', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(50));
  static const VerificationMeta _proteinRatioMeta =
      const VerificationMeta('proteinRatio');
  @override
  late final GeneratedColumn<double> proteinRatio = GeneratedColumn<double>(
      'protein_ratio', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(20));
  static const VerificationMeta _fatRatioMeta =
      const VerificationMeta('fatRatio');
  @override
  late final GeneratedColumn<double> fatRatio = GeneratedColumn<double>(
      'fat_ratio', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _activityLevelMeta =
      const VerificationMeta('activityLevel');
  @override
  late final GeneratedColumn<String> activityLevel = GeneratedColumn<String>(
      'activity_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('moderate'));
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
      'goal', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('maintain'));
  static const VerificationMeta _dietaryRestrictionsMeta =
      const VerificationMeta('dietaryRestrictions');
  @override
  late final GeneratedColumn<String> dietaryRestrictions =
      GeneratedColumn<String>('dietary_restrictions', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _allergiesMeta =
      const VerificationMeta('allergies');
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
      'allergies', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dislikedFoodsMeta =
      const VerificationMeta('dislikedFoods');
  @override
  late final GeneratedColumn<String> dislikedFoods = GeneratedColumn<String>(
      'disliked_foods', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aiSuggestionsEnabledMeta =
      const VerificationMeta('aiSuggestionsEnabled');
  @override
  late final GeneratedColumn<bool> aiSuggestionsEnabled = GeneratedColumn<bool>(
      'ai_suggestions_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("ai_suggestions_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _aiConfidenceThresholdMeta =
      const VerificationMeta('aiConfidenceThreshold');
  @override
  late final GeneratedColumn<double> aiConfidenceThreshold =
      GeneratedColumn<double>('ai_confidence_threshold', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.7));
  static const VerificationMeta _autoSaveRecognitionsMeta =
      const VerificationMeta('autoSaveRecognitions');
  @override
  late final GeneratedColumn<bool> autoSaveRecognitions = GeneratedColumn<bool>(
      'auto_save_recognitions', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_save_recognitions" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _mealRemindersEnabledMeta =
      const VerificationMeta('mealRemindersEnabled');
  @override
  late final GeneratedColumn<bool> mealRemindersEnabled = GeneratedColumn<bool>(
      'meal_reminders_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("meal_reminders_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _breakfastReminderTimeMeta =
      const VerificationMeta('breakfastReminderTime');
  @override
  late final GeneratedColumn<String> breakfastReminderTime =
      GeneratedColumn<String>('breakfast_reminder_time', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lunchReminderTimeMeta =
      const VerificationMeta('lunchReminderTime');
  @override
  late final GeneratedColumn<String> lunchReminderTime =
      GeneratedColumn<String>('lunch_reminder_time', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dinnerReminderTimeMeta =
      const VerificationMeta('dinnerReminderTime');
  @override
  late final GeneratedColumn<String> dinnerReminderTime =
      GeneratedColumn<String>('dinner_reminder_time', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nutritionGoalNotificationsMeta =
      const VerificationMeta('nutritionGoalNotifications');
  @override
  late final GeneratedColumn<bool> nutritionGoalNotifications =
      GeneratedColumn<bool>('nutrition_goal_notifications', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("nutrition_goal_notifications" IN (0, 1))'),
          defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        dailyCalorieGoal,
        dailyCarbsGoal,
        dailyProteinGoal,
        dailyFatGoal,
        dailyFiberGoal,
        carbsRatio,
        proteinRatio,
        fatRatio,
        age,
        gender,
        height,
        weight,
        activityLevel,
        goal,
        dietaryRestrictions,
        allergies,
        dislikedFoods,
        aiSuggestionsEnabled,
        aiConfidenceThreshold,
        autoSaveRecognitions,
        mealRemindersEnabled,
        breakfastReminderTime,
        lunchReminderTime,
        dinnerReminderTime,
        nutritionGoalNotifications,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(Insertable<UserPreference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('daily_calorie_goal')) {
      context.handle(
          _dailyCalorieGoalMeta,
          dailyCalorieGoal.isAcceptableOrUnknown(
              data['daily_calorie_goal']!, _dailyCalorieGoalMeta));
    }
    if (data.containsKey('daily_carbs_goal')) {
      context.handle(
          _dailyCarbsGoalMeta,
          dailyCarbsGoal.isAcceptableOrUnknown(
              data['daily_carbs_goal']!, _dailyCarbsGoalMeta));
    }
    if (data.containsKey('daily_protein_goal')) {
      context.handle(
          _dailyProteinGoalMeta,
          dailyProteinGoal.isAcceptableOrUnknown(
              data['daily_protein_goal']!, _dailyProteinGoalMeta));
    }
    if (data.containsKey('daily_fat_goal')) {
      context.handle(
          _dailyFatGoalMeta,
          dailyFatGoal.isAcceptableOrUnknown(
              data['daily_fat_goal']!, _dailyFatGoalMeta));
    }
    if (data.containsKey('daily_fiber_goal')) {
      context.handle(
          _dailyFiberGoalMeta,
          dailyFiberGoal.isAcceptableOrUnknown(
              data['daily_fiber_goal']!, _dailyFiberGoalMeta));
    }
    if (data.containsKey('carbs_ratio')) {
      context.handle(
          _carbsRatioMeta,
          carbsRatio.isAcceptableOrUnknown(
              data['carbs_ratio']!, _carbsRatioMeta));
    }
    if (data.containsKey('protein_ratio')) {
      context.handle(
          _proteinRatioMeta,
          proteinRatio.isAcceptableOrUnknown(
              data['protein_ratio']!, _proteinRatioMeta));
    }
    if (data.containsKey('fat_ratio')) {
      context.handle(_fatRatioMeta,
          fatRatio.isAcceptableOrUnknown(data['fat_ratio']!, _fatRatioMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('activity_level')) {
      context.handle(
          _activityLevelMeta,
          activityLevel.isAcceptableOrUnknown(
              data['activity_level']!, _activityLevelMeta));
    }
    if (data.containsKey('goal')) {
      context.handle(
          _goalMeta, goal.isAcceptableOrUnknown(data['goal']!, _goalMeta));
    }
    if (data.containsKey('dietary_restrictions')) {
      context.handle(
          _dietaryRestrictionsMeta,
          dietaryRestrictions.isAcceptableOrUnknown(
              data['dietary_restrictions']!, _dietaryRestrictionsMeta));
    }
    if (data.containsKey('allergies')) {
      context.handle(_allergiesMeta,
          allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta));
    }
    if (data.containsKey('disliked_foods')) {
      context.handle(
          _dislikedFoodsMeta,
          dislikedFoods.isAcceptableOrUnknown(
              data['disliked_foods']!, _dislikedFoodsMeta));
    }
    if (data.containsKey('ai_suggestions_enabled')) {
      context.handle(
          _aiSuggestionsEnabledMeta,
          aiSuggestionsEnabled.isAcceptableOrUnknown(
              data['ai_suggestions_enabled']!, _aiSuggestionsEnabledMeta));
    }
    if (data.containsKey('ai_confidence_threshold')) {
      context.handle(
          _aiConfidenceThresholdMeta,
          aiConfidenceThreshold.isAcceptableOrUnknown(
              data['ai_confidence_threshold']!, _aiConfidenceThresholdMeta));
    }
    if (data.containsKey('auto_save_recognitions')) {
      context.handle(
          _autoSaveRecognitionsMeta,
          autoSaveRecognitions.isAcceptableOrUnknown(
              data['auto_save_recognitions']!, _autoSaveRecognitionsMeta));
    }
    if (data.containsKey('meal_reminders_enabled')) {
      context.handle(
          _mealRemindersEnabledMeta,
          mealRemindersEnabled.isAcceptableOrUnknown(
              data['meal_reminders_enabled']!, _mealRemindersEnabledMeta));
    }
    if (data.containsKey('breakfast_reminder_time')) {
      context.handle(
          _breakfastReminderTimeMeta,
          breakfastReminderTime.isAcceptableOrUnknown(
              data['breakfast_reminder_time']!, _breakfastReminderTimeMeta));
    }
    if (data.containsKey('lunch_reminder_time')) {
      context.handle(
          _lunchReminderTimeMeta,
          lunchReminderTime.isAcceptableOrUnknown(
              data['lunch_reminder_time']!, _lunchReminderTimeMeta));
    }
    if (data.containsKey('dinner_reminder_time')) {
      context.handle(
          _dinnerReminderTimeMeta,
          dinnerReminderTime.isAcceptableOrUnknown(
              data['dinner_reminder_time']!, _dinnerReminderTimeMeta));
    }
    if (data.containsKey('nutrition_goal_notifications')) {
      context.handle(
          _nutritionGoalNotificationsMeta,
          nutritionGoalNotifications.isAcceptableOrUnknown(
              data['nutrition_goal_notifications']!,
              _nutritionGoalNotificationsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      dailyCalorieGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}daily_calorie_goal'])!,
      dailyCarbsGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}daily_carbs_goal'])!,
      dailyProteinGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}daily_protein_goal'])!,
      dailyFatGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}daily_fat_goal'])!,
      dailyFiberGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}daily_fiber_goal'])!,
      carbsRatio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_ratio'])!,
      proteinRatio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_ratio'])!,
      fatRatio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_ratio'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      activityLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_level'])!,
      goal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal'])!,
      dietaryRestrictions: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}dietary_restrictions']),
      allergies: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}allergies']),
      dislikedFoods: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}disliked_foods']),
      aiSuggestionsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}ai_suggestions_enabled'])!,
      aiConfidenceThreshold: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}ai_confidence_threshold'])!,
      autoSaveRecognitions: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}auto_save_recognitions'])!,
      mealRemindersEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}meal_reminders_enabled'])!,
      breakfastReminderTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}breakfast_reminder_time']),
      lunchReminderTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}lunch_reminder_time']),
      dinnerReminderTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}dinner_reminder_time']),
      nutritionGoalNotifications: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}nutrition_goal_notifications'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final String userId;
  final double dailyCalorieGoal;
  final double dailyCarbsGoal;
  final double dailyProteinGoal;
  final double dailyFatGoal;
  final double dailyFiberGoal;
  final double carbsRatio;
  final double proteinRatio;
  final double fatRatio;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final String activityLevel;
  final String goal;
  final String? dietaryRestrictions;
  final String? allergies;
  final String? dislikedFoods;
  final bool aiSuggestionsEnabled;
  final double aiConfidenceThreshold;
  final bool autoSaveRecognitions;
  final bool mealRemindersEnabled;
  final String? breakfastReminderTime;
  final String? lunchReminderTime;
  final String? dinnerReminderTime;
  final bool nutritionGoalNotifications;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserPreference(
      {required this.userId,
      required this.dailyCalorieGoal,
      required this.dailyCarbsGoal,
      required this.dailyProteinGoal,
      required this.dailyFatGoal,
      required this.dailyFiberGoal,
      required this.carbsRatio,
      required this.proteinRatio,
      required this.fatRatio,
      this.age,
      this.gender,
      this.height,
      this.weight,
      required this.activityLevel,
      required this.goal,
      this.dietaryRestrictions,
      this.allergies,
      this.dislikedFoods,
      required this.aiSuggestionsEnabled,
      required this.aiConfidenceThreshold,
      required this.autoSaveRecognitions,
      required this.mealRemindersEnabled,
      this.breakfastReminderTime,
      this.lunchReminderTime,
      this.dinnerReminderTime,
      required this.nutritionGoalNotifications,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['daily_calorie_goal'] = Variable<double>(dailyCalorieGoal);
    map['daily_carbs_goal'] = Variable<double>(dailyCarbsGoal);
    map['daily_protein_goal'] = Variable<double>(dailyProteinGoal);
    map['daily_fat_goal'] = Variable<double>(dailyFatGoal);
    map['daily_fiber_goal'] = Variable<double>(dailyFiberGoal);
    map['carbs_ratio'] = Variable<double>(carbsRatio);
    map['protein_ratio'] = Variable<double>(proteinRatio);
    map['fat_ratio'] = Variable<double>(fatRatio);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    map['activity_level'] = Variable<String>(activityLevel);
    map['goal'] = Variable<String>(goal);
    if (!nullToAbsent || dietaryRestrictions != null) {
      map['dietary_restrictions'] = Variable<String>(dietaryRestrictions);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || dislikedFoods != null) {
      map['disliked_foods'] = Variable<String>(dislikedFoods);
    }
    map['ai_suggestions_enabled'] = Variable<bool>(aiSuggestionsEnabled);
    map['ai_confidence_threshold'] = Variable<double>(aiConfidenceThreshold);
    map['auto_save_recognitions'] = Variable<bool>(autoSaveRecognitions);
    map['meal_reminders_enabled'] = Variable<bool>(mealRemindersEnabled);
    if (!nullToAbsent || breakfastReminderTime != null) {
      map['breakfast_reminder_time'] = Variable<String>(breakfastReminderTime);
    }
    if (!nullToAbsent || lunchReminderTime != null) {
      map['lunch_reminder_time'] = Variable<String>(lunchReminderTime);
    }
    if (!nullToAbsent || dinnerReminderTime != null) {
      map['dinner_reminder_time'] = Variable<String>(dinnerReminderTime);
    }
    map['nutrition_goal_notifications'] =
        Variable<bool>(nutritionGoalNotifications);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      userId: Value(userId),
      dailyCalorieGoal: Value(dailyCalorieGoal),
      dailyCarbsGoal: Value(dailyCarbsGoal),
      dailyProteinGoal: Value(dailyProteinGoal),
      dailyFatGoal: Value(dailyFatGoal),
      dailyFiberGoal: Value(dailyFiberGoal),
      carbsRatio: Value(carbsRatio),
      proteinRatio: Value(proteinRatio),
      fatRatio: Value(fatRatio),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      activityLevel: Value(activityLevel),
      goal: Value(goal),
      dietaryRestrictions: dietaryRestrictions == null && nullToAbsent
          ? const Value.absent()
          : Value(dietaryRestrictions),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      dislikedFoods: dislikedFoods == null && nullToAbsent
          ? const Value.absent()
          : Value(dislikedFoods),
      aiSuggestionsEnabled: Value(aiSuggestionsEnabled),
      aiConfidenceThreshold: Value(aiConfidenceThreshold),
      autoSaveRecognitions: Value(autoSaveRecognitions),
      mealRemindersEnabled: Value(mealRemindersEnabled),
      breakfastReminderTime: breakfastReminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(breakfastReminderTime),
      lunchReminderTime: lunchReminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lunchReminderTime),
      dinnerReminderTime: dinnerReminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(dinnerReminderTime),
      nutritionGoalNotifications: Value(nutritionGoalNotifications),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      userId: serializer.fromJson<String>(json['userId']),
      dailyCalorieGoal: serializer.fromJson<double>(json['dailyCalorieGoal']),
      dailyCarbsGoal: serializer.fromJson<double>(json['dailyCarbsGoal']),
      dailyProteinGoal: serializer.fromJson<double>(json['dailyProteinGoal']),
      dailyFatGoal: serializer.fromJson<double>(json['dailyFatGoal']),
      dailyFiberGoal: serializer.fromJson<double>(json['dailyFiberGoal']),
      carbsRatio: serializer.fromJson<double>(json['carbsRatio']),
      proteinRatio: serializer.fromJson<double>(json['proteinRatio']),
      fatRatio: serializer.fromJson<double>(json['fatRatio']),
      age: serializer.fromJson<int?>(json['age']),
      gender: serializer.fromJson<String?>(json['gender']),
      height: serializer.fromJson<double?>(json['height']),
      weight: serializer.fromJson<double?>(json['weight']),
      activityLevel: serializer.fromJson<String>(json['activityLevel']),
      goal: serializer.fromJson<String>(json['goal']),
      dietaryRestrictions:
          serializer.fromJson<String?>(json['dietaryRestrictions']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      dislikedFoods: serializer.fromJson<String?>(json['dislikedFoods']),
      aiSuggestionsEnabled:
          serializer.fromJson<bool>(json['aiSuggestionsEnabled']),
      aiConfidenceThreshold:
          serializer.fromJson<double>(json['aiConfidenceThreshold']),
      autoSaveRecognitions:
          serializer.fromJson<bool>(json['autoSaveRecognitions']),
      mealRemindersEnabled:
          serializer.fromJson<bool>(json['mealRemindersEnabled']),
      breakfastReminderTime:
          serializer.fromJson<String?>(json['breakfastReminderTime']),
      lunchReminderTime:
          serializer.fromJson<String?>(json['lunchReminderTime']),
      dinnerReminderTime:
          serializer.fromJson<String?>(json['dinnerReminderTime']),
      nutritionGoalNotifications:
          serializer.fromJson<bool>(json['nutritionGoalNotifications']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'dailyCalorieGoal': serializer.toJson<double>(dailyCalorieGoal),
      'dailyCarbsGoal': serializer.toJson<double>(dailyCarbsGoal),
      'dailyProteinGoal': serializer.toJson<double>(dailyProteinGoal),
      'dailyFatGoal': serializer.toJson<double>(dailyFatGoal),
      'dailyFiberGoal': serializer.toJson<double>(dailyFiberGoal),
      'carbsRatio': serializer.toJson<double>(carbsRatio),
      'proteinRatio': serializer.toJson<double>(proteinRatio),
      'fatRatio': serializer.toJson<double>(fatRatio),
      'age': serializer.toJson<int?>(age),
      'gender': serializer.toJson<String?>(gender),
      'height': serializer.toJson<double?>(height),
      'weight': serializer.toJson<double?>(weight),
      'activityLevel': serializer.toJson<String>(activityLevel),
      'goal': serializer.toJson<String>(goal),
      'dietaryRestrictions': serializer.toJson<String?>(dietaryRestrictions),
      'allergies': serializer.toJson<String?>(allergies),
      'dislikedFoods': serializer.toJson<String?>(dislikedFoods),
      'aiSuggestionsEnabled': serializer.toJson<bool>(aiSuggestionsEnabled),
      'aiConfidenceThreshold': serializer.toJson<double>(aiConfidenceThreshold),
      'autoSaveRecognitions': serializer.toJson<bool>(autoSaveRecognitions),
      'mealRemindersEnabled': serializer.toJson<bool>(mealRemindersEnabled),
      'breakfastReminderTime':
          serializer.toJson<String?>(breakfastReminderTime),
      'lunchReminderTime': serializer.toJson<String?>(lunchReminderTime),
      'dinnerReminderTime': serializer.toJson<String?>(dinnerReminderTime),
      'nutritionGoalNotifications':
          serializer.toJson<bool>(nutritionGoalNotifications),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreference copyWith(
          {String? userId,
          double? dailyCalorieGoal,
          double? dailyCarbsGoal,
          double? dailyProteinGoal,
          double? dailyFatGoal,
          double? dailyFiberGoal,
          double? carbsRatio,
          double? proteinRatio,
          double? fatRatio,
          Value<int?> age = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<double?> height = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          String? activityLevel,
          String? goal,
          Value<String?> dietaryRestrictions = const Value.absent(),
          Value<String?> allergies = const Value.absent(),
          Value<String?> dislikedFoods = const Value.absent(),
          bool? aiSuggestionsEnabled,
          double? aiConfidenceThreshold,
          bool? autoSaveRecognitions,
          bool? mealRemindersEnabled,
          Value<String?> breakfastReminderTime = const Value.absent(),
          Value<String?> lunchReminderTime = const Value.absent(),
          Value<String?> dinnerReminderTime = const Value.absent(),
          bool? nutritionGoalNotifications,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserPreference(
        userId: userId ?? this.userId,
        dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
        dailyCarbsGoal: dailyCarbsGoal ?? this.dailyCarbsGoal,
        dailyProteinGoal: dailyProteinGoal ?? this.dailyProteinGoal,
        dailyFatGoal: dailyFatGoal ?? this.dailyFatGoal,
        dailyFiberGoal: dailyFiberGoal ?? this.dailyFiberGoal,
        carbsRatio: carbsRatio ?? this.carbsRatio,
        proteinRatio: proteinRatio ?? this.proteinRatio,
        fatRatio: fatRatio ?? this.fatRatio,
        age: age.present ? age.value : this.age,
        gender: gender.present ? gender.value : this.gender,
        height: height.present ? height.value : this.height,
        weight: weight.present ? weight.value : this.weight,
        activityLevel: activityLevel ?? this.activityLevel,
        goal: goal ?? this.goal,
        dietaryRestrictions: dietaryRestrictions.present
            ? dietaryRestrictions.value
            : this.dietaryRestrictions,
        allergies: allergies.present ? allergies.value : this.allergies,
        dislikedFoods:
            dislikedFoods.present ? dislikedFoods.value : this.dislikedFoods,
        aiSuggestionsEnabled: aiSuggestionsEnabled ?? this.aiSuggestionsEnabled,
        aiConfidenceThreshold:
            aiConfidenceThreshold ?? this.aiConfidenceThreshold,
        autoSaveRecognitions: autoSaveRecognitions ?? this.autoSaveRecognitions,
        mealRemindersEnabled: mealRemindersEnabled ?? this.mealRemindersEnabled,
        breakfastReminderTime: breakfastReminderTime.present
            ? breakfastReminderTime.value
            : this.breakfastReminderTime,
        lunchReminderTime: lunchReminderTime.present
            ? lunchReminderTime.value
            : this.lunchReminderTime,
        dinnerReminderTime: dinnerReminderTime.present
            ? dinnerReminderTime.value
            : this.dinnerReminderTime,
        nutritionGoalNotifications:
            nutritionGoalNotifications ?? this.nutritionGoalNotifications,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      userId: data.userId.present ? data.userId.value : this.userId,
      dailyCalorieGoal: data.dailyCalorieGoal.present
          ? data.dailyCalorieGoal.value
          : this.dailyCalorieGoal,
      dailyCarbsGoal: data.dailyCarbsGoal.present
          ? data.dailyCarbsGoal.value
          : this.dailyCarbsGoal,
      dailyProteinGoal: data.dailyProteinGoal.present
          ? data.dailyProteinGoal.value
          : this.dailyProteinGoal,
      dailyFatGoal: data.dailyFatGoal.present
          ? data.dailyFatGoal.value
          : this.dailyFatGoal,
      dailyFiberGoal: data.dailyFiberGoal.present
          ? data.dailyFiberGoal.value
          : this.dailyFiberGoal,
      carbsRatio:
          data.carbsRatio.present ? data.carbsRatio.value : this.carbsRatio,
      proteinRatio: data.proteinRatio.present
          ? data.proteinRatio.value
          : this.proteinRatio,
      fatRatio: data.fatRatio.present ? data.fatRatio.value : this.fatRatio,
      age: data.age.present ? data.age.value : this.age,
      gender: data.gender.present ? data.gender.value : this.gender,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      goal: data.goal.present ? data.goal.value : this.goal,
      dietaryRestrictions: data.dietaryRestrictions.present
          ? data.dietaryRestrictions.value
          : this.dietaryRestrictions,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      dislikedFoods: data.dislikedFoods.present
          ? data.dislikedFoods.value
          : this.dislikedFoods,
      aiSuggestionsEnabled: data.aiSuggestionsEnabled.present
          ? data.aiSuggestionsEnabled.value
          : this.aiSuggestionsEnabled,
      aiConfidenceThreshold: data.aiConfidenceThreshold.present
          ? data.aiConfidenceThreshold.value
          : this.aiConfidenceThreshold,
      autoSaveRecognitions: data.autoSaveRecognitions.present
          ? data.autoSaveRecognitions.value
          : this.autoSaveRecognitions,
      mealRemindersEnabled: data.mealRemindersEnabled.present
          ? data.mealRemindersEnabled.value
          : this.mealRemindersEnabled,
      breakfastReminderTime: data.breakfastReminderTime.present
          ? data.breakfastReminderTime.value
          : this.breakfastReminderTime,
      lunchReminderTime: data.lunchReminderTime.present
          ? data.lunchReminderTime.value
          : this.lunchReminderTime,
      dinnerReminderTime: data.dinnerReminderTime.present
          ? data.dinnerReminderTime.value
          : this.dinnerReminderTime,
      nutritionGoalNotifications: data.nutritionGoalNotifications.present
          ? data.nutritionGoalNotifications.value
          : this.nutritionGoalNotifications,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('userId: $userId, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('dailyCarbsGoal: $dailyCarbsGoal, ')
          ..write('dailyProteinGoal: $dailyProteinGoal, ')
          ..write('dailyFatGoal: $dailyFatGoal, ')
          ..write('dailyFiberGoal: $dailyFiberGoal, ')
          ..write('carbsRatio: $carbsRatio, ')
          ..write('proteinRatio: $proteinRatio, ')
          ..write('fatRatio: $fatRatio, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goal: $goal, ')
          ..write('dietaryRestrictions: $dietaryRestrictions, ')
          ..write('allergies: $allergies, ')
          ..write('dislikedFoods: $dislikedFoods, ')
          ..write('aiSuggestionsEnabled: $aiSuggestionsEnabled, ')
          ..write('aiConfidenceThreshold: $aiConfidenceThreshold, ')
          ..write('autoSaveRecognitions: $autoSaveRecognitions, ')
          ..write('mealRemindersEnabled: $mealRemindersEnabled, ')
          ..write('breakfastReminderTime: $breakfastReminderTime, ')
          ..write('lunchReminderTime: $lunchReminderTime, ')
          ..write('dinnerReminderTime: $dinnerReminderTime, ')
          ..write('nutritionGoalNotifications: $nutritionGoalNotifications, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        userId,
        dailyCalorieGoal,
        dailyCarbsGoal,
        dailyProteinGoal,
        dailyFatGoal,
        dailyFiberGoal,
        carbsRatio,
        proteinRatio,
        fatRatio,
        age,
        gender,
        height,
        weight,
        activityLevel,
        goal,
        dietaryRestrictions,
        allergies,
        dislikedFoods,
        aiSuggestionsEnabled,
        aiConfidenceThreshold,
        autoSaveRecognitions,
        mealRemindersEnabled,
        breakfastReminderTime,
        lunchReminderTime,
        dinnerReminderTime,
        nutritionGoalNotifications,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.userId == this.userId &&
          other.dailyCalorieGoal == this.dailyCalorieGoal &&
          other.dailyCarbsGoal == this.dailyCarbsGoal &&
          other.dailyProteinGoal == this.dailyProteinGoal &&
          other.dailyFatGoal == this.dailyFatGoal &&
          other.dailyFiberGoal == this.dailyFiberGoal &&
          other.carbsRatio == this.carbsRatio &&
          other.proteinRatio == this.proteinRatio &&
          other.fatRatio == this.fatRatio &&
          other.age == this.age &&
          other.gender == this.gender &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.activityLevel == this.activityLevel &&
          other.goal == this.goal &&
          other.dietaryRestrictions == this.dietaryRestrictions &&
          other.allergies == this.allergies &&
          other.dislikedFoods == this.dislikedFoods &&
          other.aiSuggestionsEnabled == this.aiSuggestionsEnabled &&
          other.aiConfidenceThreshold == this.aiConfidenceThreshold &&
          other.autoSaveRecognitions == this.autoSaveRecognitions &&
          other.mealRemindersEnabled == this.mealRemindersEnabled &&
          other.breakfastReminderTime == this.breakfastReminderTime &&
          other.lunchReminderTime == this.lunchReminderTime &&
          other.dinnerReminderTime == this.dinnerReminderTime &&
          other.nutritionGoalNotifications == this.nutritionGoalNotifications &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<String> userId;
  final Value<double> dailyCalorieGoal;
  final Value<double> dailyCarbsGoal;
  final Value<double> dailyProteinGoal;
  final Value<double> dailyFatGoal;
  final Value<double> dailyFiberGoal;
  final Value<double> carbsRatio;
  final Value<double> proteinRatio;
  final Value<double> fatRatio;
  final Value<int?> age;
  final Value<String?> gender;
  final Value<double?> height;
  final Value<double?> weight;
  final Value<String> activityLevel;
  final Value<String> goal;
  final Value<String?> dietaryRestrictions;
  final Value<String?> allergies;
  final Value<String?> dislikedFoods;
  final Value<bool> aiSuggestionsEnabled;
  final Value<double> aiConfidenceThreshold;
  final Value<bool> autoSaveRecognitions;
  final Value<bool> mealRemindersEnabled;
  final Value<String?> breakfastReminderTime;
  final Value<String?> lunchReminderTime;
  final Value<String?> dinnerReminderTime;
  final Value<bool> nutritionGoalNotifications;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserPreferencesCompanion({
    this.userId = const Value.absent(),
    this.dailyCalorieGoal = const Value.absent(),
    this.dailyCarbsGoal = const Value.absent(),
    this.dailyProteinGoal = const Value.absent(),
    this.dailyFatGoal = const Value.absent(),
    this.dailyFiberGoal = const Value.absent(),
    this.carbsRatio = const Value.absent(),
    this.proteinRatio = const Value.absent(),
    this.fatRatio = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.goal = const Value.absent(),
    this.dietaryRestrictions = const Value.absent(),
    this.allergies = const Value.absent(),
    this.dislikedFoods = const Value.absent(),
    this.aiSuggestionsEnabled = const Value.absent(),
    this.aiConfidenceThreshold = const Value.absent(),
    this.autoSaveRecognitions = const Value.absent(),
    this.mealRemindersEnabled = const Value.absent(),
    this.breakfastReminderTime = const Value.absent(),
    this.lunchReminderTime = const Value.absent(),
    this.dinnerReminderTime = const Value.absent(),
    this.nutritionGoalNotifications = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    required String userId,
    this.dailyCalorieGoal = const Value.absent(),
    this.dailyCarbsGoal = const Value.absent(),
    this.dailyProteinGoal = const Value.absent(),
    this.dailyFatGoal = const Value.absent(),
    this.dailyFiberGoal = const Value.absent(),
    this.carbsRatio = const Value.absent(),
    this.proteinRatio = const Value.absent(),
    this.fatRatio = const Value.absent(),
    this.age = const Value.absent(),
    this.gender = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.goal = const Value.absent(),
    this.dietaryRestrictions = const Value.absent(),
    this.allergies = const Value.absent(),
    this.dislikedFoods = const Value.absent(),
    this.aiSuggestionsEnabled = const Value.absent(),
    this.aiConfidenceThreshold = const Value.absent(),
    this.autoSaveRecognitions = const Value.absent(),
    this.mealRemindersEnabled = const Value.absent(),
    this.breakfastReminderTime = const Value.absent(),
    this.lunchReminderTime = const Value.absent(),
    this.dinnerReminderTime = const Value.absent(),
    this.nutritionGoalNotifications = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<UserPreference> custom({
    Expression<String>? userId,
    Expression<double>? dailyCalorieGoal,
    Expression<double>? dailyCarbsGoal,
    Expression<double>? dailyProteinGoal,
    Expression<double>? dailyFatGoal,
    Expression<double>? dailyFiberGoal,
    Expression<double>? carbsRatio,
    Expression<double>? proteinRatio,
    Expression<double>? fatRatio,
    Expression<int>? age,
    Expression<String>? gender,
    Expression<double>? height,
    Expression<double>? weight,
    Expression<String>? activityLevel,
    Expression<String>? goal,
    Expression<String>? dietaryRestrictions,
    Expression<String>? allergies,
    Expression<String>? dislikedFoods,
    Expression<bool>? aiSuggestionsEnabled,
    Expression<double>? aiConfidenceThreshold,
    Expression<bool>? autoSaveRecognitions,
    Expression<bool>? mealRemindersEnabled,
    Expression<String>? breakfastReminderTime,
    Expression<String>? lunchReminderTime,
    Expression<String>? dinnerReminderTime,
    Expression<bool>? nutritionGoalNotifications,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (dailyCalorieGoal != null) 'daily_calorie_goal': dailyCalorieGoal,
      if (dailyCarbsGoal != null) 'daily_carbs_goal': dailyCarbsGoal,
      if (dailyProteinGoal != null) 'daily_protein_goal': dailyProteinGoal,
      if (dailyFatGoal != null) 'daily_fat_goal': dailyFatGoal,
      if (dailyFiberGoal != null) 'daily_fiber_goal': dailyFiberGoal,
      if (carbsRatio != null) 'carbs_ratio': carbsRatio,
      if (proteinRatio != null) 'protein_ratio': proteinRatio,
      if (fatRatio != null) 'fat_ratio': fatRatio,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (goal != null) 'goal': goal,
      if (dietaryRestrictions != null)
        'dietary_restrictions': dietaryRestrictions,
      if (allergies != null) 'allergies': allergies,
      if (dislikedFoods != null) 'disliked_foods': dislikedFoods,
      if (aiSuggestionsEnabled != null)
        'ai_suggestions_enabled': aiSuggestionsEnabled,
      if (aiConfidenceThreshold != null)
        'ai_confidence_threshold': aiConfidenceThreshold,
      if (autoSaveRecognitions != null)
        'auto_save_recognitions': autoSaveRecognitions,
      if (mealRemindersEnabled != null)
        'meal_reminders_enabled': mealRemindersEnabled,
      if (breakfastReminderTime != null)
        'breakfast_reminder_time': breakfastReminderTime,
      if (lunchReminderTime != null) 'lunch_reminder_time': lunchReminderTime,
      if (dinnerReminderTime != null)
        'dinner_reminder_time': dinnerReminderTime,
      if (nutritionGoalNotifications != null)
        'nutrition_goal_notifications': nutritionGoalNotifications,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPreferencesCompanion copyWith(
      {Value<String>? userId,
      Value<double>? dailyCalorieGoal,
      Value<double>? dailyCarbsGoal,
      Value<double>? dailyProteinGoal,
      Value<double>? dailyFatGoal,
      Value<double>? dailyFiberGoal,
      Value<double>? carbsRatio,
      Value<double>? proteinRatio,
      Value<double>? fatRatio,
      Value<int?>? age,
      Value<String?>? gender,
      Value<double?>? height,
      Value<double?>? weight,
      Value<String>? activityLevel,
      Value<String>? goal,
      Value<String?>? dietaryRestrictions,
      Value<String?>? allergies,
      Value<String?>? dislikedFoods,
      Value<bool>? aiSuggestionsEnabled,
      Value<double>? aiConfidenceThreshold,
      Value<bool>? autoSaveRecognitions,
      Value<bool>? mealRemindersEnabled,
      Value<String?>? breakfastReminderTime,
      Value<String?>? lunchReminderTime,
      Value<String?>? dinnerReminderTime,
      Value<bool>? nutritionGoalNotifications,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return UserPreferencesCompanion(
      userId: userId ?? this.userId,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      dailyCarbsGoal: dailyCarbsGoal ?? this.dailyCarbsGoal,
      dailyProteinGoal: dailyProteinGoal ?? this.dailyProteinGoal,
      dailyFatGoal: dailyFatGoal ?? this.dailyFatGoal,
      dailyFiberGoal: dailyFiberGoal ?? this.dailyFiberGoal,
      carbsRatio: carbsRatio ?? this.carbsRatio,
      proteinRatio: proteinRatio ?? this.proteinRatio,
      fatRatio: fatRatio ?? this.fatRatio,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      allergies: allergies ?? this.allergies,
      dislikedFoods: dislikedFoods ?? this.dislikedFoods,
      aiSuggestionsEnabled: aiSuggestionsEnabled ?? this.aiSuggestionsEnabled,
      aiConfidenceThreshold:
          aiConfidenceThreshold ?? this.aiConfidenceThreshold,
      autoSaveRecognitions: autoSaveRecognitions ?? this.autoSaveRecognitions,
      mealRemindersEnabled: mealRemindersEnabled ?? this.mealRemindersEnabled,
      breakfastReminderTime:
          breakfastReminderTime ?? this.breakfastReminderTime,
      lunchReminderTime: lunchReminderTime ?? this.lunchReminderTime,
      dinnerReminderTime: dinnerReminderTime ?? this.dinnerReminderTime,
      nutritionGoalNotifications:
          nutritionGoalNotifications ?? this.nutritionGoalNotifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (dailyCalorieGoal.present) {
      map['daily_calorie_goal'] = Variable<double>(dailyCalorieGoal.value);
    }
    if (dailyCarbsGoal.present) {
      map['daily_carbs_goal'] = Variable<double>(dailyCarbsGoal.value);
    }
    if (dailyProteinGoal.present) {
      map['daily_protein_goal'] = Variable<double>(dailyProteinGoal.value);
    }
    if (dailyFatGoal.present) {
      map['daily_fat_goal'] = Variable<double>(dailyFatGoal.value);
    }
    if (dailyFiberGoal.present) {
      map['daily_fiber_goal'] = Variable<double>(dailyFiberGoal.value);
    }
    if (carbsRatio.present) {
      map['carbs_ratio'] = Variable<double>(carbsRatio.value);
    }
    if (proteinRatio.present) {
      map['protein_ratio'] = Variable<double>(proteinRatio.value);
    }
    if (fatRatio.present) {
      map['fat_ratio'] = Variable<double>(fatRatio.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<String>(activityLevel.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (dietaryRestrictions.present) {
      map['dietary_restrictions'] = Variable<String>(dietaryRestrictions.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (dislikedFoods.present) {
      map['disliked_foods'] = Variable<String>(dislikedFoods.value);
    }
    if (aiSuggestionsEnabled.present) {
      map['ai_suggestions_enabled'] =
          Variable<bool>(aiSuggestionsEnabled.value);
    }
    if (aiConfidenceThreshold.present) {
      map['ai_confidence_threshold'] =
          Variable<double>(aiConfidenceThreshold.value);
    }
    if (autoSaveRecognitions.present) {
      map['auto_save_recognitions'] =
          Variable<bool>(autoSaveRecognitions.value);
    }
    if (mealRemindersEnabled.present) {
      map['meal_reminders_enabled'] =
          Variable<bool>(mealRemindersEnabled.value);
    }
    if (breakfastReminderTime.present) {
      map['breakfast_reminder_time'] =
          Variable<String>(breakfastReminderTime.value);
    }
    if (lunchReminderTime.present) {
      map['lunch_reminder_time'] = Variable<String>(lunchReminderTime.value);
    }
    if (dinnerReminderTime.present) {
      map['dinner_reminder_time'] = Variable<String>(dinnerReminderTime.value);
    }
    if (nutritionGoalNotifications.present) {
      map['nutrition_goal_notifications'] =
          Variable<bool>(nutritionGoalNotifications.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('userId: $userId, ')
          ..write('dailyCalorieGoal: $dailyCalorieGoal, ')
          ..write('dailyCarbsGoal: $dailyCarbsGoal, ')
          ..write('dailyProteinGoal: $dailyProteinGoal, ')
          ..write('dailyFatGoal: $dailyFatGoal, ')
          ..write('dailyFiberGoal: $dailyFiberGoal, ')
          ..write('carbsRatio: $carbsRatio, ')
          ..write('proteinRatio: $proteinRatio, ')
          ..write('fatRatio: $fatRatio, ')
          ..write('age: $age, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goal: $goal, ')
          ..write('dietaryRestrictions: $dietaryRestrictions, ')
          ..write('allergies: $allergies, ')
          ..write('dislikedFoods: $dislikedFoods, ')
          ..write('aiSuggestionsEnabled: $aiSuggestionsEnabled, ')
          ..write('aiConfidenceThreshold: $aiConfidenceThreshold, ')
          ..write('autoSaveRecognitions: $autoSaveRecognitions, ')
          ..write('mealRemindersEnabled: $mealRemindersEnabled, ')
          ..write('breakfastReminderTime: $breakfastReminderTime, ')
          ..write('lunchReminderTime: $lunchReminderTime, ')
          ..write('dinnerReminderTime: $dinnerReminderTime, ')
          ..write('nutritionGoalNotifications: $nutritionGoalNotifications, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomFoodsTable extends CustomFoods
    with TableInfo<$CustomFoodsTable, CustomFood> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomFoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 300),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _kcalPer100gMeta =
      const VerificationMeta('kcalPer100g');
  @override
  late final GeneratedColumn<double> kcalPer100g = GeneratedColumn<double>(
      'kcal_per100g', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbsPer100gMeta =
      const VerificationMeta('carbsPer100g');
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
      'carbs_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _proteinPer100gMeta =
      const VerificationMeta('proteinPer100g');
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
      'protein_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fatPer100gMeta =
      const VerificationMeta('fatPer100g');
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
      'fat_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fiberPer100gMeta =
      const VerificationMeta('fiberPer100g');
  @override
  late final GeneratedColumn<double> fiberPer100g = GeneratedColumn<double>(
      'fiber_per100g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _recipeMeta = const VerificationMeta('recipe');
  @override
  late final GeneratedColumn<String> recipe = GeneratedColumn<String>(
      'recipe', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ingredientsMeta =
      const VerificationMeta('ingredients');
  @override
  late final GeneratedColumn<String> ingredients = GeneratedColumn<String>(
      'ingredients', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usageCountMeta =
      const VerificationMeta('usageCount');
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
      'usage_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastUsedAtMeta =
      const VerificationMeta('lastUsedAt');
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
      'last_used_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        description,
        kcalPer100g,
        carbsPer100g,
        proteinPer100g,
        fatPer100g,
        fiberPer100g,
        recipe,
        ingredients,
        usageCount,
        lastUsedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_foods';
  @override
  VerificationContext validateIntegrity(Insertable<CustomFood> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('kcal_per100g')) {
      context.handle(
          _kcalPer100gMeta,
          kcalPer100g.isAcceptableOrUnknown(
              data['kcal_per100g']!, _kcalPer100gMeta));
    } else if (isInserting) {
      context.missing(_kcalPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
          _carbsPer100gMeta,
          carbsPer100g.isAcceptableOrUnknown(
              data['carbs_per100g']!, _carbsPer100gMeta));
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
          _proteinPer100gMeta,
          proteinPer100g.isAcceptableOrUnknown(
              data['protein_per100g']!, _proteinPer100gMeta));
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
          _fatPer100gMeta,
          fatPer100g.isAcceptableOrUnknown(
              data['fat_per100g']!, _fatPer100gMeta));
    }
    if (data.containsKey('fiber_per100g')) {
      context.handle(
          _fiberPer100gMeta,
          fiberPer100g.isAcceptableOrUnknown(
              data['fiber_per100g']!, _fiberPer100gMeta));
    }
    if (data.containsKey('recipe')) {
      context.handle(_recipeMeta,
          recipe.isAcceptableOrUnknown(data['recipe']!, _recipeMeta));
    }
    if (data.containsKey('ingredients')) {
      context.handle(
          _ingredientsMeta,
          ingredients.isAcceptableOrUnknown(
              data['ingredients']!, _ingredientsMeta));
    }
    if (data.containsKey('usage_count')) {
      context.handle(
          _usageCountMeta,
          usageCount.isAcceptableOrUnknown(
              data['usage_count']!, _usageCountMeta));
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
          _lastUsedAtMeta,
          lastUsedAt.isAcceptableOrUnknown(
              data['last_used_at']!, _lastUsedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomFood map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomFood(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      kcalPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}kcal_per100g'])!,
      carbsPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_per100g'])!,
      proteinPer100g: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}protein_per100g'])!,
      fatPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_per100g'])!,
      fiberPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fiber_per100g'])!,
      recipe: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recipe']),
      ingredients: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ingredients']),
      usageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usage_count'])!,
      lastUsedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_used_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CustomFoodsTable createAlias(String alias) {
    return $CustomFoodsTable(attachedDatabase, alias);
  }
}

class CustomFood extends DataClass implements Insertable<CustomFood> {
  final int id;
  final String userId;
  final String name;
  final String? description;
  final double kcalPer100g;
  final double carbsPer100g;
  final double proteinPer100g;
  final double fatPer100g;
  final double fiberPer100g;
  final String? recipe;
  final String? ingredients;
  final int usageCount;
  final DateTime? lastUsedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CustomFood(
      {required this.id,
      required this.userId,
      required this.name,
      this.description,
      required this.kcalPer100g,
      required this.carbsPer100g,
      required this.proteinPer100g,
      required this.fatPer100g,
      required this.fiberPer100g,
      this.recipe,
      this.ingredients,
      required this.usageCount,
      this.lastUsedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['kcal_per100g'] = Variable<double>(kcalPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    map['fiber_per100g'] = Variable<double>(fiberPer100g);
    if (!nullToAbsent || recipe != null) {
      map['recipe'] = Variable<String>(recipe);
    }
    if (!nullToAbsent || ingredients != null) {
      map['ingredients'] = Variable<String>(ingredients);
    }
    map['usage_count'] = Variable<int>(usageCount);
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomFoodsCompanion toCompanion(bool nullToAbsent) {
    return CustomFoodsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      kcalPer100g: Value(kcalPer100g),
      carbsPer100g: Value(carbsPer100g),
      proteinPer100g: Value(proteinPer100g),
      fatPer100g: Value(fatPer100g),
      fiberPer100g: Value(fiberPer100g),
      recipe:
          recipe == null && nullToAbsent ? const Value.absent() : Value(recipe),
      ingredients: ingredients == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredients),
      usageCount: Value(usageCount),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomFood.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomFood(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      kcalPer100g: serializer.fromJson<double>(json['kcalPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      fiberPer100g: serializer.fromJson<double>(json['fiberPer100g']),
      recipe: serializer.fromJson<String?>(json['recipe']),
      ingredients: serializer.fromJson<String?>(json['ingredients']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'kcalPer100g': serializer.toJson<double>(kcalPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'fiberPer100g': serializer.toJson<double>(fiberPer100g),
      'recipe': serializer.toJson<String?>(recipe),
      'ingredients': serializer.toJson<String?>(ingredients),
      'usageCount': serializer.toJson<int>(usageCount),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomFood copyWith(
          {int? id,
          String? userId,
          String? name,
          Value<String?> description = const Value.absent(),
          double? kcalPer100g,
          double? carbsPer100g,
          double? proteinPer100g,
          double? fatPer100g,
          double? fiberPer100g,
          Value<String?> recipe = const Value.absent(),
          Value<String?> ingredients = const Value.absent(),
          int? usageCount,
          Value<DateTime?> lastUsedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CustomFood(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        kcalPer100g: kcalPer100g ?? this.kcalPer100g,
        carbsPer100g: carbsPer100g ?? this.carbsPer100g,
        proteinPer100g: proteinPer100g ?? this.proteinPer100g,
        fatPer100g: fatPer100g ?? this.fatPer100g,
        fiberPer100g: fiberPer100g ?? this.fiberPer100g,
        recipe: recipe.present ? recipe.value : this.recipe,
        ingredients: ingredients.present ? ingredients.value : this.ingredients,
        usageCount: usageCount ?? this.usageCount,
        lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CustomFood copyWithCompanion(CustomFoodsCompanion data) {
    return CustomFood(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      kcalPer100g:
          data.kcalPer100g.present ? data.kcalPer100g.value : this.kcalPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      fatPer100g:
          data.fatPer100g.present ? data.fatPer100g.value : this.fatPer100g,
      fiberPer100g: data.fiberPer100g.present
          ? data.fiberPer100g.value
          : this.fiberPer100g,
      recipe: data.recipe.present ? data.recipe.value : this.recipe,
      ingredients:
          data.ingredients.present ? data.ingredients.value : this.ingredients,
      usageCount:
          data.usageCount.present ? data.usageCount.value : this.usageCount,
      lastUsedAt:
          data.lastUsedAt.present ? data.lastUsedAt.value : this.lastUsedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomFood(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fiberPer100g: $fiberPer100g, ')
          ..write('recipe: $recipe, ')
          ..write('ingredients: $ingredients, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      name,
      description,
      kcalPer100g,
      carbsPer100g,
      proteinPer100g,
      fatPer100g,
      fiberPer100g,
      recipe,
      ingredients,
      usageCount,
      lastUsedAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomFood &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.kcalPer100g == this.kcalPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.fiberPer100g == this.fiberPer100g &&
          other.recipe == this.recipe &&
          other.ingredients == this.ingredients &&
          other.usageCount == this.usageCount &&
          other.lastUsedAt == this.lastUsedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomFoodsCompanion extends UpdateCompanion<CustomFood> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> kcalPer100g;
  final Value<double> carbsPer100g;
  final Value<double> proteinPer100g;
  final Value<double> fatPer100g;
  final Value<double> fiberPer100g;
  final Value<String?> recipe;
  final Value<String?> ingredients;
  final Value<int> usageCount;
  final Value<DateTime?> lastUsedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CustomFoodsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.fiberPer100g = const Value.absent(),
    this.recipe = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CustomFoodsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    this.description = const Value.absent(),
    required double kcalPer100g,
    this.carbsPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.fiberPer100g = const Value.absent(),
    this.recipe = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        name = Value(name),
        kcalPer100g = Value(kcalPer100g);
  static Insertable<CustomFood> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? kcalPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? fiberPer100g,
    Expression<String>? recipe,
    Expression<String>? ingredients,
    Expression<int>? usageCount,
    Expression<DateTime>? lastUsedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (kcalPer100g != null) 'kcal_per100g': kcalPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (fiberPer100g != null) 'fiber_per100g': fiberPer100g,
      if (recipe != null) 'recipe': recipe,
      if (ingredients != null) 'ingredients': ingredients,
      if (usageCount != null) 'usage_count': usageCount,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CustomFoodsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<String?>? description,
      Value<double>? kcalPer100g,
      Value<double>? carbsPer100g,
      Value<double>? proteinPer100g,
      Value<double>? fatPer100g,
      Value<double>? fiberPer100g,
      Value<String?>? recipe,
      Value<String?>? ingredients,
      Value<int>? usageCount,
      Value<DateTime?>? lastUsedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CustomFoodsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      kcalPer100g: kcalPer100g ?? this.kcalPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      fiberPer100g: fiberPer100g ?? this.fiberPer100g,
      recipe: recipe ?? this.recipe,
      ingredients: ingredients ?? this.ingredients,
      usageCount: usageCount ?? this.usageCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (kcalPer100g.present) {
      map['kcal_per100g'] = Variable<double>(kcalPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (fiberPer100g.present) {
      map['fiber_per100g'] = Variable<double>(fiberPer100g.value);
    }
    if (recipe.present) {
      map['recipe'] = Variable<String>(recipe.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(ingredients.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomFoodsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fiberPer100g: $fiberPer100g, ')
          ..write('recipe: $recipe, ')
          ..write('ingredients: $ingredients, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserFoodStatisticsTable extends UserFoodStatistics
    with TableInfo<$UserFoodStatisticsTable, UserFoodStatistic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFoodStatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<int> foodId = GeneratedColumn<int>(
      'food_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _foodTypeMeta =
      const VerificationMeta('foodType');
  @override
  late final GeneratedColumn<String> foodType = GeneratedColumn<String>(
      'food_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalConsumptionsMeta =
      const VerificationMeta('totalConsumptions');
  @override
  late final GeneratedColumn<int> totalConsumptions = GeneratedColumn<int>(
      'total_consumptions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _averagePortionGramsMeta =
      const VerificationMeta('averagePortionGrams');
  @override
  late final GeneratedColumn<double> averagePortionGrams =
      GeneratedColumn<double>('average_portion_grams', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _firstConsumedAtMeta =
      const VerificationMeta('firstConsumedAt');
  @override
  late final GeneratedColumn<DateTime> firstConsumedAt =
      GeneratedColumn<DateTime>('first_consumed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastConsumedAtMeta =
      const VerificationMeta('lastConsumedAt');
  @override
  late final GeneratedColumn<DateTime> lastConsumedAt =
      GeneratedColumn<DateTime>('last_consumed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _preferenceScoreMeta =
      const VerificationMeta('preferenceScore');
  @override
  late final GeneratedColumn<double> preferenceScore = GeneratedColumn<double>(
      'preference_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _preferredMealTypesMeta =
      const VerificationMeta('preferredMealTypes');
  @override
  late final GeneratedColumn<String> preferredMealTypes =
      GeneratedColumn<String>('preferred_meal_types', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        foodId,
        foodType,
        totalConsumptions,
        averagePortionGrams,
        firstConsumedAt,
        lastConsumedAt,
        preferenceScore,
        preferredMealTypes,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_food_statistics';
  @override
  VerificationContext validateIntegrity(Insertable<UserFoodStatistic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('food_type')) {
      context.handle(_foodTypeMeta,
          foodType.isAcceptableOrUnknown(data['food_type']!, _foodTypeMeta));
    } else if (isInserting) {
      context.missing(_foodTypeMeta);
    }
    if (data.containsKey('total_consumptions')) {
      context.handle(
          _totalConsumptionsMeta,
          totalConsumptions.isAcceptableOrUnknown(
              data['total_consumptions']!, _totalConsumptionsMeta));
    }
    if (data.containsKey('average_portion_grams')) {
      context.handle(
          _averagePortionGramsMeta,
          averagePortionGrams.isAcceptableOrUnknown(
              data['average_portion_grams']!, _averagePortionGramsMeta));
    }
    if (data.containsKey('first_consumed_at')) {
      context.handle(
          _firstConsumedAtMeta,
          firstConsumedAt.isAcceptableOrUnknown(
              data['first_consumed_at']!, _firstConsumedAtMeta));
    }
    if (data.containsKey('last_consumed_at')) {
      context.handle(
          _lastConsumedAtMeta,
          lastConsumedAt.isAcceptableOrUnknown(
              data['last_consumed_at']!, _lastConsumedAtMeta));
    }
    if (data.containsKey('preference_score')) {
      context.handle(
          _preferenceScoreMeta,
          preferenceScore.isAcceptableOrUnknown(
              data['preference_score']!, _preferenceScoreMeta));
    }
    if (data.containsKey('preferred_meal_types')) {
      context.handle(
          _preferredMealTypesMeta,
          preferredMealTypes.isAcceptableOrUnknown(
              data['preferred_meal_types']!, _preferredMealTypesMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserFoodStatistic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFoodStatistic(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}food_id'])!,
      foodType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_type'])!,
      totalConsumptions: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_consumptions'])!,
      averagePortionGrams: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}average_portion_grams'])!,
      firstConsumedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_consumed_at']),
      lastConsumedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_consumed_at']),
      preferenceScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}preference_score'])!,
      preferredMealTypes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}preferred_meal_types']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserFoodStatisticsTable createAlias(String alias) {
    return $UserFoodStatisticsTable(attachedDatabase, alias);
  }
}

class UserFoodStatistic extends DataClass
    implements Insertable<UserFoodStatistic> {
  final int id;
  final String userId;
  final int foodId;
  final String foodType;
  final int totalConsumptions;
  final double averagePortionGrams;
  final DateTime? firstConsumedAt;
  final DateTime? lastConsumedAt;
  final double preferenceScore;
  final String? preferredMealTypes;
  final DateTime updatedAt;
  const UserFoodStatistic(
      {required this.id,
      required this.userId,
      required this.foodId,
      required this.foodType,
      required this.totalConsumptions,
      required this.averagePortionGrams,
      this.firstConsumedAt,
      this.lastConsumedAt,
      required this.preferenceScore,
      this.preferredMealTypes,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['food_id'] = Variable<int>(foodId);
    map['food_type'] = Variable<String>(foodType);
    map['total_consumptions'] = Variable<int>(totalConsumptions);
    map['average_portion_grams'] = Variable<double>(averagePortionGrams);
    if (!nullToAbsent || firstConsumedAt != null) {
      map['first_consumed_at'] = Variable<DateTime>(firstConsumedAt);
    }
    if (!nullToAbsent || lastConsumedAt != null) {
      map['last_consumed_at'] = Variable<DateTime>(lastConsumedAt);
    }
    map['preference_score'] = Variable<double>(preferenceScore);
    if (!nullToAbsent || preferredMealTypes != null) {
      map['preferred_meal_types'] = Variable<String>(preferredMealTypes);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserFoodStatisticsCompanion toCompanion(bool nullToAbsent) {
    return UserFoodStatisticsCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId: Value(foodId),
      foodType: Value(foodType),
      totalConsumptions: Value(totalConsumptions),
      averagePortionGrams: Value(averagePortionGrams),
      firstConsumedAt: firstConsumedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(firstConsumedAt),
      lastConsumedAt: lastConsumedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastConsumedAt),
      preferenceScore: Value(preferenceScore),
      preferredMealTypes: preferredMealTypes == null && nullToAbsent
          ? const Value.absent()
          : Value(preferredMealTypes),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserFoodStatistic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFoodStatistic(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      foodId: serializer.fromJson<int>(json['foodId']),
      foodType: serializer.fromJson<String>(json['foodType']),
      totalConsumptions: serializer.fromJson<int>(json['totalConsumptions']),
      averagePortionGrams:
          serializer.fromJson<double>(json['averagePortionGrams']),
      firstConsumedAt: serializer.fromJson<DateTime?>(json['firstConsumedAt']),
      lastConsumedAt: serializer.fromJson<DateTime?>(json['lastConsumedAt']),
      preferenceScore: serializer.fromJson<double>(json['preferenceScore']),
      preferredMealTypes:
          serializer.fromJson<String?>(json['preferredMealTypes']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'foodId': serializer.toJson<int>(foodId),
      'foodType': serializer.toJson<String>(foodType),
      'totalConsumptions': serializer.toJson<int>(totalConsumptions),
      'averagePortionGrams': serializer.toJson<double>(averagePortionGrams),
      'firstConsumedAt': serializer.toJson<DateTime?>(firstConsumedAt),
      'lastConsumedAt': serializer.toJson<DateTime?>(lastConsumedAt),
      'preferenceScore': serializer.toJson<double>(preferenceScore),
      'preferredMealTypes': serializer.toJson<String?>(preferredMealTypes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserFoodStatistic copyWith(
          {int? id,
          String? userId,
          int? foodId,
          String? foodType,
          int? totalConsumptions,
          double? averagePortionGrams,
          Value<DateTime?> firstConsumedAt = const Value.absent(),
          Value<DateTime?> lastConsumedAt = const Value.absent(),
          double? preferenceScore,
          Value<String?> preferredMealTypes = const Value.absent(),
          DateTime? updatedAt}) =>
      UserFoodStatistic(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        foodId: foodId ?? this.foodId,
        foodType: foodType ?? this.foodType,
        totalConsumptions: totalConsumptions ?? this.totalConsumptions,
        averagePortionGrams: averagePortionGrams ?? this.averagePortionGrams,
        firstConsumedAt: firstConsumedAt.present
            ? firstConsumedAt.value
            : this.firstConsumedAt,
        lastConsumedAt:
            lastConsumedAt.present ? lastConsumedAt.value : this.lastConsumedAt,
        preferenceScore: preferenceScore ?? this.preferenceScore,
        preferredMealTypes: preferredMealTypes.present
            ? preferredMealTypes.value
            : this.preferredMealTypes,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserFoodStatistic copyWithCompanion(UserFoodStatisticsCompanion data) {
    return UserFoodStatistic(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      foodType: data.foodType.present ? data.foodType.value : this.foodType,
      totalConsumptions: data.totalConsumptions.present
          ? data.totalConsumptions.value
          : this.totalConsumptions,
      averagePortionGrams: data.averagePortionGrams.present
          ? data.averagePortionGrams.value
          : this.averagePortionGrams,
      firstConsumedAt: data.firstConsumedAt.present
          ? data.firstConsumedAt.value
          : this.firstConsumedAt,
      lastConsumedAt: data.lastConsumedAt.present
          ? data.lastConsumedAt.value
          : this.lastConsumedAt,
      preferenceScore: data.preferenceScore.present
          ? data.preferenceScore.value
          : this.preferenceScore,
      preferredMealTypes: data.preferredMealTypes.present
          ? data.preferredMealTypes.value
          : this.preferredMealTypes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodStatistic(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('foodType: $foodType, ')
          ..write('totalConsumptions: $totalConsumptions, ')
          ..write('averagePortionGrams: $averagePortionGrams, ')
          ..write('firstConsumedAt: $firstConsumedAt, ')
          ..write('lastConsumedAt: $lastConsumedAt, ')
          ..write('preferenceScore: $preferenceScore, ')
          ..write('preferredMealTypes: $preferredMealTypes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      foodId,
      foodType,
      totalConsumptions,
      averagePortionGrams,
      firstConsumedAt,
      lastConsumedAt,
      preferenceScore,
      preferredMealTypes,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFoodStatistic &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodId == this.foodId &&
          other.foodType == this.foodType &&
          other.totalConsumptions == this.totalConsumptions &&
          other.averagePortionGrams == this.averagePortionGrams &&
          other.firstConsumedAt == this.firstConsumedAt &&
          other.lastConsumedAt == this.lastConsumedAt &&
          other.preferenceScore == this.preferenceScore &&
          other.preferredMealTypes == this.preferredMealTypes &&
          other.updatedAt == this.updatedAt);
}

class UserFoodStatisticsCompanion extends UpdateCompanion<UserFoodStatistic> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> foodId;
  final Value<String> foodType;
  final Value<int> totalConsumptions;
  final Value<double> averagePortionGrams;
  final Value<DateTime?> firstConsumedAt;
  final Value<DateTime?> lastConsumedAt;
  final Value<double> preferenceScore;
  final Value<String?> preferredMealTypes;
  final Value<DateTime> updatedAt;
  const UserFoodStatisticsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.foodType = const Value.absent(),
    this.totalConsumptions = const Value.absent(),
    this.averagePortionGrams = const Value.absent(),
    this.firstConsumedAt = const Value.absent(),
    this.lastConsumedAt = const Value.absent(),
    this.preferenceScore = const Value.absent(),
    this.preferredMealTypes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserFoodStatisticsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int foodId,
    required String foodType,
    this.totalConsumptions = const Value.absent(),
    this.averagePortionGrams = const Value.absent(),
    this.firstConsumedAt = const Value.absent(),
    this.lastConsumedAt = const Value.absent(),
    this.preferenceScore = const Value.absent(),
    this.preferredMealTypes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        foodId = Value(foodId),
        foodType = Value(foodType);
  static Insertable<UserFoodStatistic> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? foodId,
    Expression<String>? foodType,
    Expression<int>? totalConsumptions,
    Expression<double>? averagePortionGrams,
    Expression<DateTime>? firstConsumedAt,
    Expression<DateTime>? lastConsumedAt,
    Expression<double>? preferenceScore,
    Expression<String>? preferredMealTypes,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (foodId != null) 'food_id': foodId,
      if (foodType != null) 'food_type': foodType,
      if (totalConsumptions != null) 'total_consumptions': totalConsumptions,
      if (averagePortionGrams != null)
        'average_portion_grams': averagePortionGrams,
      if (firstConsumedAt != null) 'first_consumed_at': firstConsumedAt,
      if (lastConsumedAt != null) 'last_consumed_at': lastConsumedAt,
      if (preferenceScore != null) 'preference_score': preferenceScore,
      if (preferredMealTypes != null)
        'preferred_meal_types': preferredMealTypes,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserFoodStatisticsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<int>? foodId,
      Value<String>? foodType,
      Value<int>? totalConsumptions,
      Value<double>? averagePortionGrams,
      Value<DateTime?>? firstConsumedAt,
      Value<DateTime?>? lastConsumedAt,
      Value<double>? preferenceScore,
      Value<String?>? preferredMealTypes,
      Value<DateTime>? updatedAt}) {
    return UserFoodStatisticsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      foodType: foodType ?? this.foodType,
      totalConsumptions: totalConsumptions ?? this.totalConsumptions,
      averagePortionGrams: averagePortionGrams ?? this.averagePortionGrams,
      firstConsumedAt: firstConsumedAt ?? this.firstConsumedAt,
      lastConsumedAt: lastConsumedAt ?? this.lastConsumedAt,
      preferenceScore: preferenceScore ?? this.preferenceScore,
      preferredMealTypes: preferredMealTypes ?? this.preferredMealTypes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (foodType.present) {
      map['food_type'] = Variable<String>(foodType.value);
    }
    if (totalConsumptions.present) {
      map['total_consumptions'] = Variable<int>(totalConsumptions.value);
    }
    if (averagePortionGrams.present) {
      map['average_portion_grams'] =
          Variable<double>(averagePortionGrams.value);
    }
    if (firstConsumedAt.present) {
      map['first_consumed_at'] = Variable<DateTime>(firstConsumedAt.value);
    }
    if (lastConsumedAt.present) {
      map['last_consumed_at'] = Variable<DateTime>(lastConsumedAt.value);
    }
    if (preferenceScore.present) {
      map['preference_score'] = Variable<double>(preferenceScore.value);
    }
    if (preferredMealTypes.present) {
      map['preferred_meal_types'] = Variable<String>(preferredMealTypes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFoodStatisticsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('foodType: $foodType, ')
          ..write('totalConsumptions: $totalConsumptions, ')
          ..write('averagePortionGrams: $averagePortionGrams, ')
          ..write('firstConsumedAt: $firstConsumedAt, ')
          ..write('lastConsumedAt: $lastConsumedAt, ')
          ..write('preferenceScore: $preferenceScore, ')
          ..write('preferredMealTypes: $preferredMealTypes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyActivitiesTable extends DailyActivities
    with TableInfo<$DailyActivitiesTable, DailyActivity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
      'steps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _distanceMetersMeta =
      const VerificationMeta('distanceMeters');
  @override
  late final GeneratedColumn<int> distanceMeters = GeneratedColumn<int>(
      'distance_meters', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _caloriesBurnedMeta =
      const VerificationMeta('caloriesBurned');
  @override
  late final GeneratedColumn<int> caloriesBurned = GeneratedColumn<int>(
      'calories_burned', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _activeMinutesMeta =
      const VerificationMeta('activeMinutes');
  @override
  late final GeneratedColumn<int> activeMinutes = GeneratedColumn<int>(
      'active_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lightActivityMinutesMeta =
      const VerificationMeta('lightActivityMinutes');
  @override
  late final GeneratedColumn<int> lightActivityMinutes = GeneratedColumn<int>(
      'light_activity_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _moderateActivityMinutesMeta =
      const VerificationMeta('moderateActivityMinutes');
  @override
  late final GeneratedColumn<int> moderateActivityMinutes =
      GeneratedColumn<int>('moderate_activity_minutes', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _vigorousActivityMinutesMeta =
      const VerificationMeta('vigorousActivityMinutes');
  @override
  late final GeneratedColumn<int> vigorousActivityMinutes =
      GeneratedColumn<int>('vigorous_activity_minutes', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _sedentaryMinutesMeta =
      const VerificationMeta('sedentaryMinutes');
  @override
  late final GeneratedColumn<int> sedentaryMinutes = GeneratedColumn<int>(
      'sedentary_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _heartRateAverageMeta =
      const VerificationMeta('heartRateAverage');
  @override
  late final GeneratedColumn<int> heartRateAverage = GeneratedColumn<int>(
      'heart_rate_average', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _heartRateMaxMeta =
      const VerificationMeta('heartRateMax');
  @override
  late final GeneratedColumn<int> heartRateMax = GeneratedColumn<int>(
      'heart_rate_max', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        date,
        steps,
        distanceMeters,
        caloriesBurned,
        activeMinutes,
        lightActivityMinutes,
        moderateActivityMinutes,
        vigorousActivityMinutes,
        sedentaryMinutes,
        heartRateAverage,
        heartRateMax,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_activities';
  @override
  VerificationContext validateIntegrity(Insertable<DailyActivity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    }
    if (data.containsKey('distance_meters')) {
      context.handle(
          _distanceMetersMeta,
          distanceMeters.isAcceptableOrUnknown(
              data['distance_meters']!, _distanceMetersMeta));
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
          _caloriesBurnedMeta,
          caloriesBurned.isAcceptableOrUnknown(
              data['calories_burned']!, _caloriesBurnedMeta));
    }
    if (data.containsKey('active_minutes')) {
      context.handle(
          _activeMinutesMeta,
          activeMinutes.isAcceptableOrUnknown(
              data['active_minutes']!, _activeMinutesMeta));
    }
    if (data.containsKey('light_activity_minutes')) {
      context.handle(
          _lightActivityMinutesMeta,
          lightActivityMinutes.isAcceptableOrUnknown(
              data['light_activity_minutes']!, _lightActivityMinutesMeta));
    }
    if (data.containsKey('moderate_activity_minutes')) {
      context.handle(
          _moderateActivityMinutesMeta,
          moderateActivityMinutes.isAcceptableOrUnknown(
              data['moderate_activity_minutes']!,
              _moderateActivityMinutesMeta));
    }
    if (data.containsKey('vigorous_activity_minutes')) {
      context.handle(
          _vigorousActivityMinutesMeta,
          vigorousActivityMinutes.isAcceptableOrUnknown(
              data['vigorous_activity_minutes']!,
              _vigorousActivityMinutesMeta));
    }
    if (data.containsKey('sedentary_minutes')) {
      context.handle(
          _sedentaryMinutesMeta,
          sedentaryMinutes.isAcceptableOrUnknown(
              data['sedentary_minutes']!, _sedentaryMinutesMeta));
    }
    if (data.containsKey('heart_rate_average')) {
      context.handle(
          _heartRateAverageMeta,
          heartRateAverage.isAcceptableOrUnknown(
              data['heart_rate_average']!, _heartRateAverageMeta));
    }
    if (data.containsKey('heart_rate_max')) {
      context.handle(
          _heartRateMaxMeta,
          heartRateMax.isAcceptableOrUnknown(
              data['heart_rate_max']!, _heartRateMaxMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, date};
  @override
  DailyActivity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyActivity(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      steps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps'])!,
      distanceMeters: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}distance_meters'])!,
      caloriesBurned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories_burned'])!,
      activeMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}active_minutes'])!,
      lightActivityMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}light_activity_minutes'])!,
      moderateActivityMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}moderate_activity_minutes'])!,
      vigorousActivityMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}vigorous_activity_minutes'])!,
      sedentaryMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sedentary_minutes'])!,
      heartRateAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}heart_rate_average']),
      heartRateMax: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}heart_rate_max']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyActivitiesTable createAlias(String alias) {
    return $DailyActivitiesTable(attachedDatabase, alias);
  }
}

class DailyActivity extends DataClass implements Insertable<DailyActivity> {
  final String userId;
  final DateTime date;
  final int steps;
  final int distanceMeters;
  final int caloriesBurned;
  final int activeMinutes;
  final int lightActivityMinutes;
  final int moderateActivityMinutes;
  final int vigorousActivityMinutes;
  final int sedentaryMinutes;
  final int? heartRateAverage;
  final int? heartRateMax;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyActivity(
      {required this.userId,
      required this.date,
      required this.steps,
      required this.distanceMeters,
      required this.caloriesBurned,
      required this.activeMinutes,
      required this.lightActivityMinutes,
      required this.moderateActivityMinutes,
      required this.vigorousActivityMinutes,
      required this.sedentaryMinutes,
      this.heartRateAverage,
      this.heartRateMax,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['steps'] = Variable<int>(steps);
    map['distance_meters'] = Variable<int>(distanceMeters);
    map['calories_burned'] = Variable<int>(caloriesBurned);
    map['active_minutes'] = Variable<int>(activeMinutes);
    map['light_activity_minutes'] = Variable<int>(lightActivityMinutes);
    map['moderate_activity_minutes'] = Variable<int>(moderateActivityMinutes);
    map['vigorous_activity_minutes'] = Variable<int>(vigorousActivityMinutes);
    map['sedentary_minutes'] = Variable<int>(sedentaryMinutes);
    if (!nullToAbsent || heartRateAverage != null) {
      map['heart_rate_average'] = Variable<int>(heartRateAverage);
    }
    if (!nullToAbsent || heartRateMax != null) {
      map['heart_rate_max'] = Variable<int>(heartRateMax);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyActivitiesCompanion toCompanion(bool nullToAbsent) {
    return DailyActivitiesCompanion(
      userId: Value(userId),
      date: Value(date),
      steps: Value(steps),
      distanceMeters: Value(distanceMeters),
      caloriesBurned: Value(caloriesBurned),
      activeMinutes: Value(activeMinutes),
      lightActivityMinutes: Value(lightActivityMinutes),
      moderateActivityMinutes: Value(moderateActivityMinutes),
      vigorousActivityMinutes: Value(vigorousActivityMinutes),
      sedentaryMinutes: Value(sedentaryMinutes),
      heartRateAverage: heartRateAverage == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateAverage),
      heartRateMax: heartRateMax == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateMax),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyActivity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyActivity(
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      steps: serializer.fromJson<int>(json['steps']),
      distanceMeters: serializer.fromJson<int>(json['distanceMeters']),
      caloriesBurned: serializer.fromJson<int>(json['caloriesBurned']),
      activeMinutes: serializer.fromJson<int>(json['activeMinutes']),
      lightActivityMinutes:
          serializer.fromJson<int>(json['lightActivityMinutes']),
      moderateActivityMinutes:
          serializer.fromJson<int>(json['moderateActivityMinutes']),
      vigorousActivityMinutes:
          serializer.fromJson<int>(json['vigorousActivityMinutes']),
      sedentaryMinutes: serializer.fromJson<int>(json['sedentaryMinutes']),
      heartRateAverage: serializer.fromJson<int?>(json['heartRateAverage']),
      heartRateMax: serializer.fromJson<int?>(json['heartRateMax']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'steps': serializer.toJson<int>(steps),
      'distanceMeters': serializer.toJson<int>(distanceMeters),
      'caloriesBurned': serializer.toJson<int>(caloriesBurned),
      'activeMinutes': serializer.toJson<int>(activeMinutes),
      'lightActivityMinutes': serializer.toJson<int>(lightActivityMinutes),
      'moderateActivityMinutes':
          serializer.toJson<int>(moderateActivityMinutes),
      'vigorousActivityMinutes':
          serializer.toJson<int>(vigorousActivityMinutes),
      'sedentaryMinutes': serializer.toJson<int>(sedentaryMinutes),
      'heartRateAverage': serializer.toJson<int?>(heartRateAverage),
      'heartRateMax': serializer.toJson<int?>(heartRateMax),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyActivity copyWith(
          {String? userId,
          DateTime? date,
          int? steps,
          int? distanceMeters,
          int? caloriesBurned,
          int? activeMinutes,
          int? lightActivityMinutes,
          int? moderateActivityMinutes,
          int? vigorousActivityMinutes,
          int? sedentaryMinutes,
          Value<int?> heartRateAverage = const Value.absent(),
          Value<int?> heartRateMax = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DailyActivity(
        userId: userId ?? this.userId,
        date: date ?? this.date,
        steps: steps ?? this.steps,
        distanceMeters: distanceMeters ?? this.distanceMeters,
        caloriesBurned: caloriesBurned ?? this.caloriesBurned,
        activeMinutes: activeMinutes ?? this.activeMinutes,
        lightActivityMinutes: lightActivityMinutes ?? this.lightActivityMinutes,
        moderateActivityMinutes:
            moderateActivityMinutes ?? this.moderateActivityMinutes,
        vigorousActivityMinutes:
            vigorousActivityMinutes ?? this.vigorousActivityMinutes,
        sedentaryMinutes: sedentaryMinutes ?? this.sedentaryMinutes,
        heartRateAverage: heartRateAverage.present
            ? heartRateAverage.value
            : this.heartRateAverage,
        heartRateMax:
            heartRateMax.present ? heartRateMax.value : this.heartRateMax,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyActivity copyWithCompanion(DailyActivitiesCompanion data) {
    return DailyActivity(
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      steps: data.steps.present ? data.steps.value : this.steps,
      distanceMeters: data.distanceMeters.present
          ? data.distanceMeters.value
          : this.distanceMeters,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      activeMinutes: data.activeMinutes.present
          ? data.activeMinutes.value
          : this.activeMinutes,
      lightActivityMinutes: data.lightActivityMinutes.present
          ? data.lightActivityMinutes.value
          : this.lightActivityMinutes,
      moderateActivityMinutes: data.moderateActivityMinutes.present
          ? data.moderateActivityMinutes.value
          : this.moderateActivityMinutes,
      vigorousActivityMinutes: data.vigorousActivityMinutes.present
          ? data.vigorousActivityMinutes.value
          : this.vigorousActivityMinutes,
      sedentaryMinutes: data.sedentaryMinutes.present
          ? data.sedentaryMinutes.value
          : this.sedentaryMinutes,
      heartRateAverage: data.heartRateAverage.present
          ? data.heartRateAverage.value
          : this.heartRateAverage,
      heartRateMax: data.heartRateMax.present
          ? data.heartRateMax.value
          : this.heartRateMax,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivity(')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('steps: $steps, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('activeMinutes: $activeMinutes, ')
          ..write('lightActivityMinutes: $lightActivityMinutes, ')
          ..write('moderateActivityMinutes: $moderateActivityMinutes, ')
          ..write('vigorousActivityMinutes: $vigorousActivityMinutes, ')
          ..write('sedentaryMinutes: $sedentaryMinutes, ')
          ..write('heartRateAverage: $heartRateAverage, ')
          ..write('heartRateMax: $heartRateMax, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId,
      date,
      steps,
      distanceMeters,
      caloriesBurned,
      activeMinutes,
      lightActivityMinutes,
      moderateActivityMinutes,
      vigorousActivityMinutes,
      sedentaryMinutes,
      heartRateAverage,
      heartRateMax,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyActivity &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.steps == this.steps &&
          other.distanceMeters == this.distanceMeters &&
          other.caloriesBurned == this.caloriesBurned &&
          other.activeMinutes == this.activeMinutes &&
          other.lightActivityMinutes == this.lightActivityMinutes &&
          other.moderateActivityMinutes == this.moderateActivityMinutes &&
          other.vigorousActivityMinutes == this.vigorousActivityMinutes &&
          other.sedentaryMinutes == this.sedentaryMinutes &&
          other.heartRateAverage == this.heartRateAverage &&
          other.heartRateMax == this.heartRateMax &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyActivitiesCompanion extends UpdateCompanion<DailyActivity> {
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<int> steps;
  final Value<int> distanceMeters;
  final Value<int> caloriesBurned;
  final Value<int> activeMinutes;
  final Value<int> lightActivityMinutes;
  final Value<int> moderateActivityMinutes;
  final Value<int> vigorousActivityMinutes;
  final Value<int> sedentaryMinutes;
  final Value<int?> heartRateAverage;
  final Value<int?> heartRateMax;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyActivitiesCompanion({
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.steps = const Value.absent(),
    this.distanceMeters = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.activeMinutes = const Value.absent(),
    this.lightActivityMinutes = const Value.absent(),
    this.moderateActivityMinutes = const Value.absent(),
    this.vigorousActivityMinutes = const Value.absent(),
    this.sedentaryMinutes = const Value.absent(),
    this.heartRateAverage = const Value.absent(),
    this.heartRateMax = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyActivitiesCompanion.insert({
    required String userId,
    required DateTime date,
    this.steps = const Value.absent(),
    this.distanceMeters = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.activeMinutes = const Value.absent(),
    this.lightActivityMinutes = const Value.absent(),
    this.moderateActivityMinutes = const Value.absent(),
    this.vigorousActivityMinutes = const Value.absent(),
    this.sedentaryMinutes = const Value.absent(),
    this.heartRateAverage = const Value.absent(),
    this.heartRateMax = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        date = Value(date);
  static Insertable<DailyActivity> custom({
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<int>? steps,
    Expression<int>? distanceMeters,
    Expression<int>? caloriesBurned,
    Expression<int>? activeMinutes,
    Expression<int>? lightActivityMinutes,
    Expression<int>? moderateActivityMinutes,
    Expression<int>? vigorousActivityMinutes,
    Expression<int>? sedentaryMinutes,
    Expression<int>? heartRateAverage,
    Expression<int>? heartRateMax,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (steps != null) 'steps': steps,
      if (distanceMeters != null) 'distance_meters': distanceMeters,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (activeMinutes != null) 'active_minutes': activeMinutes,
      if (lightActivityMinutes != null)
        'light_activity_minutes': lightActivityMinutes,
      if (moderateActivityMinutes != null)
        'moderate_activity_minutes': moderateActivityMinutes,
      if (vigorousActivityMinutes != null)
        'vigorous_activity_minutes': vigorousActivityMinutes,
      if (sedentaryMinutes != null) 'sedentary_minutes': sedentaryMinutes,
      if (heartRateAverage != null) 'heart_rate_average': heartRateAverage,
      if (heartRateMax != null) 'heart_rate_max': heartRateMax,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyActivitiesCompanion copyWith(
      {Value<String>? userId,
      Value<DateTime>? date,
      Value<int>? steps,
      Value<int>? distanceMeters,
      Value<int>? caloriesBurned,
      Value<int>? activeMinutes,
      Value<int>? lightActivityMinutes,
      Value<int>? moderateActivityMinutes,
      Value<int>? vigorousActivityMinutes,
      Value<int>? sedentaryMinutes,
      Value<int?>? heartRateAverage,
      Value<int?>? heartRateMax,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return DailyActivitiesCompanion(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      steps: steps ?? this.steps,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      activeMinutes: activeMinutes ?? this.activeMinutes,
      lightActivityMinutes: lightActivityMinutes ?? this.lightActivityMinutes,
      moderateActivityMinutes:
          moderateActivityMinutes ?? this.moderateActivityMinutes,
      vigorousActivityMinutes:
          vigorousActivityMinutes ?? this.vigorousActivityMinutes,
      sedentaryMinutes: sedentaryMinutes ?? this.sedentaryMinutes,
      heartRateAverage: heartRateAverage ?? this.heartRateAverage,
      heartRateMax: heartRateMax ?? this.heartRateMax,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (distanceMeters.present) {
      map['distance_meters'] = Variable<int>(distanceMeters.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<int>(caloriesBurned.value);
    }
    if (activeMinutes.present) {
      map['active_minutes'] = Variable<int>(activeMinutes.value);
    }
    if (lightActivityMinutes.present) {
      map['light_activity_minutes'] = Variable<int>(lightActivityMinutes.value);
    }
    if (moderateActivityMinutes.present) {
      map['moderate_activity_minutes'] =
          Variable<int>(moderateActivityMinutes.value);
    }
    if (vigorousActivityMinutes.present) {
      map['vigorous_activity_minutes'] =
          Variable<int>(vigorousActivityMinutes.value);
    }
    if (sedentaryMinutes.present) {
      map['sedentary_minutes'] = Variable<int>(sedentaryMinutes.value);
    }
    if (heartRateAverage.present) {
      map['heart_rate_average'] = Variable<int>(heartRateAverage.value);
    }
    if (heartRateMax.present) {
      map['heart_rate_max'] = Variable<int>(heartRateMax.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivitiesCompanion(')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('steps: $steps, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('activeMinutes: $activeMinutes, ')
          ..write('lightActivityMinutes: $lightActivityMinutes, ')
          ..write('moderateActivityMinutes: $moderateActivityMinutes, ')
          ..write('vigorousActivityMinutes: $vigorousActivityMinutes, ')
          ..write('sedentaryMinutes: $sedentaryMinutes, ')
          ..write('heartRateAverage: $heartRateAverage, ')
          ..write('heartRateMax: $heartRateMax, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _intensityMeta =
      const VerificationMeta('intensity');
  @override
  late final GeneratedColumn<String> intensity = GeneratedColumn<String>(
      'intensity', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('moderate'));
  static const VerificationMeta _caloriesBurnedMeta =
      const VerificationMeta('caloriesBurned');
  @override
  late final GeneratedColumn<int> caloriesBurned = GeneratedColumn<int>(
      'calories_burned', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _distanceMeta =
      const VerificationMeta('distance');
  @override
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
      'distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        type,
        name,
        startTime,
        endTime,
        duration,
        intensity,
        caloriesBurned,
        distance,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(_intensityMeta,
          intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta));
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
          _caloriesBurnedMeta,
          caloriesBurned.isAcceptableOrUnknown(
              data['calories_burned']!, _caloriesBurnedMeta));
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      intensity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intensity'])!,
      caloriesBurned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories_burned'])!,
      distance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final int id;
  final String userId;
  final String type;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final int duration;
  final String intensity;
  final int caloriesBurned;
  final double? distance;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkoutSession(
      {required this.id,
      required this.userId,
      required this.type,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.intensity,
      required this.caloriesBurned,
      this.distance,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['duration'] = Variable<int>(duration);
    map['intensity'] = Variable<String>(intensity);
    map['calories_burned'] = Variable<int>(caloriesBurned);
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<double>(distance);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      type: Value(type),
      name: Value(name),
      startTime: Value(startTime),
      endTime: Value(endTime),
      duration: Value(duration),
      intensity: Value(intensity),
      caloriesBurned: Value(caloriesBurned),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      duration: serializer.fromJson<int>(json['duration']),
      intensity: serializer.fromJson<String>(json['intensity']),
      caloriesBurned: serializer.fromJson<int>(json['caloriesBurned']),
      distance: serializer.fromJson<double?>(json['distance']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'duration': serializer.toJson<int>(duration),
      'intensity': serializer.toJson<String>(intensity),
      'caloriesBurned': serializer.toJson<int>(caloriesBurned),
      'distance': serializer.toJson<double?>(distance),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkoutSession copyWith(
          {int? id,
          String? userId,
          String? type,
          String? name,
          DateTime? startTime,
          DateTime? endTime,
          int? duration,
          String? intensity,
          int? caloriesBurned,
          Value<double?> distance = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WorkoutSession(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        name: name ?? this.name,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        duration: duration ?? this.duration,
        intensity: intensity ?? this.intensity,
        caloriesBurned: caloriesBurned ?? this.caloriesBurned,
        distance: distance.present ? distance.value : this.distance,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      duration: data.duration.present ? data.duration.value : this.duration,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      distance: data.distance.present ? data.distance.value : this.distance,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('duration: $duration, ')
          ..write('intensity: $intensity, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('distance: $distance, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      type,
      name,
      startTime,
      endTime,
      duration,
      intensity,
      caloriesBurned,
      distance,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.name == this.name &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.duration == this.duration &&
          other.intensity == this.intensity &&
          other.caloriesBurned == this.caloriesBurned &&
          other.distance == this.distance &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> type;
  final Value<String> name;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<int> duration;
  final Value<String> intensity;
  final Value<int> caloriesBurned;
  final Value<double?> distance;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.duration = const Value.absent(),
    this.intensity = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.distance = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String type,
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required int duration,
    this.intensity = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.distance = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        type = Value(type),
        name = Value(name),
        startTime = Value(startTime),
        endTime = Value(endTime),
        duration = Value(duration);
  static Insertable<WorkoutSession> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? duration,
    Expression<String>? intensity,
    Expression<int>? caloriesBurned,
    Expression<double>? distance,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (duration != null) 'duration': duration,
      if (intensity != null) 'intensity': intensity,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (distance != null) 'distance': distance,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WorkoutSessionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? type,
      Value<String>? name,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<int>? duration,
      Value<String>? intensity,
      Value<int>? caloriesBurned,
      Value<double?>? distance,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      intensity: intensity ?? this.intensity,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      distance: distance ?? this.distance,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<String>(intensity.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<int>(caloriesBurned.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('duration: $duration, ')
          ..write('intensity: $intensity, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('distance: $distance, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ActivityGoalsTable extends ActivityGoals
    with TableInfo<$ActivityGoalsTable, ActivityGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _stepsGoalMeta =
      const VerificationMeta('stepsGoal');
  @override
  late final GeneratedColumn<int> stepsGoal = GeneratedColumn<int>(
      'steps_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(10000));
  static const VerificationMeta _caloriesBurnedGoalMeta =
      const VerificationMeta('caloriesBurnedGoal');
  @override
  late final GeneratedColumn<int> caloriesBurnedGoal = GeneratedColumn<int>(
      'calories_burned_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(400));
  static const VerificationMeta _activeMinutesGoalMeta =
      const VerificationMeta('activeMinutesGoal');
  @override
  late final GeneratedColumn<int> activeMinutesGoal = GeneratedColumn<int>(
      'active_minutes_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(60));
  static const VerificationMeta _distanceGoalMeta =
      const VerificationMeta('distanceGoal');
  @override
  late final GeneratedColumn<int> distanceGoal = GeneratedColumn<int>(
      'distance_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(7500));
  static const VerificationMeta _workoutsPerWeekGoalMeta =
      const VerificationMeta('workoutsPerWeekGoal');
  @override
  late final GeneratedColumn<int> workoutsPerWeekGoal = GeneratedColumn<int>(
      'workouts_per_week_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        stepsGoal,
        caloriesBurnedGoal,
        activeMinutesGoal,
        distanceGoal,
        workoutsPerWeekGoal,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_goals';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityGoal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('steps_goal')) {
      context.handle(_stepsGoalMeta,
          stepsGoal.isAcceptableOrUnknown(data['steps_goal']!, _stepsGoalMeta));
    }
    if (data.containsKey('calories_burned_goal')) {
      context.handle(
          _caloriesBurnedGoalMeta,
          caloriesBurnedGoal.isAcceptableOrUnknown(
              data['calories_burned_goal']!, _caloriesBurnedGoalMeta));
    }
    if (data.containsKey('active_minutes_goal')) {
      context.handle(
          _activeMinutesGoalMeta,
          activeMinutesGoal.isAcceptableOrUnknown(
              data['active_minutes_goal']!, _activeMinutesGoalMeta));
    }
    if (data.containsKey('distance_goal')) {
      context.handle(
          _distanceGoalMeta,
          distanceGoal.isAcceptableOrUnknown(
              data['distance_goal']!, _distanceGoalMeta));
    }
    if (data.containsKey('workouts_per_week_goal')) {
      context.handle(
          _workoutsPerWeekGoalMeta,
          workoutsPerWeekGoal.isAcceptableOrUnknown(
              data['workouts_per_week_goal']!, _workoutsPerWeekGoalMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  ActivityGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityGoal(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      stepsGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps_goal'])!,
      caloriesBurnedGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}calories_burned_goal'])!,
      activeMinutesGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}active_minutes_goal'])!,
      distanceGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}distance_goal'])!,
      workoutsPerWeekGoal: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}workouts_per_week_goal'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ActivityGoalsTable createAlias(String alias) {
    return $ActivityGoalsTable(attachedDatabase, alias);
  }
}

class ActivityGoal extends DataClass implements Insertable<ActivityGoal> {
  final String userId;
  final int stepsGoal;
  final int caloriesBurnedGoal;
  final int activeMinutesGoal;
  final int distanceGoal;
  final int workoutsPerWeekGoal;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ActivityGoal(
      {required this.userId,
      required this.stepsGoal,
      required this.caloriesBurnedGoal,
      required this.activeMinutesGoal,
      required this.distanceGoal,
      required this.workoutsPerWeekGoal,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['steps_goal'] = Variable<int>(stepsGoal);
    map['calories_burned_goal'] = Variable<int>(caloriesBurnedGoal);
    map['active_minutes_goal'] = Variable<int>(activeMinutesGoal);
    map['distance_goal'] = Variable<int>(distanceGoal);
    map['workouts_per_week_goal'] = Variable<int>(workoutsPerWeekGoal);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ActivityGoalsCompanion toCompanion(bool nullToAbsent) {
    return ActivityGoalsCompanion(
      userId: Value(userId),
      stepsGoal: Value(stepsGoal),
      caloriesBurnedGoal: Value(caloriesBurnedGoal),
      activeMinutesGoal: Value(activeMinutesGoal),
      distanceGoal: Value(distanceGoal),
      workoutsPerWeekGoal: Value(workoutsPerWeekGoal),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ActivityGoal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityGoal(
      userId: serializer.fromJson<String>(json['userId']),
      stepsGoal: serializer.fromJson<int>(json['stepsGoal']),
      caloriesBurnedGoal: serializer.fromJson<int>(json['caloriesBurnedGoal']),
      activeMinutesGoal: serializer.fromJson<int>(json['activeMinutesGoal']),
      distanceGoal: serializer.fromJson<int>(json['distanceGoal']),
      workoutsPerWeekGoal:
          serializer.fromJson<int>(json['workoutsPerWeekGoal']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'stepsGoal': serializer.toJson<int>(stepsGoal),
      'caloriesBurnedGoal': serializer.toJson<int>(caloriesBurnedGoal),
      'activeMinutesGoal': serializer.toJson<int>(activeMinutesGoal),
      'distanceGoal': serializer.toJson<int>(distanceGoal),
      'workoutsPerWeekGoal': serializer.toJson<int>(workoutsPerWeekGoal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ActivityGoal copyWith(
          {String? userId,
          int? stepsGoal,
          int? caloriesBurnedGoal,
          int? activeMinutesGoal,
          int? distanceGoal,
          int? workoutsPerWeekGoal,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ActivityGoal(
        userId: userId ?? this.userId,
        stepsGoal: stepsGoal ?? this.stepsGoal,
        caloriesBurnedGoal: caloriesBurnedGoal ?? this.caloriesBurnedGoal,
        activeMinutesGoal: activeMinutesGoal ?? this.activeMinutesGoal,
        distanceGoal: distanceGoal ?? this.distanceGoal,
        workoutsPerWeekGoal: workoutsPerWeekGoal ?? this.workoutsPerWeekGoal,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ActivityGoal copyWithCompanion(ActivityGoalsCompanion data) {
    return ActivityGoal(
      userId: data.userId.present ? data.userId.value : this.userId,
      stepsGoal: data.stepsGoal.present ? data.stepsGoal.value : this.stepsGoal,
      caloriesBurnedGoal: data.caloriesBurnedGoal.present
          ? data.caloriesBurnedGoal.value
          : this.caloriesBurnedGoal,
      activeMinutesGoal: data.activeMinutesGoal.present
          ? data.activeMinutesGoal.value
          : this.activeMinutesGoal,
      distanceGoal: data.distanceGoal.present
          ? data.distanceGoal.value
          : this.distanceGoal,
      workoutsPerWeekGoal: data.workoutsPerWeekGoal.present
          ? data.workoutsPerWeekGoal.value
          : this.workoutsPerWeekGoal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityGoal(')
          ..write('userId: $userId, ')
          ..write('stepsGoal: $stepsGoal, ')
          ..write('caloriesBurnedGoal: $caloriesBurnedGoal, ')
          ..write('activeMinutesGoal: $activeMinutesGoal, ')
          ..write('distanceGoal: $distanceGoal, ')
          ..write('workoutsPerWeekGoal: $workoutsPerWeekGoal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId,
      stepsGoal,
      caloriesBurnedGoal,
      activeMinutesGoal,
      distanceGoal,
      workoutsPerWeekGoal,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityGoal &&
          other.userId == this.userId &&
          other.stepsGoal == this.stepsGoal &&
          other.caloriesBurnedGoal == this.caloriesBurnedGoal &&
          other.activeMinutesGoal == this.activeMinutesGoal &&
          other.distanceGoal == this.distanceGoal &&
          other.workoutsPerWeekGoal == this.workoutsPerWeekGoal &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ActivityGoalsCompanion extends UpdateCompanion<ActivityGoal> {
  final Value<String> userId;
  final Value<int> stepsGoal;
  final Value<int> caloriesBurnedGoal;
  final Value<int> activeMinutesGoal;
  final Value<int> distanceGoal;
  final Value<int> workoutsPerWeekGoal;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ActivityGoalsCompanion({
    this.userId = const Value.absent(),
    this.stepsGoal = const Value.absent(),
    this.caloriesBurnedGoal = const Value.absent(),
    this.activeMinutesGoal = const Value.absent(),
    this.distanceGoal = const Value.absent(),
    this.workoutsPerWeekGoal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityGoalsCompanion.insert({
    required String userId,
    this.stepsGoal = const Value.absent(),
    this.caloriesBurnedGoal = const Value.absent(),
    this.activeMinutesGoal = const Value.absent(),
    this.distanceGoal = const Value.absent(),
    this.workoutsPerWeekGoal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<ActivityGoal> custom({
    Expression<String>? userId,
    Expression<int>? stepsGoal,
    Expression<int>? caloriesBurnedGoal,
    Expression<int>? activeMinutesGoal,
    Expression<int>? distanceGoal,
    Expression<int>? workoutsPerWeekGoal,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (stepsGoal != null) 'steps_goal': stepsGoal,
      if (caloriesBurnedGoal != null)
        'calories_burned_goal': caloriesBurnedGoal,
      if (activeMinutesGoal != null) 'active_minutes_goal': activeMinutesGoal,
      if (distanceGoal != null) 'distance_goal': distanceGoal,
      if (workoutsPerWeekGoal != null)
        'workouts_per_week_goal': workoutsPerWeekGoal,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityGoalsCompanion copyWith(
      {Value<String>? userId,
      Value<int>? stepsGoal,
      Value<int>? caloriesBurnedGoal,
      Value<int>? activeMinutesGoal,
      Value<int>? distanceGoal,
      Value<int>? workoutsPerWeekGoal,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ActivityGoalsCompanion(
      userId: userId ?? this.userId,
      stepsGoal: stepsGoal ?? this.stepsGoal,
      caloriesBurnedGoal: caloriesBurnedGoal ?? this.caloriesBurnedGoal,
      activeMinutesGoal: activeMinutesGoal ?? this.activeMinutesGoal,
      distanceGoal: distanceGoal ?? this.distanceGoal,
      workoutsPerWeekGoal: workoutsPerWeekGoal ?? this.workoutsPerWeekGoal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (stepsGoal.present) {
      map['steps_goal'] = Variable<int>(stepsGoal.value);
    }
    if (caloriesBurnedGoal.present) {
      map['calories_burned_goal'] = Variable<int>(caloriesBurnedGoal.value);
    }
    if (activeMinutesGoal.present) {
      map['active_minutes_goal'] = Variable<int>(activeMinutesGoal.value);
    }
    if (distanceGoal.present) {
      map['distance_goal'] = Variable<int>(distanceGoal.value);
    }
    if (workoutsPerWeekGoal.present) {
      map['workouts_per_week_goal'] = Variable<int>(workoutsPerWeekGoal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityGoalsCompanion(')
          ..write('userId: $userId, ')
          ..write('stepsGoal: $stepsGoal, ')
          ..write('caloriesBurnedGoal: $caloriesBurnedGoal, ')
          ..write('activeMinutesGoal: $activeMinutesGoal, ')
          ..write('distanceGoal: $distanceGoal, ')
          ..write('workoutsPerWeekGoal: $workoutsPerWeekGoal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightRecordsTable extends WeightRecords
    with TableInfo<$WeightRecordsTable, WeightRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _bodyFatPercentageMeta =
      const VerificationMeta('bodyFatPercentage');
  @override
  late final GeneratedColumn<double> bodyFatPercentage =
      GeneratedColumn<double>('body_fat_percentage', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _muscleMassMeta =
      const VerificationMeta('muscleMass');
  @override
  late final GeneratedColumn<double> muscleMass = GeneratedColumn<double>(
      'muscle_mass', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _visceralFatMeta =
      const VerificationMeta('visceralFat');
  @override
  late final GeneratedColumn<double> visceralFat = GeneratedColumn<double>(
      'visceral_fat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _bmiMeta = const VerificationMeta('bmi');
  @override
  late final GeneratedColumn<double> bmi = GeneratedColumn<double>(
      'bmi', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        date,
        weight,
        bodyFatPercentage,
        muscleMass,
        visceralFat,
        bmi,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_records';
  @override
  VerificationContext validateIntegrity(Insertable<WeightRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('body_fat_percentage')) {
      context.handle(
          _bodyFatPercentageMeta,
          bodyFatPercentage.isAcceptableOrUnknown(
              data['body_fat_percentage']!, _bodyFatPercentageMeta));
    }
    if (data.containsKey('muscle_mass')) {
      context.handle(
          _muscleMassMeta,
          muscleMass.isAcceptableOrUnknown(
              data['muscle_mass']!, _muscleMassMeta));
    }
    if (data.containsKey('visceral_fat')) {
      context.handle(
          _visceralFatMeta,
          visceralFat.isAcceptableOrUnknown(
              data['visceral_fat']!, _visceralFatMeta));
    }
    if (data.containsKey('bmi')) {
      context.handle(
          _bmiMeta, bmi.isAcceptableOrUnknown(data['bmi']!, _bmiMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      bodyFatPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}body_fat_percentage']),
      muscleMass: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}muscle_mass']),
      visceralFat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}visceral_fat']),
      bmi: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bmi']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $WeightRecordsTable createAlias(String alias) {
    return $WeightRecordsTable(attachedDatabase, alias);
  }
}

class WeightRecord extends DataClass implements Insertable<WeightRecord> {
  final int id;
  final String userId;
  final DateTime date;
  final double weight;
  final double? bodyFatPercentage;
  final double? muscleMass;
  final double? visceralFat;
  final double? bmi;
  final String? notes;
  final DateTime createdAt;
  const WeightRecord(
      {required this.id,
      required this.userId,
      required this.date,
      required this.weight,
      this.bodyFatPercentage,
      this.muscleMass,
      this.visceralFat,
      this.bmi,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || bodyFatPercentage != null) {
      map['body_fat_percentage'] = Variable<double>(bodyFatPercentage);
    }
    if (!nullToAbsent || muscleMass != null) {
      map['muscle_mass'] = Variable<double>(muscleMass);
    }
    if (!nullToAbsent || visceralFat != null) {
      map['visceral_fat'] = Variable<double>(visceralFat);
    }
    if (!nullToAbsent || bmi != null) {
      map['bmi'] = Variable<double>(bmi);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WeightRecordsCompanion toCompanion(bool nullToAbsent) {
    return WeightRecordsCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      weight: Value(weight),
      bodyFatPercentage: bodyFatPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPercentage),
      muscleMass: muscleMass == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleMass),
      visceralFat: visceralFat == null && nullToAbsent
          ? const Value.absent()
          : Value(visceralFat),
      bmi: bmi == null && nullToAbsent ? const Value.absent() : Value(bmi),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory WeightRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightRecord(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
      bodyFatPercentage:
          serializer.fromJson<double?>(json['bodyFatPercentage']),
      muscleMass: serializer.fromJson<double?>(json['muscleMass']),
      visceralFat: serializer.fromJson<double?>(json['visceralFat']),
      bmi: serializer.fromJson<double?>(json['bmi']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
      'bodyFatPercentage': serializer.toJson<double?>(bodyFatPercentage),
      'muscleMass': serializer.toJson<double?>(muscleMass),
      'visceralFat': serializer.toJson<double?>(visceralFat),
      'bmi': serializer.toJson<double?>(bmi),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WeightRecord copyWith(
          {int? id,
          String? userId,
          DateTime? date,
          double? weight,
          Value<double?> bodyFatPercentage = const Value.absent(),
          Value<double?> muscleMass = const Value.absent(),
          Value<double?> visceralFat = const Value.absent(),
          Value<double?> bmi = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      WeightRecord(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        weight: weight ?? this.weight,
        bodyFatPercentage: bodyFatPercentage.present
            ? bodyFatPercentage.value
            : this.bodyFatPercentage,
        muscleMass: muscleMass.present ? muscleMass.value : this.muscleMass,
        visceralFat: visceralFat.present ? visceralFat.value : this.visceralFat,
        bmi: bmi.present ? bmi.value : this.bmi,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  WeightRecord copyWithCompanion(WeightRecordsCompanion data) {
    return WeightRecord(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      bodyFatPercentage: data.bodyFatPercentage.present
          ? data.bodyFatPercentage.value
          : this.bodyFatPercentage,
      muscleMass:
          data.muscleMass.present ? data.muscleMass.value : this.muscleMass,
      visceralFat:
          data.visceralFat.present ? data.visceralFat.value : this.visceralFat,
      bmi: data.bmi.present ? data.bmi.value : this.bmi,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecord(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bodyFatPercentage: $bodyFatPercentage, ')
          ..write('muscleMass: $muscleMass, ')
          ..write('visceralFat: $visceralFat, ')
          ..write('bmi: $bmi, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, date, weight, bodyFatPercentage,
      muscleMass, visceralFat, bmi, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightRecord &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.bodyFatPercentage == this.bodyFatPercentage &&
          other.muscleMass == this.muscleMass &&
          other.visceralFat == this.visceralFat &&
          other.bmi == this.bmi &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class WeightRecordsCompanion extends UpdateCompanion<WeightRecord> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<double> weight;
  final Value<double?> bodyFatPercentage;
  final Value<double?> muscleMass;
  final Value<double?> visceralFat;
  final Value<double?> bmi;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const WeightRecordsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.bodyFatPercentage = const Value.absent(),
    this.muscleMass = const Value.absent(),
    this.visceralFat = const Value.absent(),
    this.bmi = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WeightRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime date,
    required double weight,
    this.bodyFatPercentage = const Value.absent(),
    this.muscleMass = const Value.absent(),
    this.visceralFat = const Value.absent(),
    this.bmi = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        date = Value(date),
        weight = Value(weight);
  static Insertable<WeightRecord> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<double>? bodyFatPercentage,
    Expression<double>? muscleMass,
    Expression<double>? visceralFat,
    Expression<double>? bmi,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (bodyFatPercentage != null) 'body_fat_percentage': bodyFatPercentage,
      if (muscleMass != null) 'muscle_mass': muscleMass,
      if (visceralFat != null) 'visceral_fat': visceralFat,
      if (bmi != null) 'bmi': bmi,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WeightRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<DateTime>? date,
      Value<double>? weight,
      Value<double?>? bodyFatPercentage,
      Value<double?>? muscleMass,
      Value<double?>? visceralFat,
      Value<double?>? bmi,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return WeightRecordsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      muscleMass: muscleMass ?? this.muscleMass,
      visceralFat: visceralFat ?? this.visceralFat,
      bmi: bmi ?? this.bmi,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (bodyFatPercentage.present) {
      map['body_fat_percentage'] = Variable<double>(bodyFatPercentage.value);
    }
    if (muscleMass.present) {
      map['muscle_mass'] = Variable<double>(muscleMass.value);
    }
    if (visceralFat.present) {
      map['visceral_fat'] = Variable<double>(visceralFat.value);
    }
    if (bmi.present) {
      map['bmi'] = Variable<double>(bmi.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecordsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bodyFatPercentage: $bodyFatPercentage, ')
          ..write('muscleMass: $muscleMass, ')
          ..write('visceralFat: $visceralFat, ')
          ..write('bmi: $bmi, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodsTable foods = $FoodsTable(this);
  late final $FoodSynonymsTable foodSynonyms = $FoodSynonymsTable(this);
  late final $CommonPortionsTable commonPortions = $CommonPortionsTable(this);
  late final $FoodEntriesTable foodEntries = $FoodEntriesTable(this);
  late final $FavoritePortionsTable favoritePortions =
      $FavoritePortionsTable(this);
  late final $DailyNutritionSummariesTable dailyNutritionSummaries =
      $DailyNutritionSummariesTable(this);
  late final $RecognitionHistoriesTable recognitionHistories =
      $RecognitionHistoriesTable(this);
  late final $RecognitionResultsTable recognitionResults =
      $RecognitionResultsTable(this);
  late final $RecognitionFeedbacksTable recognitionFeedbacks =
      $RecognitionFeedbacksTable(this);
  late final $UserPreferencesTable userPreferences =
      $UserPreferencesTable(this);
  late final $CustomFoodsTable customFoods = $CustomFoodsTable(this);
  late final $UserFoodStatisticsTable userFoodStatistics =
      $UserFoodStatisticsTable(this);
  late final $DailyActivitiesTable dailyActivities =
      $DailyActivitiesTable(this);
  late final $WorkoutSessionsTable workoutSessions =
      $WorkoutSessionsTable(this);
  late final $ActivityGoalsTable activityGoals = $ActivityGoalsTable(this);
  late final $WeightRecordsTable weightRecords = $WeightRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        foods,
        foodSynonyms,
        commonPortions,
        foodEntries,
        favoritePortions,
        dailyNutritionSummaries,
        recognitionHistories,
        recognitionResults,
        recognitionFeedbacks,
        userPreferences,
        customFoods,
        userFoodStatistics,
        dailyActivities,
        workoutSessions,
        activityGoals,
        weightRecords
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('foods',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('food_synonyms', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('foods',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('common_portions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('foods',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('favorite_portions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('recognition_histories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('recognition_results', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('recognition_results',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('recognition_feedbacks', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$FoodsTableCreateCompanionBuilder = FoodsCompanion Function({
  Value<int> id,
  required String nameKo,
  Value<String?> nameEn,
  required String category,
  Value<String?> subcategory,
  Value<String?> brand,
  Value<double> kcalPer100g,
  Value<double> carbsPer100g,
  Value<double> proteinPer100g,
  Value<double> fatPer100g,
  Value<double> fiberPer100g,
  Value<double?> sugarPer100g,
  Value<double?> sodiumPer100g,
  Value<String?> description,
  Value<String?> ingredients,
  Value<String?> allergens,
  Value<bool> isVerified,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$FoodsTableUpdateCompanionBuilder = FoodsCompanion Function({
  Value<int> id,
  Value<String> nameKo,
  Value<String?> nameEn,
  Value<String> category,
  Value<String?> subcategory,
  Value<String?> brand,
  Value<double> kcalPer100g,
  Value<double> carbsPer100g,
  Value<double> proteinPer100g,
  Value<double> fatPer100g,
  Value<double> fiberPer100g,
  Value<double?> sugarPer100g,
  Value<double?> sodiumPer100g,
  Value<String?> description,
  Value<String?> ingredients,
  Value<String?> allergens,
  Value<bool> isVerified,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$FoodsTableReferences
    extends BaseReferences<_$AppDatabase, $FoodsTable, Food> {
  $$FoodsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FoodSynonymsTable, List<FoodSynonym>>
      _foodSynonymsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.foodSynonyms,
          aliasName: $_aliasNameGenerator(db.foods.id, db.foodSynonyms.foodId));

  $$FoodSynonymsTableProcessedTableManager get foodSynonymsRefs {
    final manager = $$FoodSynonymsTableTableManager($_db, $_db.foodSynonyms)
        .filter((f) => f.foodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_foodSynonymsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CommonPortionsTable, List<CommonPortion>>
      _commonPortionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.commonPortions,
              aliasName:
                  $_aliasNameGenerator(db.foods.id, db.commonPortions.foodId));

  $$CommonPortionsTableProcessedTableManager get commonPortionsRefs {
    final manager = $$CommonPortionsTableTableManager($_db, $_db.commonPortions)
        .filter((f) => f.foodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_commonPortionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FoodEntriesTable, List<FoodEntry>>
      _foodEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.foodEntries,
          aliasName: $_aliasNameGenerator(db.foods.id, db.foodEntries.foodId));

  $$FoodEntriesTableProcessedTableManager get foodEntriesRefs {
    final manager = $$FoodEntriesTableTableManager($_db, $_db.foodEntries)
        .filter((f) => f.foodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_foodEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FavoritePortionsTable, List<FavoritePortion>>
      _favoritePortionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.favoritePortions,
              aliasName: $_aliasNameGenerator(
                  db.foods.id, db.favoritePortions.foodId));

  $$FavoritePortionsTableProcessedTableManager get favoritePortionsRefs {
    final manager =
        $$FavoritePortionsTableTableManager($_db, $_db.favoritePortions)
            .filter((f) => f.foodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_favoritePortionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FoodsTableFilterComposer extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameKo => $composableBuilder(
      column: $table.nameKo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subcategory => $composableBuilder(
      column: $table.subcategory, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get kcalPer100g => $composableBuilder(
      column: $table.kcalPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
      column: $table.carbsPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
      column: $table.proteinPer100g,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatPer100g => $composableBuilder(
      column: $table.fatPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fiberPer100g => $composableBuilder(
      column: $table.fiberPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sugarPer100g => $composableBuilder(
      column: $table.sugarPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sodiumPer100g => $composableBuilder(
      column: $table.sodiumPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ingredients => $composableBuilder(
      column: $table.ingredients, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get allergens => $composableBuilder(
      column: $table.allergens, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> foodSynonymsRefs(
      Expression<bool> Function($$FoodSynonymsTableFilterComposer f) f) {
    final $$FoodSynonymsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.foodSynonyms,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodSynonymsTableFilterComposer(
              $db: $db,
              $table: $db.foodSynonyms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> commonPortionsRefs(
      Expression<bool> Function($$CommonPortionsTableFilterComposer f) f) {
    final $$CommonPortionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.commonPortions,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommonPortionsTableFilterComposer(
              $db: $db,
              $table: $db.commonPortions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> foodEntriesRefs(
      Expression<bool> Function($$FoodEntriesTableFilterComposer f) f) {
    final $$FoodEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.foodEntries,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodEntriesTableFilterComposer(
              $db: $db,
              $table: $db.foodEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> favoritePortionsRefs(
      Expression<bool> Function($$FavoritePortionsTableFilterComposer f) f) {
    final $$FavoritePortionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoritePortions,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavoritePortionsTableFilterComposer(
              $db: $db,
              $table: $db.favoritePortions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameKo => $composableBuilder(
      column: $table.nameKo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subcategory => $composableBuilder(
      column: $table.subcategory, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get kcalPer100g => $composableBuilder(
      column: $table.kcalPer100g, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
      column: $table.carbsPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
      column: $table.proteinPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
      column: $table.fatPer100g, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fiberPer100g => $composableBuilder(
      column: $table.fiberPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sugarPer100g => $composableBuilder(
      column: $table.sugarPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sodiumPer100g => $composableBuilder(
      column: $table.sodiumPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ingredients => $composableBuilder(
      column: $table.ingredients, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get allergens => $composableBuilder(
      column: $table.allergens, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$FoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodsTable> {
  $$FoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameKo =>
      $composableBuilder(column: $table.nameKo, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get subcategory => $composableBuilder(
      column: $table.subcategory, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<double> get kcalPer100g => $composableBuilder(
      column: $table.kcalPer100g, builder: (column) => column);

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
      column: $table.carbsPer100g, builder: (column) => column);

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
      column: $table.proteinPer100g, builder: (column) => column);

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
      column: $table.fatPer100g, builder: (column) => column);

  GeneratedColumn<double> get fiberPer100g => $composableBuilder(
      column: $table.fiberPer100g, builder: (column) => column);

  GeneratedColumn<double> get sugarPer100g => $composableBuilder(
      column: $table.sugarPer100g, builder: (column) => column);

  GeneratedColumn<double> get sodiumPer100g => $composableBuilder(
      column: $table.sodiumPer100g, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get ingredients => $composableBuilder(
      column: $table.ingredients, builder: (column) => column);

  GeneratedColumn<String> get allergens =>
      $composableBuilder(column: $table.allergens, builder: (column) => column);

  GeneratedColumn<bool> get isVerified => $composableBuilder(
      column: $table.isVerified, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> foodSynonymsRefs<T extends Object>(
      Expression<T> Function($$FoodSynonymsTableAnnotationComposer a) f) {
    final $$FoodSynonymsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.foodSynonyms,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodSynonymsTableAnnotationComposer(
              $db: $db,
              $table: $db.foodSynonyms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> commonPortionsRefs<T extends Object>(
      Expression<T> Function($$CommonPortionsTableAnnotationComposer a) f) {
    final $$CommonPortionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.commonPortions,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommonPortionsTableAnnotationComposer(
              $db: $db,
              $table: $db.commonPortions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> foodEntriesRefs<T extends Object>(
      Expression<T> Function($$FoodEntriesTableAnnotationComposer a) f) {
    final $$FoodEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.foodEntries,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.foodEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> favoritePortionsRefs<T extends Object>(
      Expression<T> Function($$FavoritePortionsTableAnnotationComposer a) f) {
    final $$FavoritePortionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoritePortions,
        getReferencedColumn: (t) => t.foodId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavoritePortionsTableAnnotationComposer(
              $db: $db,
              $table: $db.favoritePortions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodsTable,
    Food,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (Food, $$FoodsTableReferences),
    Food,
    PrefetchHooks Function(
        {bool foodSynonymsRefs,
        bool commonPortionsRefs,
        bool foodEntriesRefs,
        bool favoritePortionsRefs})> {
  $$FoodsTableTableManager(_$AppDatabase db, $FoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nameKo = const Value.absent(),
            Value<String?> nameEn = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> subcategory = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<double> kcalPer100g = const Value.absent(),
            Value<double> carbsPer100g = const Value.absent(),
            Value<double> proteinPer100g = const Value.absent(),
            Value<double> fatPer100g = const Value.absent(),
            Value<double> fiberPer100g = const Value.absent(),
            Value<double?> sugarPer100g = const Value.absent(),
            Value<double?> sodiumPer100g = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> ingredients = const Value.absent(),
            Value<String?> allergens = const Value.absent(),
            Value<bool> isVerified = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              FoodsCompanion(
            id: id,
            nameKo: nameKo,
            nameEn: nameEn,
            category: category,
            subcategory: subcategory,
            brand: brand,
            kcalPer100g: kcalPer100g,
            carbsPer100g: carbsPer100g,
            proteinPer100g: proteinPer100g,
            fatPer100g: fatPer100g,
            fiberPer100g: fiberPer100g,
            sugarPer100g: sugarPer100g,
            sodiumPer100g: sodiumPer100g,
            description: description,
            ingredients: ingredients,
            allergens: allergens,
            isVerified: isVerified,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nameKo,
            Value<String?> nameEn = const Value.absent(),
            required String category,
            Value<String?> subcategory = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<double> kcalPer100g = const Value.absent(),
            Value<double> carbsPer100g = const Value.absent(),
            Value<double> proteinPer100g = const Value.absent(),
            Value<double> fatPer100g = const Value.absent(),
            Value<double> fiberPer100g = const Value.absent(),
            Value<double?> sugarPer100g = const Value.absent(),
            Value<double?> sodiumPer100g = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> ingredients = const Value.absent(),
            Value<String?> allergens = const Value.absent(),
            Value<bool> isVerified = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              FoodsCompanion.insert(
            id: id,
            nameKo: nameKo,
            nameEn: nameEn,
            category: category,
            subcategory: subcategory,
            brand: brand,
            kcalPer100g: kcalPer100g,
            carbsPer100g: carbsPer100g,
            proteinPer100g: proteinPer100g,
            fatPer100g: fatPer100g,
            fiberPer100g: fiberPer100g,
            sugarPer100g: sugarPer100g,
            sodiumPer100g: sodiumPer100g,
            description: description,
            ingredients: ingredients,
            allergens: allergens,
            isVerified: isVerified,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FoodsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {foodSynonymsRefs = false,
              commonPortionsRefs = false,
              foodEntriesRefs = false,
              favoritePortionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (foodSynonymsRefs) db.foodSynonyms,
                if (commonPortionsRefs) db.commonPortions,
                if (foodEntriesRefs) db.foodEntries,
                if (favoritePortionsRefs) db.favoritePortions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (foodSynonymsRefs)
                    await $_getPrefetchedData<Food, $FoodsTable, FoodSynonym>(
                        currentTable: table,
                        referencedTable:
                            $$FoodsTableReferences._foodSynonymsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FoodsTableReferences(db, table, p0)
                                .foodSynonymsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.foodId == item.id),
                        typedResults: items),
                  if (commonPortionsRefs)
                    await $_getPrefetchedData<Food, $FoodsTable, CommonPortion>(
                        currentTable: table,
                        referencedTable:
                            $$FoodsTableReferences._commonPortionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FoodsTableReferences(db, table, p0)
                                .commonPortionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.foodId == item.id),
                        typedResults: items),
                  if (foodEntriesRefs)
                    await $_getPrefetchedData<Food, $FoodsTable, FoodEntry>(
                        currentTable: table,
                        referencedTable:
                            $$FoodsTableReferences._foodEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FoodsTableReferences(db, table, p0)
                                .foodEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.foodId == item.id),
                        typedResults: items),
                  if (favoritePortionsRefs)
                    await $_getPrefetchedData<Food, $FoodsTable,
                            FavoritePortion>(
                        currentTable: table,
                        referencedTable: $$FoodsTableReferences
                            ._favoritePortionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FoodsTableReferences(db, table, p0)
                                .favoritePortionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.foodId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodsTable,
    Food,
    $$FoodsTableFilterComposer,
    $$FoodsTableOrderingComposer,
    $$FoodsTableAnnotationComposer,
    $$FoodsTableCreateCompanionBuilder,
    $$FoodsTableUpdateCompanionBuilder,
    (Food, $$FoodsTableReferences),
    Food,
    PrefetchHooks Function(
        {bool foodSynonymsRefs,
        bool commonPortionsRefs,
        bool foodEntriesRefs,
        bool favoritePortionsRefs})>;
typedef $$FoodSynonymsTableCreateCompanionBuilder = FoodSynonymsCompanion
    Function({
  Value<int> id,
  required int foodId,
  required String synonym,
  required String type,
  Value<DateTime> createdAt,
});
typedef $$FoodSynonymsTableUpdateCompanionBuilder = FoodSynonymsCompanion
    Function({
  Value<int> id,
  Value<int> foodId,
  Value<String> synonym,
  Value<String> type,
  Value<DateTime> createdAt,
});

final class $$FoodSynonymsTableReferences
    extends BaseReferences<_$AppDatabase, $FoodSynonymsTable, FoodSynonym> {
  $$FoodSynonymsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FoodsTable _foodIdTable(_$AppDatabase db) => db.foods
      .createAlias($_aliasNameGenerator(db.foodSynonyms.foodId, db.foods.id));

  $$FoodsTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<int>('food_id')!;

    final manager = $$FoodsTableTableManager($_db, $_db.foods)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FoodSynonymsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodSynonymsTable> {
  $$FoodSynonymsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get synonym => $composableBuilder(
      column: $table.synonym, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$FoodsTableFilterComposer get foodId {
    final $$FoodsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableFilterComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FoodSynonymsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodSynonymsTable> {
  $$FoodSynonymsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get synonym => $composableBuilder(
      column: $table.synonym, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$FoodsTableOrderingComposer get foodId {
    final $$FoodsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableOrderingComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FoodSynonymsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodSynonymsTable> {
  $$FoodSynonymsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get synonym =>
      $composableBuilder(column: $table.synonym, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FoodsTableAnnotationComposer get foodId {
    final $$FoodsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableAnnotationComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FoodSynonymsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodSynonymsTable,
    FoodSynonym,
    $$FoodSynonymsTableFilterComposer,
    $$FoodSynonymsTableOrderingComposer,
    $$FoodSynonymsTableAnnotationComposer,
    $$FoodSynonymsTableCreateCompanionBuilder,
    $$FoodSynonymsTableUpdateCompanionBuilder,
    (FoodSynonym, $$FoodSynonymsTableReferences),
    FoodSynonym,
    PrefetchHooks Function({bool foodId})> {
  $$FoodSynonymsTableTableManager(_$AppDatabase db, $FoodSynonymsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodSynonymsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodSynonymsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodSynonymsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<String> synonym = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FoodSynonymsCompanion(
            id: id,
            foodId: foodId,
            synonym: synonym,
            type: type,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int foodId,
            required String synonym,
            required String type,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FoodSynonymsCompanion.insert(
            id: id,
            foodId: foodId,
            synonym: synonym,
            type: type,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FoodSynonymsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (foodId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.foodId,
                    referencedTable:
                        $$FoodSynonymsTableReferences._foodIdTable(db),
                    referencedColumn:
                        $$FoodSynonymsTableReferences._foodIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FoodSynonymsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodSynonymsTable,
    FoodSynonym,
    $$FoodSynonymsTableFilterComposer,
    $$FoodSynonymsTableOrderingComposer,
    $$FoodSynonymsTableAnnotationComposer,
    $$FoodSynonymsTableCreateCompanionBuilder,
    $$FoodSynonymsTableUpdateCompanionBuilder,
    (FoodSynonym, $$FoodSynonymsTableReferences),
    FoodSynonym,
    PrefetchHooks Function({bool foodId})>;
typedef $$CommonPortionsTableCreateCompanionBuilder = CommonPortionsCompanion
    Function({
  Value<int> id,
  required int foodId,
  required String portionName,
  required double gramAmount,
  Value<String?> description,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
});
typedef $$CommonPortionsTableUpdateCompanionBuilder = CommonPortionsCompanion
    Function({
  Value<int> id,
  Value<int> foodId,
  Value<String> portionName,
  Value<double> gramAmount,
  Value<String?> description,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
});

final class $$CommonPortionsTableReferences
    extends BaseReferences<_$AppDatabase, $CommonPortionsTable, CommonPortion> {
  $$CommonPortionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FoodsTable _foodIdTable(_$AppDatabase db) => db.foods
      .createAlias($_aliasNameGenerator(db.commonPortions.foodId, db.foods.id));

  $$FoodsTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<int>('food_id')!;

    final manager = $$FoodsTableTableManager($_db, $_db.foods)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CommonPortionsTableFilterComposer
    extends Composer<_$AppDatabase, $CommonPortionsTable> {
  $$CommonPortionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get portionName => $composableBuilder(
      column: $table.portionName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gramAmount => $composableBuilder(
      column: $table.gramAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$FoodsTableFilterComposer get foodId {
    final $$FoodsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableFilterComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommonPortionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommonPortionsTable> {
  $$CommonPortionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get portionName => $composableBuilder(
      column: $table.portionName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gramAmount => $composableBuilder(
      column: $table.gramAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$FoodsTableOrderingComposer get foodId {
    final $$FoodsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableOrderingComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommonPortionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommonPortionsTable> {
  $$CommonPortionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get portionName => $composableBuilder(
      column: $table.portionName, builder: (column) => column);

  GeneratedColumn<double> get gramAmount => $composableBuilder(
      column: $table.gramAmount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FoodsTableAnnotationComposer get foodId {
    final $$FoodsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableAnnotationComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommonPortionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommonPortionsTable,
    CommonPortion,
    $$CommonPortionsTableFilterComposer,
    $$CommonPortionsTableOrderingComposer,
    $$CommonPortionsTableAnnotationComposer,
    $$CommonPortionsTableCreateCompanionBuilder,
    $$CommonPortionsTableUpdateCompanionBuilder,
    (CommonPortion, $$CommonPortionsTableReferences),
    CommonPortion,
    PrefetchHooks Function({bool foodId})> {
  $$CommonPortionsTableTableManager(
      _$AppDatabase db, $CommonPortionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommonPortionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommonPortionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommonPortionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<String> portionName = const Value.absent(),
            Value<double> gramAmount = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CommonPortionsCompanion(
            id: id,
            foodId: foodId,
            portionName: portionName,
            gramAmount: gramAmount,
            description: description,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int foodId,
            required String portionName,
            required double gramAmount,
            Value<String?> description = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CommonPortionsCompanion.insert(
            id: id,
            foodId: foodId,
            portionName: portionName,
            gramAmount: gramAmount,
            description: description,
            isDefault: isDefault,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CommonPortionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (foodId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.foodId,
                    referencedTable:
                        $$CommonPortionsTableReferences._foodIdTable(db),
                    referencedColumn:
                        $$CommonPortionsTableReferences._foodIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CommonPortionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CommonPortionsTable,
    CommonPortion,
    $$CommonPortionsTableFilterComposer,
    $$CommonPortionsTableOrderingComposer,
    $$CommonPortionsTableAnnotationComposer,
    $$CommonPortionsTableCreateCompanionBuilder,
    $$CommonPortionsTableUpdateCompanionBuilder,
    (CommonPortion, $$CommonPortionsTableReferences),
    CommonPortion,
    PrefetchHooks Function({bool foodId})>;
typedef $$FoodEntriesTableCreateCompanionBuilder = FoodEntriesCompanion
    Function({
  Value<int> id,
  required String userId,
  required int foodId,
  required String mealType,
  required DateTime timestamp,
  required double portionGrams,
  Value<String?> portionDescription,
  required double totalCalories,
  required double totalCarbs,
  required double totalProtein,
  required double totalFat,
  required double totalFiber,
  Value<String?> notes,
  Value<String?> imageUrl,
  Value<bool> isFromAI,
  Value<int?> recognitionHistoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$FoodEntriesTableUpdateCompanionBuilder = FoodEntriesCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<int> foodId,
  Value<String> mealType,
  Value<DateTime> timestamp,
  Value<double> portionGrams,
  Value<String?> portionDescription,
  Value<double> totalCalories,
  Value<double> totalCarbs,
  Value<double> totalProtein,
  Value<double> totalFat,
  Value<double> totalFiber,
  Value<String?> notes,
  Value<String?> imageUrl,
  Value<bool> isFromAI,
  Value<int?> recognitionHistoryId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$FoodEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntry> {
  $$FoodEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FoodsTable _foodIdTable(_$AppDatabase db) => db.foods
      .createAlias($_aliasNameGenerator(db.foodEntries.foodId, db.foods.id));

  $$FoodsTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<int>('food_id')!;

    final manager = $$FoodsTableTableManager($_db, $_db.foods)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FoodEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get portionDescription => $composableBuilder(
      column: $table.portionDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCalories => $composableBuilder(
      column: $table.totalCalories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCarbs => $composableBuilder(
      column: $table.totalCarbs, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalProtein => $composableBuilder(
      column: $table.totalProtein, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFat => $composableBuilder(
      column: $table.totalFat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFiber => $composableBuilder(
      column: $table.totalFiber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFromAI => $composableBuilder(
      column: $table.isFromAI, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recognitionHistoryId => $composableBuilder(
      column: $table.recognitionHistoryId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$FoodsTableFilterComposer get foodId {
    final $$FoodsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableFilterComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FoodEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get portionDescription => $composableBuilder(
      column: $table.portionDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCalories => $composableBuilder(
      column: $table.totalCalories,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCarbs => $composableBuilder(
      column: $table.totalCarbs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalProtein => $composableBuilder(
      column: $table.totalProtein,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFat => $composableBuilder(
      column: $table.totalFat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFiber => $composableBuilder(
      column: $table.totalFiber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFromAI => $composableBuilder(
      column: $table.isFromAI, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recognitionHistoryId => $composableBuilder(
      column: $table.recognitionHistoryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$FoodsTableOrderingComposer get foodId {
    final $$FoodsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableOrderingComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FoodEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams, builder: (column) => column);

  GeneratedColumn<String> get portionDescription => $composableBuilder(
      column: $table.portionDescription, builder: (column) => column);

  GeneratedColumn<double> get totalCalories => $composableBuilder(
      column: $table.totalCalories, builder: (column) => column);

  GeneratedColumn<double> get totalCarbs => $composableBuilder(
      column: $table.totalCarbs, builder: (column) => column);

  GeneratedColumn<double> get totalProtein => $composableBuilder(
      column: $table.totalProtein, builder: (column) => column);

  GeneratedColumn<double> get totalFat =>
      $composableBuilder(column: $table.totalFat, builder: (column) => column);

  GeneratedColumn<double> get totalFiber => $composableBuilder(
      column: $table.totalFiber, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isFromAI =>
      $composableBuilder(column: $table.isFromAI, builder: (column) => column);

  GeneratedColumn<int> get recognitionHistoryId => $composableBuilder(
      column: $table.recognitionHistoryId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FoodsTableAnnotationComposer get foodId {
    final $$FoodsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableAnnotationComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FoodEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntry,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (FoodEntry, $$FoodEntriesTableReferences),
    FoodEntry,
    PrefetchHooks Function({bool foodId})> {
  $$FoodEntriesTableTableManager(_$AppDatabase db, $FoodEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<String> mealType = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<double> portionGrams = const Value.absent(),
            Value<String?> portionDescription = const Value.absent(),
            Value<double> totalCalories = const Value.absent(),
            Value<double> totalCarbs = const Value.absent(),
            Value<double> totalProtein = const Value.absent(),
            Value<double> totalFat = const Value.absent(),
            Value<double> totalFiber = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<bool> isFromAI = const Value.absent(),
            Value<int?> recognitionHistoryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              FoodEntriesCompanion(
            id: id,
            userId: userId,
            foodId: foodId,
            mealType: mealType,
            timestamp: timestamp,
            portionGrams: portionGrams,
            portionDescription: portionDescription,
            totalCalories: totalCalories,
            totalCarbs: totalCarbs,
            totalProtein: totalProtein,
            totalFat: totalFat,
            totalFiber: totalFiber,
            notes: notes,
            imageUrl: imageUrl,
            isFromAI: isFromAI,
            recognitionHistoryId: recognitionHistoryId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required int foodId,
            required String mealType,
            required DateTime timestamp,
            required double portionGrams,
            Value<String?> portionDescription = const Value.absent(),
            required double totalCalories,
            required double totalCarbs,
            required double totalProtein,
            required double totalFat,
            required double totalFiber,
            Value<String?> notes = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<bool> isFromAI = const Value.absent(),
            Value<int?> recognitionHistoryId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              FoodEntriesCompanion.insert(
            id: id,
            userId: userId,
            foodId: foodId,
            mealType: mealType,
            timestamp: timestamp,
            portionGrams: portionGrams,
            portionDescription: portionDescription,
            totalCalories: totalCalories,
            totalCarbs: totalCarbs,
            totalProtein: totalProtein,
            totalFat: totalFat,
            totalFiber: totalFiber,
            notes: notes,
            imageUrl: imageUrl,
            isFromAI: isFromAI,
            recognitionHistoryId: recognitionHistoryId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FoodEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (foodId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.foodId,
                    referencedTable:
                        $$FoodEntriesTableReferences._foodIdTable(db),
                    referencedColumn:
                        $$FoodEntriesTableReferences._foodIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FoodEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntry,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (FoodEntry, $$FoodEntriesTableReferences),
    FoodEntry,
    PrefetchHooks Function({bool foodId})>;
typedef $$FavoritePortionsTableCreateCompanionBuilder
    = FavoritePortionsCompanion Function({
  Value<int> id,
  required String userId,
  required int foodId,
  required double portionGrams,
  Value<String?> nickname,
  Value<int> usageCount,
  Value<DateTime> lastUsedAt,
  Value<DateTime> createdAt,
});
typedef $$FavoritePortionsTableUpdateCompanionBuilder
    = FavoritePortionsCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<int> foodId,
  Value<double> portionGrams,
  Value<String?> nickname,
  Value<int> usageCount,
  Value<DateTime> lastUsedAt,
  Value<DateTime> createdAt,
});

final class $$FavoritePortionsTableReferences extends BaseReferences<
    _$AppDatabase, $FavoritePortionsTable, FavoritePortion> {
  $$FavoritePortionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FoodsTable _foodIdTable(_$AppDatabase db) => db.foods.createAlias(
      $_aliasNameGenerator(db.favoritePortions.foodId, db.foods.id));

  $$FoodsTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<int>('food_id')!;

    final manager = $$FoodsTableTableManager($_db, $_db.foods)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FavoritePortionsTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritePortionsTable> {
  $$FavoritePortionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$FoodsTableFilterComposer get foodId {
    final $$FoodsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableFilterComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoritePortionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritePortionsTable> {
  $$FavoritePortionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$FoodsTableOrderingComposer get foodId {
    final $$FoodsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableOrderingComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoritePortionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritePortionsTable> {
  $$FavoritePortionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get portionGrams => $composableBuilder(
      column: $table.portionGrams, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FoodsTableAnnotationComposer get foodId {
    final $$FoodsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableAnnotationComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoritePortionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoritePortionsTable,
    FavoritePortion,
    $$FavoritePortionsTableFilterComposer,
    $$FavoritePortionsTableOrderingComposer,
    $$FavoritePortionsTableAnnotationComposer,
    $$FavoritePortionsTableCreateCompanionBuilder,
    $$FavoritePortionsTableUpdateCompanionBuilder,
    (FavoritePortion, $$FavoritePortionsTableReferences),
    FavoritePortion,
    PrefetchHooks Function({bool foodId})> {
  $$FavoritePortionsTableTableManager(
      _$AppDatabase db, $FavoritePortionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritePortionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritePortionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritePortionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<double> portionGrams = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
            Value<int> usageCount = const Value.absent(),
            Value<DateTime> lastUsedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FavoritePortionsCompanion(
            id: id,
            userId: userId,
            foodId: foodId,
            portionGrams: portionGrams,
            nickname: nickname,
            usageCount: usageCount,
            lastUsedAt: lastUsedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required int foodId,
            required double portionGrams,
            Value<String?> nickname = const Value.absent(),
            Value<int> usageCount = const Value.absent(),
            Value<DateTime> lastUsedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FavoritePortionsCompanion.insert(
            id: id,
            userId: userId,
            foodId: foodId,
            portionGrams: portionGrams,
            nickname: nickname,
            usageCount: usageCount,
            lastUsedAt: lastUsedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FavoritePortionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (foodId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.foodId,
                    referencedTable:
                        $$FavoritePortionsTableReferences._foodIdTable(db),
                    referencedColumn:
                        $$FavoritePortionsTableReferences._foodIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FavoritePortionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoritePortionsTable,
    FavoritePortion,
    $$FavoritePortionsTableFilterComposer,
    $$FavoritePortionsTableOrderingComposer,
    $$FavoritePortionsTableAnnotationComposer,
    $$FavoritePortionsTableCreateCompanionBuilder,
    $$FavoritePortionsTableUpdateCompanionBuilder,
    (FavoritePortion, $$FavoritePortionsTableReferences),
    FavoritePortion,
    PrefetchHooks Function({bool foodId})>;
typedef $$DailyNutritionSummariesTableCreateCompanionBuilder
    = DailyNutritionSummariesCompanion Function({
  Value<int> id,
  required String userId,
  required DateTime date,
  required double calorieGoal,
  required double carbsGoal,
  required double proteinGoal,
  required double fatGoal,
  Value<double> totalCalories,
  Value<double> totalCarbs,
  Value<double> totalProtein,
  Value<double> totalFat,
  Value<double> totalFiber,
  Value<int> breakfastCount,
  Value<int> lunchCount,
  Value<int> dinnerCount,
  Value<int> snackCount,
  Value<DateTime> updatedAt,
});
typedef $$DailyNutritionSummariesTableUpdateCompanionBuilder
    = DailyNutritionSummariesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<DateTime> date,
  Value<double> calorieGoal,
  Value<double> carbsGoal,
  Value<double> proteinGoal,
  Value<double> fatGoal,
  Value<double> totalCalories,
  Value<double> totalCarbs,
  Value<double> totalProtein,
  Value<double> totalFat,
  Value<double> totalFiber,
  Value<int> breakfastCount,
  Value<int> lunchCount,
  Value<int> dinnerCount,
  Value<int> snackCount,
  Value<DateTime> updatedAt,
});

class $$DailyNutritionSummariesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyNutritionSummariesTable> {
  $$DailyNutritionSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calorieGoal => $composableBuilder(
      column: $table.calorieGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsGoal => $composableBuilder(
      column: $table.carbsGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinGoal => $composableBuilder(
      column: $table.proteinGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatGoal => $composableBuilder(
      column: $table.fatGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCalories => $composableBuilder(
      column: $table.totalCalories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCarbs => $composableBuilder(
      column: $table.totalCarbs, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalProtein => $composableBuilder(
      column: $table.totalProtein, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFat => $composableBuilder(
      column: $table.totalFat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalFiber => $composableBuilder(
      column: $table.totalFiber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get breakfastCount => $composableBuilder(
      column: $table.breakfastCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lunchCount => $composableBuilder(
      column: $table.lunchCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dinnerCount => $composableBuilder(
      column: $table.dinnerCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get snackCount => $composableBuilder(
      column: $table.snackCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyNutritionSummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyNutritionSummariesTable> {
  $$DailyNutritionSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calorieGoal => $composableBuilder(
      column: $table.calorieGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsGoal => $composableBuilder(
      column: $table.carbsGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinGoal => $composableBuilder(
      column: $table.proteinGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatGoal => $composableBuilder(
      column: $table.fatGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCalories => $composableBuilder(
      column: $table.totalCalories,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCarbs => $composableBuilder(
      column: $table.totalCarbs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalProtein => $composableBuilder(
      column: $table.totalProtein,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFat => $composableBuilder(
      column: $table.totalFat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalFiber => $composableBuilder(
      column: $table.totalFiber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get breakfastCount => $composableBuilder(
      column: $table.breakfastCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lunchCount => $composableBuilder(
      column: $table.lunchCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dinnerCount => $composableBuilder(
      column: $table.dinnerCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get snackCount => $composableBuilder(
      column: $table.snackCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyNutritionSummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyNutritionSummariesTable> {
  $$DailyNutritionSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get calorieGoal => $composableBuilder(
      column: $table.calorieGoal, builder: (column) => column);

  GeneratedColumn<double> get carbsGoal =>
      $composableBuilder(column: $table.carbsGoal, builder: (column) => column);

  GeneratedColumn<double> get proteinGoal => $composableBuilder(
      column: $table.proteinGoal, builder: (column) => column);

  GeneratedColumn<double> get fatGoal =>
      $composableBuilder(column: $table.fatGoal, builder: (column) => column);

  GeneratedColumn<double> get totalCalories => $composableBuilder(
      column: $table.totalCalories, builder: (column) => column);

  GeneratedColumn<double> get totalCarbs => $composableBuilder(
      column: $table.totalCarbs, builder: (column) => column);

  GeneratedColumn<double> get totalProtein => $composableBuilder(
      column: $table.totalProtein, builder: (column) => column);

  GeneratedColumn<double> get totalFat =>
      $composableBuilder(column: $table.totalFat, builder: (column) => column);

  GeneratedColumn<double> get totalFiber => $composableBuilder(
      column: $table.totalFiber, builder: (column) => column);

  GeneratedColumn<int> get breakfastCount => $composableBuilder(
      column: $table.breakfastCount, builder: (column) => column);

  GeneratedColumn<int> get lunchCount => $composableBuilder(
      column: $table.lunchCount, builder: (column) => column);

  GeneratedColumn<int> get dinnerCount => $composableBuilder(
      column: $table.dinnerCount, builder: (column) => column);

  GeneratedColumn<int> get snackCount => $composableBuilder(
      column: $table.snackCount, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyNutritionSummariesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyNutritionSummariesTable,
    DailyNutritionSummary,
    $$DailyNutritionSummariesTableFilterComposer,
    $$DailyNutritionSummariesTableOrderingComposer,
    $$DailyNutritionSummariesTableAnnotationComposer,
    $$DailyNutritionSummariesTableCreateCompanionBuilder,
    $$DailyNutritionSummariesTableUpdateCompanionBuilder,
    (
      DailyNutritionSummary,
      BaseReferences<_$AppDatabase, $DailyNutritionSummariesTable,
          DailyNutritionSummary>
    ),
    DailyNutritionSummary,
    PrefetchHooks Function()> {
  $$DailyNutritionSummariesTableTableManager(
      _$AppDatabase db, $DailyNutritionSummariesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyNutritionSummariesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyNutritionSummariesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyNutritionSummariesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> calorieGoal = const Value.absent(),
            Value<double> carbsGoal = const Value.absent(),
            Value<double> proteinGoal = const Value.absent(),
            Value<double> fatGoal = const Value.absent(),
            Value<double> totalCalories = const Value.absent(),
            Value<double> totalCarbs = const Value.absent(),
            Value<double> totalProtein = const Value.absent(),
            Value<double> totalFat = const Value.absent(),
            Value<double> totalFiber = const Value.absent(),
            Value<int> breakfastCount = const Value.absent(),
            Value<int> lunchCount = const Value.absent(),
            Value<int> dinnerCount = const Value.absent(),
            Value<int> snackCount = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyNutritionSummariesCompanion(
            id: id,
            userId: userId,
            date: date,
            calorieGoal: calorieGoal,
            carbsGoal: carbsGoal,
            proteinGoal: proteinGoal,
            fatGoal: fatGoal,
            totalCalories: totalCalories,
            totalCarbs: totalCarbs,
            totalProtein: totalProtein,
            totalFat: totalFat,
            totalFiber: totalFiber,
            breakfastCount: breakfastCount,
            lunchCount: lunchCount,
            dinnerCount: dinnerCount,
            snackCount: snackCount,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required DateTime date,
            required double calorieGoal,
            required double carbsGoal,
            required double proteinGoal,
            required double fatGoal,
            Value<double> totalCalories = const Value.absent(),
            Value<double> totalCarbs = const Value.absent(),
            Value<double> totalProtein = const Value.absent(),
            Value<double> totalFat = const Value.absent(),
            Value<double> totalFiber = const Value.absent(),
            Value<int> breakfastCount = const Value.absent(),
            Value<int> lunchCount = const Value.absent(),
            Value<int> dinnerCount = const Value.absent(),
            Value<int> snackCount = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyNutritionSummariesCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            calorieGoal: calorieGoal,
            carbsGoal: carbsGoal,
            proteinGoal: proteinGoal,
            fatGoal: fatGoal,
            totalCalories: totalCalories,
            totalCarbs: totalCarbs,
            totalProtein: totalProtein,
            totalFat: totalFat,
            totalFiber: totalFiber,
            breakfastCount: breakfastCount,
            lunchCount: lunchCount,
            dinnerCount: dinnerCount,
            snackCount: snackCount,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyNutritionSummariesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DailyNutritionSummariesTable,
        DailyNutritionSummary,
        $$DailyNutritionSummariesTableFilterComposer,
        $$DailyNutritionSummariesTableOrderingComposer,
        $$DailyNutritionSummariesTableAnnotationComposer,
        $$DailyNutritionSummariesTableCreateCompanionBuilder,
        $$DailyNutritionSummariesTableUpdateCompanionBuilder,
        (
          DailyNutritionSummary,
          BaseReferences<_$AppDatabase, $DailyNutritionSummariesTable,
              DailyNutritionSummary>
        ),
        DailyNutritionSummary,
        PrefetchHooks Function()>;
typedef $$RecognitionHistoriesTableCreateCompanionBuilder
    = RecognitionHistoriesCompanion Function({
  Value<int> id,
  required String userId,
  required String imagePath,
  Value<String?> imageHash,
  Value<DateTime> recognizedAt,
  required String modelVersion,
  Value<double?> processingTimeMs,
  Value<String> status,
  Value<String?> errorMessage,
  Value<bool> userConfirmed,
  Value<bool> userCorrected,
  Value<DateTime> updatedAt,
});
typedef $$RecognitionHistoriesTableUpdateCompanionBuilder
    = RecognitionHistoriesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> imagePath,
  Value<String?> imageHash,
  Value<DateTime> recognizedAt,
  Value<String> modelVersion,
  Value<double?> processingTimeMs,
  Value<String> status,
  Value<String?> errorMessage,
  Value<bool> userConfirmed,
  Value<bool> userCorrected,
  Value<DateTime> updatedAt,
});

final class $$RecognitionHistoriesTableReferences extends BaseReferences<
    _$AppDatabase, $RecognitionHistoriesTable, RecognitionHistory> {
  $$RecognitionHistoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecognitionResultsTable, List<RecognitionResult>>
      _recognitionResultsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.recognitionResults,
              aliasName: $_aliasNameGenerator(
                  db.recognitionHistories.id, db.recognitionResults.historyId));

  $$RecognitionResultsTableProcessedTableManager get recognitionResultsRefs {
    final manager =
        $$RecognitionResultsTableTableManager($_db, $_db.recognitionResults)
            .filter((f) => f.historyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_recognitionResultsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RecognitionHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $RecognitionHistoriesTable> {
  $$RecognitionHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageHash => $composableBuilder(
      column: $table.imageHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recognizedAt => $composableBuilder(
      column: $table.recognizedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modelVersion => $composableBuilder(
      column: $table.modelVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get processingTimeMs => $composableBuilder(
      column: $table.processingTimeMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get userConfirmed => $composableBuilder(
      column: $table.userConfirmed, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get userCorrected => $composableBuilder(
      column: $table.userCorrected, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> recognitionResultsRefs(
      Expression<bool> Function($$RecognitionResultsTableFilterComposer f) f) {
    final $$RecognitionResultsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.recognitionResults,
        getReferencedColumn: (t) => t.historyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecognitionResultsTableFilterComposer(
              $db: $db,
              $table: $db.recognitionResults,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RecognitionHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecognitionHistoriesTable> {
  $$RecognitionHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageHash => $composableBuilder(
      column: $table.imageHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recognizedAt => $composableBuilder(
      column: $table.recognizedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modelVersion => $composableBuilder(
      column: $table.modelVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get processingTimeMs => $composableBuilder(
      column: $table.processingTimeMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get userConfirmed => $composableBuilder(
      column: $table.userConfirmed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get userCorrected => $composableBuilder(
      column: $table.userCorrected,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$RecognitionHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecognitionHistoriesTable> {
  $$RecognitionHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get imageHash =>
      $composableBuilder(column: $table.imageHash, builder: (column) => column);

  GeneratedColumn<DateTime> get recognizedAt => $composableBuilder(
      column: $table.recognizedAt, builder: (column) => column);

  GeneratedColumn<String> get modelVersion => $composableBuilder(
      column: $table.modelVersion, builder: (column) => column);

  GeneratedColumn<double> get processingTimeMs => $composableBuilder(
      column: $table.processingTimeMs, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<bool> get userConfirmed => $composableBuilder(
      column: $table.userConfirmed, builder: (column) => column);

  GeneratedColumn<bool> get userCorrected => $composableBuilder(
      column: $table.userCorrected, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> recognitionResultsRefs<T extends Object>(
      Expression<T> Function($$RecognitionResultsTableAnnotationComposer a) f) {
    final $$RecognitionResultsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.recognitionResults,
            getReferencedColumn: (t) => t.historyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RecognitionResultsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.recognitionResults,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RecognitionHistoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecognitionHistoriesTable,
    RecognitionHistory,
    $$RecognitionHistoriesTableFilterComposer,
    $$RecognitionHistoriesTableOrderingComposer,
    $$RecognitionHistoriesTableAnnotationComposer,
    $$RecognitionHistoriesTableCreateCompanionBuilder,
    $$RecognitionHistoriesTableUpdateCompanionBuilder,
    (RecognitionHistory, $$RecognitionHistoriesTableReferences),
    RecognitionHistory,
    PrefetchHooks Function({bool recognitionResultsRefs})> {
  $$RecognitionHistoriesTableTableManager(
      _$AppDatabase db, $RecognitionHistoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecognitionHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecognitionHistoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecognitionHistoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<String?> imageHash = const Value.absent(),
            Value<DateTime> recognizedAt = const Value.absent(),
            Value<String> modelVersion = const Value.absent(),
            Value<double?> processingTimeMs = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<bool> userConfirmed = const Value.absent(),
            Value<bool> userCorrected = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RecognitionHistoriesCompanion(
            id: id,
            userId: userId,
            imagePath: imagePath,
            imageHash: imageHash,
            recognizedAt: recognizedAt,
            modelVersion: modelVersion,
            processingTimeMs: processingTimeMs,
            status: status,
            errorMessage: errorMessage,
            userConfirmed: userConfirmed,
            userCorrected: userCorrected,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String imagePath,
            Value<String?> imageHash = const Value.absent(),
            Value<DateTime> recognizedAt = const Value.absent(),
            required String modelVersion,
            Value<double?> processingTimeMs = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<bool> userConfirmed = const Value.absent(),
            Value<bool> userCorrected = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              RecognitionHistoriesCompanion.insert(
            id: id,
            userId: userId,
            imagePath: imagePath,
            imageHash: imageHash,
            recognizedAt: recognizedAt,
            modelVersion: modelVersion,
            processingTimeMs: processingTimeMs,
            status: status,
            errorMessage: errorMessage,
            userConfirmed: userConfirmed,
            userCorrected: userCorrected,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RecognitionHistoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({recognitionResultsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (recognitionResultsRefs) db.recognitionResults
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recognitionResultsRefs)
                    await $_getPrefetchedData<RecognitionHistory,
                            $RecognitionHistoriesTable, RecognitionResult>(
                        currentTable: table,
                        referencedTable: $$RecognitionHistoriesTableReferences
                            ._recognitionResultsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RecognitionHistoriesTableReferences(db, table, p0)
                                .recognitionResultsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.historyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RecognitionHistoriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RecognitionHistoriesTable,
        RecognitionHistory,
        $$RecognitionHistoriesTableFilterComposer,
        $$RecognitionHistoriesTableOrderingComposer,
        $$RecognitionHistoriesTableAnnotationComposer,
        $$RecognitionHistoriesTableCreateCompanionBuilder,
        $$RecognitionHistoriesTableUpdateCompanionBuilder,
        (RecognitionHistory, $$RecognitionHistoriesTableReferences),
        RecognitionHistory,
        PrefetchHooks Function({bool recognitionResultsRefs})>;
typedef $$RecognitionResultsTableCreateCompanionBuilder
    = RecognitionResultsCompanion Function({
  Value<int> id,
  required int historyId,
  Value<int?> foodId,
  required String detectedLabel,
  required double confidence,
  Value<double?> boundingBoxX,
  Value<double?> boundingBoxY,
  Value<double?> boundingBoxWidth,
  Value<double?> boundingBoxHeight,
  Value<double?> estimatedGrams,
  Value<String?> portionEstimateMethod,
  Value<int?> correctedFoodId,
  Value<double?> correctedGrams,
  Value<String?> userNotes,
  Value<DateTime> createdAt,
});
typedef $$RecognitionResultsTableUpdateCompanionBuilder
    = RecognitionResultsCompanion Function({
  Value<int> id,
  Value<int> historyId,
  Value<int?> foodId,
  Value<String> detectedLabel,
  Value<double> confidence,
  Value<double?> boundingBoxX,
  Value<double?> boundingBoxY,
  Value<double?> boundingBoxWidth,
  Value<double?> boundingBoxHeight,
  Value<double?> estimatedGrams,
  Value<String?> portionEstimateMethod,
  Value<int?> correctedFoodId,
  Value<double?> correctedGrams,
  Value<String?> userNotes,
  Value<DateTime> createdAt,
});

final class $$RecognitionResultsTableReferences extends BaseReferences<
    _$AppDatabase, $RecognitionResultsTable, RecognitionResult> {
  $$RecognitionResultsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RecognitionHistoriesTable _historyIdTable(_$AppDatabase db) =>
      db.recognitionHistories.createAlias($_aliasNameGenerator(
          db.recognitionResults.historyId, db.recognitionHistories.id));

  $$RecognitionHistoriesTableProcessedTableManager get historyId {
    final $_column = $_itemColumn<int>('history_id')!;

    final manager =
        $$RecognitionHistoriesTableTableManager($_db, $_db.recognitionHistories)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_historyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FoodsTable _foodIdTable(_$AppDatabase db) => db.foods.createAlias(
      $_aliasNameGenerator(db.recognitionResults.foodId, db.foods.id));

  $$FoodsTableProcessedTableManager? get foodId {
    final $_column = $_itemColumn<int>('food_id');
    if ($_column == null) return null;
    final manager = $$FoodsTableTableManager($_db, $_db.foods)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FoodsTable _correctedFoodIdTable(_$AppDatabase db) =>
      db.foods.createAlias($_aliasNameGenerator(
          db.recognitionResults.correctedFoodId, db.foods.id));

  $$FoodsTableProcessedTableManager? get correctedFoodId {
    final $_column = $_itemColumn<int>('corrected_food_id');
    if ($_column == null) return null;
    final manager = $$FoodsTableTableManager($_db, $_db.foods)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_correctedFoodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$RecognitionFeedbacksTable,
      List<RecognitionFeedback>> _recognitionFeedbacksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.recognitionFeedbacks,
          aliasName: $_aliasNameGenerator(
              db.recognitionResults.id, db.recognitionFeedbacks.resultId));

  $$RecognitionFeedbacksTableProcessedTableManager
      get recognitionFeedbacksRefs {
    final manager =
        $$RecognitionFeedbacksTableTableManager($_db, $_db.recognitionFeedbacks)
            .filter((f) => f.resultId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_recognitionFeedbacksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RecognitionResultsTableFilterComposer
    extends Composer<_$AppDatabase, $RecognitionResultsTable> {
  $$RecognitionResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detectedLabel => $composableBuilder(
      column: $table.detectedLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundingBoxX => $composableBuilder(
      column: $table.boundingBoxX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundingBoxY => $composableBuilder(
      column: $table.boundingBoxY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundingBoxWidth => $composableBuilder(
      column: $table.boundingBoxWidth,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get boundingBoxHeight => $composableBuilder(
      column: $table.boundingBoxHeight,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estimatedGrams => $composableBuilder(
      column: $table.estimatedGrams,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get portionEstimateMethod => $composableBuilder(
      column: $table.portionEstimateMethod,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get correctedGrams => $composableBuilder(
      column: $table.correctedGrams,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userNotes => $composableBuilder(
      column: $table.userNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$RecognitionHistoriesTableFilterComposer get historyId {
    final $$RecognitionHistoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.historyId,
        referencedTable: $db.recognitionHistories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecognitionHistoriesTableFilterComposer(
              $db: $db,
              $table: $db.recognitionHistories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FoodsTableFilterComposer get foodId {
    final $$FoodsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableFilterComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FoodsTableFilterComposer get correctedFoodId {
    final $$FoodsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.correctedFoodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableFilterComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> recognitionFeedbacksRefs(
      Expression<bool> Function($$RecognitionFeedbacksTableFilterComposer f)
          f) {
    final $$RecognitionFeedbacksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.recognitionFeedbacks,
        getReferencedColumn: (t) => t.resultId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecognitionFeedbacksTableFilterComposer(
              $db: $db,
              $table: $db.recognitionFeedbacks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RecognitionResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecognitionResultsTable> {
  $$RecognitionResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detectedLabel => $composableBuilder(
      column: $table.detectedLabel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundingBoxX => $composableBuilder(
      column: $table.boundingBoxX,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundingBoxY => $composableBuilder(
      column: $table.boundingBoxY,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundingBoxWidth => $composableBuilder(
      column: $table.boundingBoxWidth,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get boundingBoxHeight => $composableBuilder(
      column: $table.boundingBoxHeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estimatedGrams => $composableBuilder(
      column: $table.estimatedGrams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get portionEstimateMethod => $composableBuilder(
      column: $table.portionEstimateMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get correctedGrams => $composableBuilder(
      column: $table.correctedGrams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userNotes => $composableBuilder(
      column: $table.userNotes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$RecognitionHistoriesTableOrderingComposer get historyId {
    final $$RecognitionHistoriesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.historyId,
            referencedTable: $db.recognitionHistories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RecognitionHistoriesTableOrderingComposer(
                  $db: $db,
                  $table: $db.recognitionHistories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$FoodsTableOrderingComposer get foodId {
    final $$FoodsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableOrderingComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FoodsTableOrderingComposer get correctedFoodId {
    final $$FoodsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.correctedFoodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableOrderingComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecognitionResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecognitionResultsTable> {
  $$RecognitionResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get detectedLabel => $composableBuilder(
      column: $table.detectedLabel, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
      column: $table.confidence, builder: (column) => column);

  GeneratedColumn<double> get boundingBoxX => $composableBuilder(
      column: $table.boundingBoxX, builder: (column) => column);

  GeneratedColumn<double> get boundingBoxY => $composableBuilder(
      column: $table.boundingBoxY, builder: (column) => column);

  GeneratedColumn<double> get boundingBoxWidth => $composableBuilder(
      column: $table.boundingBoxWidth, builder: (column) => column);

  GeneratedColumn<double> get boundingBoxHeight => $composableBuilder(
      column: $table.boundingBoxHeight, builder: (column) => column);

  GeneratedColumn<double> get estimatedGrams => $composableBuilder(
      column: $table.estimatedGrams, builder: (column) => column);

  GeneratedColumn<String> get portionEstimateMethod => $composableBuilder(
      column: $table.portionEstimateMethod, builder: (column) => column);

  GeneratedColumn<double> get correctedGrams => $composableBuilder(
      column: $table.correctedGrams, builder: (column) => column);

  GeneratedColumn<String> get userNotes =>
      $composableBuilder(column: $table.userNotes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RecognitionHistoriesTableAnnotationComposer get historyId {
    final $$RecognitionHistoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.historyId,
            referencedTable: $db.recognitionHistories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RecognitionHistoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.recognitionHistories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$FoodsTableAnnotationComposer get foodId {
    final $$FoodsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.foodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableAnnotationComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FoodsTableAnnotationComposer get correctedFoodId {
    final $$FoodsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.correctedFoodId,
        referencedTable: $db.foods,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FoodsTableAnnotationComposer(
              $db: $db,
              $table: $db.foods,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> recognitionFeedbacksRefs<T extends Object>(
      Expression<T> Function($$RecognitionFeedbacksTableAnnotationComposer a)
          f) {
    final $$RecognitionFeedbacksTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.recognitionFeedbacks,
            getReferencedColumn: (t) => t.resultId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RecognitionFeedbacksTableAnnotationComposer(
                  $db: $db,
                  $table: $db.recognitionFeedbacks,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$RecognitionResultsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecognitionResultsTable,
    RecognitionResult,
    $$RecognitionResultsTableFilterComposer,
    $$RecognitionResultsTableOrderingComposer,
    $$RecognitionResultsTableAnnotationComposer,
    $$RecognitionResultsTableCreateCompanionBuilder,
    $$RecognitionResultsTableUpdateCompanionBuilder,
    (RecognitionResult, $$RecognitionResultsTableReferences),
    RecognitionResult,
    PrefetchHooks Function(
        {bool historyId,
        bool foodId,
        bool correctedFoodId,
        bool recognitionFeedbacksRefs})> {
  $$RecognitionResultsTableTableManager(
      _$AppDatabase db, $RecognitionResultsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecognitionResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecognitionResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecognitionResultsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> historyId = const Value.absent(),
            Value<int?> foodId = const Value.absent(),
            Value<String> detectedLabel = const Value.absent(),
            Value<double> confidence = const Value.absent(),
            Value<double?> boundingBoxX = const Value.absent(),
            Value<double?> boundingBoxY = const Value.absent(),
            Value<double?> boundingBoxWidth = const Value.absent(),
            Value<double?> boundingBoxHeight = const Value.absent(),
            Value<double?> estimatedGrams = const Value.absent(),
            Value<String?> portionEstimateMethod = const Value.absent(),
            Value<int?> correctedFoodId = const Value.absent(),
            Value<double?> correctedGrams = const Value.absent(),
            Value<String?> userNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RecognitionResultsCompanion(
            id: id,
            historyId: historyId,
            foodId: foodId,
            detectedLabel: detectedLabel,
            confidence: confidence,
            boundingBoxX: boundingBoxX,
            boundingBoxY: boundingBoxY,
            boundingBoxWidth: boundingBoxWidth,
            boundingBoxHeight: boundingBoxHeight,
            estimatedGrams: estimatedGrams,
            portionEstimateMethod: portionEstimateMethod,
            correctedFoodId: correctedFoodId,
            correctedGrams: correctedGrams,
            userNotes: userNotes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int historyId,
            Value<int?> foodId = const Value.absent(),
            required String detectedLabel,
            required double confidence,
            Value<double?> boundingBoxX = const Value.absent(),
            Value<double?> boundingBoxY = const Value.absent(),
            Value<double?> boundingBoxWidth = const Value.absent(),
            Value<double?> boundingBoxHeight = const Value.absent(),
            Value<double?> estimatedGrams = const Value.absent(),
            Value<String?> portionEstimateMethod = const Value.absent(),
            Value<int?> correctedFoodId = const Value.absent(),
            Value<double?> correctedGrams = const Value.absent(),
            Value<String?> userNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RecognitionResultsCompanion.insert(
            id: id,
            historyId: historyId,
            foodId: foodId,
            detectedLabel: detectedLabel,
            confidence: confidence,
            boundingBoxX: boundingBoxX,
            boundingBoxY: boundingBoxY,
            boundingBoxWidth: boundingBoxWidth,
            boundingBoxHeight: boundingBoxHeight,
            estimatedGrams: estimatedGrams,
            portionEstimateMethod: portionEstimateMethod,
            correctedFoodId: correctedFoodId,
            correctedGrams: correctedGrams,
            userNotes: userNotes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RecognitionResultsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {historyId = false,
              foodId = false,
              correctedFoodId = false,
              recognitionFeedbacksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (recognitionFeedbacksRefs) db.recognitionFeedbacks
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (historyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.historyId,
                    referencedTable:
                        $$RecognitionResultsTableReferences._historyIdTable(db),
                    referencedColumn: $$RecognitionResultsTableReferences
                        ._historyIdTable(db)
                        .id,
                  ) as T;
                }
                if (foodId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.foodId,
                    referencedTable:
                        $$RecognitionResultsTableReferences._foodIdTable(db),
                    referencedColumn:
                        $$RecognitionResultsTableReferences._foodIdTable(db).id,
                  ) as T;
                }
                if (correctedFoodId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.correctedFoodId,
                    referencedTable: $$RecognitionResultsTableReferences
                        ._correctedFoodIdTable(db),
                    referencedColumn: $$RecognitionResultsTableReferences
                        ._correctedFoodIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recognitionFeedbacksRefs)
                    await $_getPrefetchedData<RecognitionResult,
                            $RecognitionResultsTable, RecognitionFeedback>(
                        currentTable: table,
                        referencedTable: $$RecognitionResultsTableReferences
                            ._recognitionFeedbacksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RecognitionResultsTableReferences(db, table, p0)
                                .recognitionFeedbacksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.resultId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RecognitionResultsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecognitionResultsTable,
    RecognitionResult,
    $$RecognitionResultsTableFilterComposer,
    $$RecognitionResultsTableOrderingComposer,
    $$RecognitionResultsTableAnnotationComposer,
    $$RecognitionResultsTableCreateCompanionBuilder,
    $$RecognitionResultsTableUpdateCompanionBuilder,
    (RecognitionResult, $$RecognitionResultsTableReferences),
    RecognitionResult,
    PrefetchHooks Function(
        {bool historyId,
        bool foodId,
        bool correctedFoodId,
        bool recognitionFeedbacksRefs})>;
typedef $$RecognitionFeedbacksTableCreateCompanionBuilder
    = RecognitionFeedbacksCompanion Function({
  Value<int> id,
  required int resultId,
  required String userId,
  required String feedbackType,
  Value<int?> correctnessScore,
  Value<String?> correctFoodName,
  Value<double?> actualGrams,
  Value<String?> comments,
  Value<int?> imageQualityScore,
  Value<String?> imageIssues,
  Value<DateTime> createdAt,
});
typedef $$RecognitionFeedbacksTableUpdateCompanionBuilder
    = RecognitionFeedbacksCompanion Function({
  Value<int> id,
  Value<int> resultId,
  Value<String> userId,
  Value<String> feedbackType,
  Value<int?> correctnessScore,
  Value<String?> correctFoodName,
  Value<double?> actualGrams,
  Value<String?> comments,
  Value<int?> imageQualityScore,
  Value<String?> imageIssues,
  Value<DateTime> createdAt,
});

final class $$RecognitionFeedbacksTableReferences extends BaseReferences<
    _$AppDatabase, $RecognitionFeedbacksTable, RecognitionFeedback> {
  $$RecognitionFeedbacksTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RecognitionResultsTable _resultIdTable(_$AppDatabase db) =>
      db.recognitionResults.createAlias($_aliasNameGenerator(
          db.recognitionFeedbacks.resultId, db.recognitionResults.id));

  $$RecognitionResultsTableProcessedTableManager get resultId {
    final $_column = $_itemColumn<int>('result_id')!;

    final manager =
        $$RecognitionResultsTableTableManager($_db, $_db.recognitionResults)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_resultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RecognitionFeedbacksTableFilterComposer
    extends Composer<_$AppDatabase, $RecognitionFeedbacksTable> {
  $$RecognitionFeedbacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedbackType => $composableBuilder(
      column: $table.feedbackType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctnessScore => $composableBuilder(
      column: $table.correctnessScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctFoodName => $composableBuilder(
      column: $table.correctFoodName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualGrams => $composableBuilder(
      column: $table.actualGrams, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get comments => $composableBuilder(
      column: $table.comments, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get imageQualityScore => $composableBuilder(
      column: $table.imageQualityScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageIssues => $composableBuilder(
      column: $table.imageIssues, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$RecognitionResultsTableFilterComposer get resultId {
    final $$RecognitionResultsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.resultId,
        referencedTable: $db.recognitionResults,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecognitionResultsTableFilterComposer(
              $db: $db,
              $table: $db.recognitionResults,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecognitionFeedbacksTableOrderingComposer
    extends Composer<_$AppDatabase, $RecognitionFeedbacksTable> {
  $$RecognitionFeedbacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedbackType => $composableBuilder(
      column: $table.feedbackType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctnessScore => $composableBuilder(
      column: $table.correctnessScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctFoodName => $composableBuilder(
      column: $table.correctFoodName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualGrams => $composableBuilder(
      column: $table.actualGrams, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get comments => $composableBuilder(
      column: $table.comments, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get imageQualityScore => $composableBuilder(
      column: $table.imageQualityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageIssues => $composableBuilder(
      column: $table.imageIssues, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$RecognitionResultsTableOrderingComposer get resultId {
    final $$RecognitionResultsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.resultId,
        referencedTable: $db.recognitionResults,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecognitionResultsTableOrderingComposer(
              $db: $db,
              $table: $db.recognitionResults,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecognitionFeedbacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecognitionFeedbacksTable> {
  $$RecognitionFeedbacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get feedbackType => $composableBuilder(
      column: $table.feedbackType, builder: (column) => column);

  GeneratedColumn<int> get correctnessScore => $composableBuilder(
      column: $table.correctnessScore, builder: (column) => column);

  GeneratedColumn<String> get correctFoodName => $composableBuilder(
      column: $table.correctFoodName, builder: (column) => column);

  GeneratedColumn<double> get actualGrams => $composableBuilder(
      column: $table.actualGrams, builder: (column) => column);

  GeneratedColumn<String> get comments =>
      $composableBuilder(column: $table.comments, builder: (column) => column);

  GeneratedColumn<int> get imageQualityScore => $composableBuilder(
      column: $table.imageQualityScore, builder: (column) => column);

  GeneratedColumn<String> get imageIssues => $composableBuilder(
      column: $table.imageIssues, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RecognitionResultsTableAnnotationComposer get resultId {
    final $$RecognitionResultsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.resultId,
            referencedTable: $db.recognitionResults,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RecognitionResultsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.recognitionResults,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$RecognitionFeedbacksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecognitionFeedbacksTable,
    RecognitionFeedback,
    $$RecognitionFeedbacksTableFilterComposer,
    $$RecognitionFeedbacksTableOrderingComposer,
    $$RecognitionFeedbacksTableAnnotationComposer,
    $$RecognitionFeedbacksTableCreateCompanionBuilder,
    $$RecognitionFeedbacksTableUpdateCompanionBuilder,
    (RecognitionFeedback, $$RecognitionFeedbacksTableReferences),
    RecognitionFeedback,
    PrefetchHooks Function({bool resultId})> {
  $$RecognitionFeedbacksTableTableManager(
      _$AppDatabase db, $RecognitionFeedbacksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecognitionFeedbacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecognitionFeedbacksTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecognitionFeedbacksTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> resultId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> feedbackType = const Value.absent(),
            Value<int?> correctnessScore = const Value.absent(),
            Value<String?> correctFoodName = const Value.absent(),
            Value<double?> actualGrams = const Value.absent(),
            Value<String?> comments = const Value.absent(),
            Value<int?> imageQualityScore = const Value.absent(),
            Value<String?> imageIssues = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RecognitionFeedbacksCompanion(
            id: id,
            resultId: resultId,
            userId: userId,
            feedbackType: feedbackType,
            correctnessScore: correctnessScore,
            correctFoodName: correctFoodName,
            actualGrams: actualGrams,
            comments: comments,
            imageQualityScore: imageQualityScore,
            imageIssues: imageIssues,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int resultId,
            required String userId,
            required String feedbackType,
            Value<int?> correctnessScore = const Value.absent(),
            Value<String?> correctFoodName = const Value.absent(),
            Value<double?> actualGrams = const Value.absent(),
            Value<String?> comments = const Value.absent(),
            Value<int?> imageQualityScore = const Value.absent(),
            Value<String?> imageIssues = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RecognitionFeedbacksCompanion.insert(
            id: id,
            resultId: resultId,
            userId: userId,
            feedbackType: feedbackType,
            correctnessScore: correctnessScore,
            correctFoodName: correctFoodName,
            actualGrams: actualGrams,
            comments: comments,
            imageQualityScore: imageQualityScore,
            imageIssues: imageIssues,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RecognitionFeedbacksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({resultId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (resultId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.resultId,
                    referencedTable: $$RecognitionFeedbacksTableReferences
                        ._resultIdTable(db),
                    referencedColumn: $$RecognitionFeedbacksTableReferences
                        ._resultIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RecognitionFeedbacksTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RecognitionFeedbacksTable,
        RecognitionFeedback,
        $$RecognitionFeedbacksTableFilterComposer,
        $$RecognitionFeedbacksTableOrderingComposer,
        $$RecognitionFeedbacksTableAnnotationComposer,
        $$RecognitionFeedbacksTableCreateCompanionBuilder,
        $$RecognitionFeedbacksTableUpdateCompanionBuilder,
        (RecognitionFeedback, $$RecognitionFeedbacksTableReferences),
        RecognitionFeedback,
        PrefetchHooks Function({bool resultId})>;
typedef $$UserPreferencesTableCreateCompanionBuilder = UserPreferencesCompanion
    Function({
  required String userId,
  Value<double> dailyCalorieGoal,
  Value<double> dailyCarbsGoal,
  Value<double> dailyProteinGoal,
  Value<double> dailyFatGoal,
  Value<double> dailyFiberGoal,
  Value<double> carbsRatio,
  Value<double> proteinRatio,
  Value<double> fatRatio,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> height,
  Value<double?> weight,
  Value<String> activityLevel,
  Value<String> goal,
  Value<String?> dietaryRestrictions,
  Value<String?> allergies,
  Value<String?> dislikedFoods,
  Value<bool> aiSuggestionsEnabled,
  Value<double> aiConfidenceThreshold,
  Value<bool> autoSaveRecognitions,
  Value<bool> mealRemindersEnabled,
  Value<String?> breakfastReminderTime,
  Value<String?> lunchReminderTime,
  Value<String?> dinnerReminderTime,
  Value<bool> nutritionGoalNotifications,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$UserPreferencesTableUpdateCompanionBuilder = UserPreferencesCompanion
    Function({
  Value<String> userId,
  Value<double> dailyCalorieGoal,
  Value<double> dailyCarbsGoal,
  Value<double> dailyProteinGoal,
  Value<double> dailyFatGoal,
  Value<double> dailyFiberGoal,
  Value<double> carbsRatio,
  Value<double> proteinRatio,
  Value<double> fatRatio,
  Value<int?> age,
  Value<String?> gender,
  Value<double?> height,
  Value<double?> weight,
  Value<String> activityLevel,
  Value<String> goal,
  Value<String?> dietaryRestrictions,
  Value<String?> allergies,
  Value<String?> dislikedFoods,
  Value<bool> aiSuggestionsEnabled,
  Value<double> aiConfidenceThreshold,
  Value<bool> autoSaveRecognitions,
  Value<bool> mealRemindersEnabled,
  Value<String?> breakfastReminderTime,
  Value<String?> lunchReminderTime,
  Value<String?> dinnerReminderTime,
  Value<bool> nutritionGoalNotifications,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dailyCalorieGoal => $composableBuilder(
      column: $table.dailyCalorieGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dailyCarbsGoal => $composableBuilder(
      column: $table.dailyCarbsGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dailyProteinGoal => $composableBuilder(
      column: $table.dailyProteinGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dailyFatGoal => $composableBuilder(
      column: $table.dailyFatGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dailyFiberGoal => $composableBuilder(
      column: $table.dailyFiberGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsRatio => $composableBuilder(
      column: $table.carbsRatio, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinRatio => $composableBuilder(
      column: $table.proteinRatio, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatRatio => $composableBuilder(
      column: $table.fatRatio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activityLevel => $composableBuilder(
      column: $table.activityLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goal => $composableBuilder(
      column: $table.goal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dietaryRestrictions => $composableBuilder(
      column: $table.dietaryRestrictions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get allergies => $composableBuilder(
      column: $table.allergies, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dislikedFoods => $composableBuilder(
      column: $table.dislikedFoods, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get aiSuggestionsEnabled => $composableBuilder(
      column: $table.aiSuggestionsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get aiConfidenceThreshold => $composableBuilder(
      column: $table.aiConfidenceThreshold,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get autoSaveRecognitions => $composableBuilder(
      column: $table.autoSaveRecognitions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get mealRemindersEnabled => $composableBuilder(
      column: $table.mealRemindersEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get breakfastReminderTime => $composableBuilder(
      column: $table.breakfastReminderTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lunchReminderTime => $composableBuilder(
      column: $table.lunchReminderTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dinnerReminderTime => $composableBuilder(
      column: $table.dinnerReminderTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get nutritionGoalNotifications => $composableBuilder(
      column: $table.nutritionGoalNotifications,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dailyCalorieGoal => $composableBuilder(
      column: $table.dailyCalorieGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dailyCarbsGoal => $composableBuilder(
      column: $table.dailyCarbsGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dailyProteinGoal => $composableBuilder(
      column: $table.dailyProteinGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dailyFatGoal => $composableBuilder(
      column: $table.dailyFatGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dailyFiberGoal => $composableBuilder(
      column: $table.dailyFiberGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsRatio => $composableBuilder(
      column: $table.carbsRatio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinRatio => $composableBuilder(
      column: $table.proteinRatio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatRatio => $composableBuilder(
      column: $table.fatRatio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activityLevel => $composableBuilder(
      column: $table.activityLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goal => $composableBuilder(
      column: $table.goal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dietaryRestrictions => $composableBuilder(
      column: $table.dietaryRestrictions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get allergies => $composableBuilder(
      column: $table.allergies, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dislikedFoods => $composableBuilder(
      column: $table.dislikedFoods,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get aiSuggestionsEnabled => $composableBuilder(
      column: $table.aiSuggestionsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get aiConfidenceThreshold => $composableBuilder(
      column: $table.aiConfidenceThreshold,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get autoSaveRecognitions => $composableBuilder(
      column: $table.autoSaveRecognitions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get mealRemindersEnabled => $composableBuilder(
      column: $table.mealRemindersEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get breakfastReminderTime => $composableBuilder(
      column: $table.breakfastReminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lunchReminderTime => $composableBuilder(
      column: $table.lunchReminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dinnerReminderTime => $composableBuilder(
      column: $table.dinnerReminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get nutritionGoalNotifications => $composableBuilder(
      column: $table.nutritionGoalNotifications,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get dailyCalorieGoal => $composableBuilder(
      column: $table.dailyCalorieGoal, builder: (column) => column);

  GeneratedColumn<double> get dailyCarbsGoal => $composableBuilder(
      column: $table.dailyCarbsGoal, builder: (column) => column);

  GeneratedColumn<double> get dailyProteinGoal => $composableBuilder(
      column: $table.dailyProteinGoal, builder: (column) => column);

  GeneratedColumn<double> get dailyFatGoal => $composableBuilder(
      column: $table.dailyFatGoal, builder: (column) => column);

  GeneratedColumn<double> get dailyFiberGoal => $composableBuilder(
      column: $table.dailyFiberGoal, builder: (column) => column);

  GeneratedColumn<double> get carbsRatio => $composableBuilder(
      column: $table.carbsRatio, builder: (column) => column);

  GeneratedColumn<double> get proteinRatio => $composableBuilder(
      column: $table.proteinRatio, builder: (column) => column);

  GeneratedColumn<double> get fatRatio =>
      $composableBuilder(column: $table.fatRatio, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get activityLevel => $composableBuilder(
      column: $table.activityLevel, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get dietaryRestrictions => $composableBuilder(
      column: $table.dietaryRestrictions, builder: (column) => column);

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get dislikedFoods => $composableBuilder(
      column: $table.dislikedFoods, builder: (column) => column);

  GeneratedColumn<bool> get aiSuggestionsEnabled => $composableBuilder(
      column: $table.aiSuggestionsEnabled, builder: (column) => column);

  GeneratedColumn<double> get aiConfidenceThreshold => $composableBuilder(
      column: $table.aiConfidenceThreshold, builder: (column) => column);

  GeneratedColumn<bool> get autoSaveRecognitions => $composableBuilder(
      column: $table.autoSaveRecognitions, builder: (column) => column);

  GeneratedColumn<bool> get mealRemindersEnabled => $composableBuilder(
      column: $table.mealRemindersEnabled, builder: (column) => column);

  GeneratedColumn<String> get breakfastReminderTime => $composableBuilder(
      column: $table.breakfastReminderTime, builder: (column) => column);

  GeneratedColumn<String> get lunchReminderTime => $composableBuilder(
      column: $table.lunchReminderTime, builder: (column) => column);

  GeneratedColumn<String> get dinnerReminderTime => $composableBuilder(
      column: $table.dinnerReminderTime, builder: (column) => column);

  GeneratedColumn<bool> get nutritionGoalNotifications => $composableBuilder(
      column: $table.nutritionGoalNotifications, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserPreferencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserPreferencesTable,
    UserPreference,
    $$UserPreferencesTableFilterComposer,
    $$UserPreferencesTableOrderingComposer,
    $$UserPreferencesTableAnnotationComposer,
    $$UserPreferencesTableCreateCompanionBuilder,
    $$UserPreferencesTableUpdateCompanionBuilder,
    (
      UserPreference,
      BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference>
    ),
    UserPreference,
    PrefetchHooks Function()> {
  $$UserPreferencesTableTableManager(
      _$AppDatabase db, $UserPreferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<double> dailyCalorieGoal = const Value.absent(),
            Value<double> dailyCarbsGoal = const Value.absent(),
            Value<double> dailyProteinGoal = const Value.absent(),
            Value<double> dailyFatGoal = const Value.absent(),
            Value<double> dailyFiberGoal = const Value.absent(),
            Value<double> carbsRatio = const Value.absent(),
            Value<double> proteinRatio = const Value.absent(),
            Value<double> fatRatio = const Value.absent(),
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> height = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String> activityLevel = const Value.absent(),
            Value<String> goal = const Value.absent(),
            Value<String?> dietaryRestrictions = const Value.absent(),
            Value<String?> allergies = const Value.absent(),
            Value<String?> dislikedFoods = const Value.absent(),
            Value<bool> aiSuggestionsEnabled = const Value.absent(),
            Value<double> aiConfidenceThreshold = const Value.absent(),
            Value<bool> autoSaveRecognitions = const Value.absent(),
            Value<bool> mealRemindersEnabled = const Value.absent(),
            Value<String?> breakfastReminderTime = const Value.absent(),
            Value<String?> lunchReminderTime = const Value.absent(),
            Value<String?> dinnerReminderTime = const Value.absent(),
            Value<bool> nutritionGoalNotifications = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserPreferencesCompanion(
            userId: userId,
            dailyCalorieGoal: dailyCalorieGoal,
            dailyCarbsGoal: dailyCarbsGoal,
            dailyProteinGoal: dailyProteinGoal,
            dailyFatGoal: dailyFatGoal,
            dailyFiberGoal: dailyFiberGoal,
            carbsRatio: carbsRatio,
            proteinRatio: proteinRatio,
            fatRatio: fatRatio,
            age: age,
            gender: gender,
            height: height,
            weight: weight,
            activityLevel: activityLevel,
            goal: goal,
            dietaryRestrictions: dietaryRestrictions,
            allergies: allergies,
            dislikedFoods: dislikedFoods,
            aiSuggestionsEnabled: aiSuggestionsEnabled,
            aiConfidenceThreshold: aiConfidenceThreshold,
            autoSaveRecognitions: autoSaveRecognitions,
            mealRemindersEnabled: mealRemindersEnabled,
            breakfastReminderTime: breakfastReminderTime,
            lunchReminderTime: lunchReminderTime,
            dinnerReminderTime: dinnerReminderTime,
            nutritionGoalNotifications: nutritionGoalNotifications,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            Value<double> dailyCalorieGoal = const Value.absent(),
            Value<double> dailyCarbsGoal = const Value.absent(),
            Value<double> dailyProteinGoal = const Value.absent(),
            Value<double> dailyFatGoal = const Value.absent(),
            Value<double> dailyFiberGoal = const Value.absent(),
            Value<double> carbsRatio = const Value.absent(),
            Value<double> proteinRatio = const Value.absent(),
            Value<double> fatRatio = const Value.absent(),
            Value<int?> age = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<double?> height = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<String> activityLevel = const Value.absent(),
            Value<String> goal = const Value.absent(),
            Value<String?> dietaryRestrictions = const Value.absent(),
            Value<String?> allergies = const Value.absent(),
            Value<String?> dislikedFoods = const Value.absent(),
            Value<bool> aiSuggestionsEnabled = const Value.absent(),
            Value<double> aiConfidenceThreshold = const Value.absent(),
            Value<bool> autoSaveRecognitions = const Value.absent(),
            Value<bool> mealRemindersEnabled = const Value.absent(),
            Value<String?> breakfastReminderTime = const Value.absent(),
            Value<String?> lunchReminderTime = const Value.absent(),
            Value<String?> dinnerReminderTime = const Value.absent(),
            Value<bool> nutritionGoalNotifications = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserPreferencesCompanion.insert(
            userId: userId,
            dailyCalorieGoal: dailyCalorieGoal,
            dailyCarbsGoal: dailyCarbsGoal,
            dailyProteinGoal: dailyProteinGoal,
            dailyFatGoal: dailyFatGoal,
            dailyFiberGoal: dailyFiberGoal,
            carbsRatio: carbsRatio,
            proteinRatio: proteinRatio,
            fatRatio: fatRatio,
            age: age,
            gender: gender,
            height: height,
            weight: weight,
            activityLevel: activityLevel,
            goal: goal,
            dietaryRestrictions: dietaryRestrictions,
            allergies: allergies,
            dislikedFoods: dislikedFoods,
            aiSuggestionsEnabled: aiSuggestionsEnabled,
            aiConfidenceThreshold: aiConfidenceThreshold,
            autoSaveRecognitions: autoSaveRecognitions,
            mealRemindersEnabled: mealRemindersEnabled,
            breakfastReminderTime: breakfastReminderTime,
            lunchReminderTime: lunchReminderTime,
            dinnerReminderTime: dinnerReminderTime,
            nutritionGoalNotifications: nutritionGoalNotifications,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserPreferencesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserPreferencesTable,
    UserPreference,
    $$UserPreferencesTableFilterComposer,
    $$UserPreferencesTableOrderingComposer,
    $$UserPreferencesTableAnnotationComposer,
    $$UserPreferencesTableCreateCompanionBuilder,
    $$UserPreferencesTableUpdateCompanionBuilder,
    (
      UserPreference,
      BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference>
    ),
    UserPreference,
    PrefetchHooks Function()>;
typedef $$CustomFoodsTableCreateCompanionBuilder = CustomFoodsCompanion
    Function({
  Value<int> id,
  required String userId,
  required String name,
  Value<String?> description,
  required double kcalPer100g,
  Value<double> carbsPer100g,
  Value<double> proteinPer100g,
  Value<double> fatPer100g,
  Value<double> fiberPer100g,
  Value<String?> recipe,
  Value<String?> ingredients,
  Value<int> usageCount,
  Value<DateTime?> lastUsedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$CustomFoodsTableUpdateCompanionBuilder = CustomFoodsCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<String> name,
  Value<String?> description,
  Value<double> kcalPer100g,
  Value<double> carbsPer100g,
  Value<double> proteinPer100g,
  Value<double> fatPer100g,
  Value<double> fiberPer100g,
  Value<String?> recipe,
  Value<String?> ingredients,
  Value<int> usageCount,
  Value<DateTime?> lastUsedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$CustomFoodsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomFoodsTable> {
  $$CustomFoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get kcalPer100g => $composableBuilder(
      column: $table.kcalPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
      column: $table.carbsPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
      column: $table.proteinPer100g,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatPer100g => $composableBuilder(
      column: $table.fatPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fiberPer100g => $composableBuilder(
      column: $table.fiberPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recipe => $composableBuilder(
      column: $table.recipe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ingredients => $composableBuilder(
      column: $table.ingredients, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CustomFoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomFoodsTable> {
  $$CustomFoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get kcalPer100g => $composableBuilder(
      column: $table.kcalPer100g, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
      column: $table.carbsPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
      column: $table.proteinPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
      column: $table.fatPer100g, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fiberPer100g => $composableBuilder(
      column: $table.fiberPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recipe => $composableBuilder(
      column: $table.recipe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ingredients => $composableBuilder(
      column: $table.ingredients, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CustomFoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomFoodsTable> {
  $$CustomFoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get kcalPer100g => $composableBuilder(
      column: $table.kcalPer100g, builder: (column) => column);

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
      column: $table.carbsPer100g, builder: (column) => column);

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
      column: $table.proteinPer100g, builder: (column) => column);

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
      column: $table.fatPer100g, builder: (column) => column);

  GeneratedColumn<double> get fiberPer100g => $composableBuilder(
      column: $table.fiberPer100g, builder: (column) => column);

  GeneratedColumn<String> get recipe =>
      $composableBuilder(column: $table.recipe, builder: (column) => column);

  GeneratedColumn<String> get ingredients => $composableBuilder(
      column: $table.ingredients, builder: (column) => column);

  GeneratedColumn<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CustomFoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomFoodsTable,
    CustomFood,
    $$CustomFoodsTableFilterComposer,
    $$CustomFoodsTableOrderingComposer,
    $$CustomFoodsTableAnnotationComposer,
    $$CustomFoodsTableCreateCompanionBuilder,
    $$CustomFoodsTableUpdateCompanionBuilder,
    (CustomFood, BaseReferences<_$AppDatabase, $CustomFoodsTable, CustomFood>),
    CustomFood,
    PrefetchHooks Function()> {
  $$CustomFoodsTableTableManager(_$AppDatabase db, $CustomFoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomFoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomFoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomFoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<double> kcalPer100g = const Value.absent(),
            Value<double> carbsPer100g = const Value.absent(),
            Value<double> proteinPer100g = const Value.absent(),
            Value<double> fatPer100g = const Value.absent(),
            Value<double> fiberPer100g = const Value.absent(),
            Value<String?> recipe = const Value.absent(),
            Value<String?> ingredients = const Value.absent(),
            Value<int> usageCount = const Value.absent(),
            Value<DateTime?> lastUsedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CustomFoodsCompanion(
            id: id,
            userId: userId,
            name: name,
            description: description,
            kcalPer100g: kcalPer100g,
            carbsPer100g: carbsPer100g,
            proteinPer100g: proteinPer100g,
            fatPer100g: fatPer100g,
            fiberPer100g: fiberPer100g,
            recipe: recipe,
            ingredients: ingredients,
            usageCount: usageCount,
            lastUsedAt: lastUsedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String name,
            Value<String?> description = const Value.absent(),
            required double kcalPer100g,
            Value<double> carbsPer100g = const Value.absent(),
            Value<double> proteinPer100g = const Value.absent(),
            Value<double> fatPer100g = const Value.absent(),
            Value<double> fiberPer100g = const Value.absent(),
            Value<String?> recipe = const Value.absent(),
            Value<String?> ingredients = const Value.absent(),
            Value<int> usageCount = const Value.absent(),
            Value<DateTime?> lastUsedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CustomFoodsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            description: description,
            kcalPer100g: kcalPer100g,
            carbsPer100g: carbsPer100g,
            proteinPer100g: proteinPer100g,
            fatPer100g: fatPer100g,
            fiberPer100g: fiberPer100g,
            recipe: recipe,
            ingredients: ingredients,
            usageCount: usageCount,
            lastUsedAt: lastUsedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CustomFoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomFoodsTable,
    CustomFood,
    $$CustomFoodsTableFilterComposer,
    $$CustomFoodsTableOrderingComposer,
    $$CustomFoodsTableAnnotationComposer,
    $$CustomFoodsTableCreateCompanionBuilder,
    $$CustomFoodsTableUpdateCompanionBuilder,
    (CustomFood, BaseReferences<_$AppDatabase, $CustomFoodsTable, CustomFood>),
    CustomFood,
    PrefetchHooks Function()>;
typedef $$UserFoodStatisticsTableCreateCompanionBuilder
    = UserFoodStatisticsCompanion Function({
  Value<int> id,
  required String userId,
  required int foodId,
  required String foodType,
  Value<int> totalConsumptions,
  Value<double> averagePortionGrams,
  Value<DateTime?> firstConsumedAt,
  Value<DateTime?> lastConsumedAt,
  Value<double> preferenceScore,
  Value<String?> preferredMealTypes,
  Value<DateTime> updatedAt,
});
typedef $$UserFoodStatisticsTableUpdateCompanionBuilder
    = UserFoodStatisticsCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<int> foodId,
  Value<String> foodType,
  Value<int> totalConsumptions,
  Value<double> averagePortionGrams,
  Value<DateTime?> firstConsumedAt,
  Value<DateTime?> lastConsumedAt,
  Value<double> preferenceScore,
  Value<String?> preferredMealTypes,
  Value<DateTime> updatedAt,
});

class $$UserFoodStatisticsTableFilterComposer
    extends Composer<_$AppDatabase, $UserFoodStatisticsTable> {
  $$UserFoodStatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodType => $composableBuilder(
      column: $table.foodType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalConsumptions => $composableBuilder(
      column: $table.totalConsumptions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get averagePortionGrams => $composableBuilder(
      column: $table.averagePortionGrams,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get firstConsumedAt => $composableBuilder(
      column: $table.firstConsumedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastConsumedAt => $composableBuilder(
      column: $table.lastConsumedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get preferenceScore => $composableBuilder(
      column: $table.preferenceScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preferredMealTypes => $composableBuilder(
      column: $table.preferredMealTypes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserFoodStatisticsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFoodStatisticsTable> {
  $$UserFoodStatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodType => $composableBuilder(
      column: $table.foodType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalConsumptions => $composableBuilder(
      column: $table.totalConsumptions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get averagePortionGrams => $composableBuilder(
      column: $table.averagePortionGrams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firstConsumedAt => $composableBuilder(
      column: $table.firstConsumedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastConsumedAt => $composableBuilder(
      column: $table.lastConsumedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get preferenceScore => $composableBuilder(
      column: $table.preferenceScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preferredMealTypes => $composableBuilder(
      column: $table.preferredMealTypes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserFoodStatisticsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFoodStatisticsTable> {
  $$UserFoodStatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get foodType =>
      $composableBuilder(column: $table.foodType, builder: (column) => column);

  GeneratedColumn<int> get totalConsumptions => $composableBuilder(
      column: $table.totalConsumptions, builder: (column) => column);

  GeneratedColumn<double> get averagePortionGrams => $composableBuilder(
      column: $table.averagePortionGrams, builder: (column) => column);

  GeneratedColumn<DateTime> get firstConsumedAt => $composableBuilder(
      column: $table.firstConsumedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastConsumedAt => $composableBuilder(
      column: $table.lastConsumedAt, builder: (column) => column);

  GeneratedColumn<double> get preferenceScore => $composableBuilder(
      column: $table.preferenceScore, builder: (column) => column);

  GeneratedColumn<String> get preferredMealTypes => $composableBuilder(
      column: $table.preferredMealTypes, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserFoodStatisticsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserFoodStatisticsTable,
    UserFoodStatistic,
    $$UserFoodStatisticsTableFilterComposer,
    $$UserFoodStatisticsTableOrderingComposer,
    $$UserFoodStatisticsTableAnnotationComposer,
    $$UserFoodStatisticsTableCreateCompanionBuilder,
    $$UserFoodStatisticsTableUpdateCompanionBuilder,
    (
      UserFoodStatistic,
      BaseReferences<_$AppDatabase, $UserFoodStatisticsTable, UserFoodStatistic>
    ),
    UserFoodStatistic,
    PrefetchHooks Function()> {
  $$UserFoodStatisticsTableTableManager(
      _$AppDatabase db, $UserFoodStatisticsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFoodStatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserFoodStatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserFoodStatisticsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> foodId = const Value.absent(),
            Value<String> foodType = const Value.absent(),
            Value<int> totalConsumptions = const Value.absent(),
            Value<double> averagePortionGrams = const Value.absent(),
            Value<DateTime?> firstConsumedAt = const Value.absent(),
            Value<DateTime?> lastConsumedAt = const Value.absent(),
            Value<double> preferenceScore = const Value.absent(),
            Value<String?> preferredMealTypes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserFoodStatisticsCompanion(
            id: id,
            userId: userId,
            foodId: foodId,
            foodType: foodType,
            totalConsumptions: totalConsumptions,
            averagePortionGrams: averagePortionGrams,
            firstConsumedAt: firstConsumedAt,
            lastConsumedAt: lastConsumedAt,
            preferenceScore: preferenceScore,
            preferredMealTypes: preferredMealTypes,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required int foodId,
            required String foodType,
            Value<int> totalConsumptions = const Value.absent(),
            Value<double> averagePortionGrams = const Value.absent(),
            Value<DateTime?> firstConsumedAt = const Value.absent(),
            Value<DateTime?> lastConsumedAt = const Value.absent(),
            Value<double> preferenceScore = const Value.absent(),
            Value<String?> preferredMealTypes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserFoodStatisticsCompanion.insert(
            id: id,
            userId: userId,
            foodId: foodId,
            foodType: foodType,
            totalConsumptions: totalConsumptions,
            averagePortionGrams: averagePortionGrams,
            firstConsumedAt: firstConsumedAt,
            lastConsumedAt: lastConsumedAt,
            preferenceScore: preferenceScore,
            preferredMealTypes: preferredMealTypes,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserFoodStatisticsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserFoodStatisticsTable,
    UserFoodStatistic,
    $$UserFoodStatisticsTableFilterComposer,
    $$UserFoodStatisticsTableOrderingComposer,
    $$UserFoodStatisticsTableAnnotationComposer,
    $$UserFoodStatisticsTableCreateCompanionBuilder,
    $$UserFoodStatisticsTableUpdateCompanionBuilder,
    (
      UserFoodStatistic,
      BaseReferences<_$AppDatabase, $UserFoodStatisticsTable, UserFoodStatistic>
    ),
    UserFoodStatistic,
    PrefetchHooks Function()>;
typedef $$DailyActivitiesTableCreateCompanionBuilder = DailyActivitiesCompanion
    Function({
  required String userId,
  required DateTime date,
  Value<int> steps,
  Value<int> distanceMeters,
  Value<int> caloriesBurned,
  Value<int> activeMinutes,
  Value<int> lightActivityMinutes,
  Value<int> moderateActivityMinutes,
  Value<int> vigorousActivityMinutes,
  Value<int> sedentaryMinutes,
  Value<int?> heartRateAverage,
  Value<int?> heartRateMax,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$DailyActivitiesTableUpdateCompanionBuilder = DailyActivitiesCompanion
    Function({
  Value<String> userId,
  Value<DateTime> date,
  Value<int> steps,
  Value<int> distanceMeters,
  Value<int> caloriesBurned,
  Value<int> activeMinutes,
  Value<int> lightActivityMinutes,
  Value<int> moderateActivityMinutes,
  Value<int> vigorousActivityMinutes,
  Value<int> sedentaryMinutes,
  Value<int?> heartRateAverage,
  Value<int?> heartRateMax,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DailyActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get distanceMeters => $composableBuilder(
      column: $table.distanceMeters,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get activeMinutes => $composableBuilder(
      column: $table.activeMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lightActivityMinutes => $composableBuilder(
      column: $table.lightActivityMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get moderateActivityMinutes => $composableBuilder(
      column: $table.moderateActivityMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vigorousActivityMinutes => $composableBuilder(
      column: $table.vigorousActivityMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sedentaryMinutes => $composableBuilder(
      column: $table.sedentaryMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get heartRateAverage => $composableBuilder(
      column: $table.heartRateAverage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get heartRateMax => $composableBuilder(
      column: $table.heartRateMax, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get distanceMeters => $composableBuilder(
      column: $table.distanceMeters,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activeMinutes => $composableBuilder(
      column: $table.activeMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lightActivityMinutes => $composableBuilder(
      column: $table.lightActivityMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get moderateActivityMinutes => $composableBuilder(
      column: $table.moderateActivityMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vigorousActivityMinutes => $composableBuilder(
      column: $table.vigorousActivityMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sedentaryMinutes => $composableBuilder(
      column: $table.sedentaryMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get heartRateAverage => $composableBuilder(
      column: $table.heartRateAverage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get heartRateMax => $composableBuilder(
      column: $table.heartRateMax,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<int> get distanceMeters => $composableBuilder(
      column: $table.distanceMeters, builder: (column) => column);

  GeneratedColumn<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned, builder: (column) => column);

  GeneratedColumn<int> get activeMinutes => $composableBuilder(
      column: $table.activeMinutes, builder: (column) => column);

  GeneratedColumn<int> get lightActivityMinutes => $composableBuilder(
      column: $table.lightActivityMinutes, builder: (column) => column);

  GeneratedColumn<int> get moderateActivityMinutes => $composableBuilder(
      column: $table.moderateActivityMinutes, builder: (column) => column);

  GeneratedColumn<int> get vigorousActivityMinutes => $composableBuilder(
      column: $table.vigorousActivityMinutes, builder: (column) => column);

  GeneratedColumn<int> get sedentaryMinutes => $composableBuilder(
      column: $table.sedentaryMinutes, builder: (column) => column);

  GeneratedColumn<int> get heartRateAverage => $composableBuilder(
      column: $table.heartRateAverage, builder: (column) => column);

  GeneratedColumn<int> get heartRateMax => $composableBuilder(
      column: $table.heartRateMax, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyActivitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyActivitiesTable,
    DailyActivity,
    $$DailyActivitiesTableFilterComposer,
    $$DailyActivitiesTableOrderingComposer,
    $$DailyActivitiesTableAnnotationComposer,
    $$DailyActivitiesTableCreateCompanionBuilder,
    $$DailyActivitiesTableUpdateCompanionBuilder,
    (
      DailyActivity,
      BaseReferences<_$AppDatabase, $DailyActivitiesTable, DailyActivity>
    ),
    DailyActivity,
    PrefetchHooks Function()> {
  $$DailyActivitiesTableTableManager(
      _$AppDatabase db, $DailyActivitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> steps = const Value.absent(),
            Value<int> distanceMeters = const Value.absent(),
            Value<int> caloriesBurned = const Value.absent(),
            Value<int> activeMinutes = const Value.absent(),
            Value<int> lightActivityMinutes = const Value.absent(),
            Value<int> moderateActivityMinutes = const Value.absent(),
            Value<int> vigorousActivityMinutes = const Value.absent(),
            Value<int> sedentaryMinutes = const Value.absent(),
            Value<int?> heartRateAverage = const Value.absent(),
            Value<int?> heartRateMax = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyActivitiesCompanion(
            userId: userId,
            date: date,
            steps: steps,
            distanceMeters: distanceMeters,
            caloriesBurned: caloriesBurned,
            activeMinutes: activeMinutes,
            lightActivityMinutes: lightActivityMinutes,
            moderateActivityMinutes: moderateActivityMinutes,
            vigorousActivityMinutes: vigorousActivityMinutes,
            sedentaryMinutes: sedentaryMinutes,
            heartRateAverage: heartRateAverage,
            heartRateMax: heartRateMax,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required DateTime date,
            Value<int> steps = const Value.absent(),
            Value<int> distanceMeters = const Value.absent(),
            Value<int> caloriesBurned = const Value.absent(),
            Value<int> activeMinutes = const Value.absent(),
            Value<int> lightActivityMinutes = const Value.absent(),
            Value<int> moderateActivityMinutes = const Value.absent(),
            Value<int> vigorousActivityMinutes = const Value.absent(),
            Value<int> sedentaryMinutes = const Value.absent(),
            Value<int?> heartRateAverage = const Value.absent(),
            Value<int?> heartRateMax = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyActivitiesCompanion.insert(
            userId: userId,
            date: date,
            steps: steps,
            distanceMeters: distanceMeters,
            caloriesBurned: caloriesBurned,
            activeMinutes: activeMinutes,
            lightActivityMinutes: lightActivityMinutes,
            moderateActivityMinutes: moderateActivityMinutes,
            vigorousActivityMinutes: vigorousActivityMinutes,
            sedentaryMinutes: sedentaryMinutes,
            heartRateAverage: heartRateAverage,
            heartRateMax: heartRateMax,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyActivitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyActivitiesTable,
    DailyActivity,
    $$DailyActivitiesTableFilterComposer,
    $$DailyActivitiesTableOrderingComposer,
    $$DailyActivitiesTableAnnotationComposer,
    $$DailyActivitiesTableCreateCompanionBuilder,
    $$DailyActivitiesTableUpdateCompanionBuilder,
    (
      DailyActivity,
      BaseReferences<_$AppDatabase, $DailyActivitiesTable, DailyActivity>
    ),
    DailyActivity,
    PrefetchHooks Function()>;
typedef $$WorkoutSessionsTableCreateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  Value<int> id,
  required String userId,
  required String type,
  required String name,
  required DateTime startTime,
  required DateTime endTime,
  required int duration,
  Value<String> intensity,
  Value<int> caloriesBurned,
  Value<double?> distance,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$WorkoutSessionsTableUpdateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<String> type,
  Value<String> name,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<int> duration,
  Value<String> intensity,
  Value<int> caloriesBurned,
  Value<double?> distance,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<int> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned, builder: (column) => column);

  GeneratedColumn<double> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WorkoutSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    WorkoutSession,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (
      WorkoutSession,
      BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession>
    ),
    WorkoutSession,
    PrefetchHooks Function()> {
  $$WorkoutSessionsTableTableManager(
      _$AppDatabase db, $WorkoutSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<String> intensity = const Value.absent(),
            Value<int> caloriesBurned = const Value.absent(),
            Value<double?> distance = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion(
            id: id,
            userId: userId,
            type: type,
            name: name,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            intensity: intensity,
            caloriesBurned: caloriesBurned,
            distance: distance,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String type,
            required String name,
            required DateTime startTime,
            required DateTime endTime,
            required int duration,
            Value<String> intensity = const Value.absent(),
            Value<int> caloriesBurned = const Value.absent(),
            Value<double?> distance = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion.insert(
            id: id,
            userId: userId,
            type: type,
            name: name,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            intensity: intensity,
            caloriesBurned: caloriesBurned,
            distance: distance,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    WorkoutSession,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (
      WorkoutSession,
      BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession>
    ),
    WorkoutSession,
    PrefetchHooks Function()>;
typedef $$ActivityGoalsTableCreateCompanionBuilder = ActivityGoalsCompanion
    Function({
  required String userId,
  Value<int> stepsGoal,
  Value<int> caloriesBurnedGoal,
  Value<int> activeMinutesGoal,
  Value<int> distanceGoal,
  Value<int> workoutsPerWeekGoal,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ActivityGoalsTableUpdateCompanionBuilder = ActivityGoalsCompanion
    Function({
  Value<String> userId,
  Value<int> stepsGoal,
  Value<int> caloriesBurnedGoal,
  Value<int> activeMinutesGoal,
  Value<int> distanceGoal,
  Value<int> workoutsPerWeekGoal,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ActivityGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityGoalsTable> {
  $$ActivityGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stepsGoal => $composableBuilder(
      column: $table.stepsGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get caloriesBurnedGoal => $composableBuilder(
      column: $table.caloriesBurnedGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get activeMinutesGoal => $composableBuilder(
      column: $table.activeMinutesGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get distanceGoal => $composableBuilder(
      column: $table.distanceGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workoutsPerWeekGoal => $composableBuilder(
      column: $table.workoutsPerWeekGoal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ActivityGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityGoalsTable> {
  $$ActivityGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stepsGoal => $composableBuilder(
      column: $table.stepsGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get caloriesBurnedGoal => $composableBuilder(
      column: $table.caloriesBurnedGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activeMinutesGoal => $composableBuilder(
      column: $table.activeMinutesGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get distanceGoal => $composableBuilder(
      column: $table.distanceGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workoutsPerWeekGoal => $composableBuilder(
      column: $table.workoutsPerWeekGoal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ActivityGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityGoalsTable> {
  $$ActivityGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get stepsGoal =>
      $composableBuilder(column: $table.stepsGoal, builder: (column) => column);

  GeneratedColumn<int> get caloriesBurnedGoal => $composableBuilder(
      column: $table.caloriesBurnedGoal, builder: (column) => column);

  GeneratedColumn<int> get activeMinutesGoal => $composableBuilder(
      column: $table.activeMinutesGoal, builder: (column) => column);

  GeneratedColumn<int> get distanceGoal => $composableBuilder(
      column: $table.distanceGoal, builder: (column) => column);

  GeneratedColumn<int> get workoutsPerWeekGoal => $composableBuilder(
      column: $table.workoutsPerWeekGoal, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ActivityGoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActivityGoalsTable,
    ActivityGoal,
    $$ActivityGoalsTableFilterComposer,
    $$ActivityGoalsTableOrderingComposer,
    $$ActivityGoalsTableAnnotationComposer,
    $$ActivityGoalsTableCreateCompanionBuilder,
    $$ActivityGoalsTableUpdateCompanionBuilder,
    (
      ActivityGoal,
      BaseReferences<_$AppDatabase, $ActivityGoalsTable, ActivityGoal>
    ),
    ActivityGoal,
    PrefetchHooks Function()> {
  $$ActivityGoalsTableTableManager(_$AppDatabase db, $ActivityGoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> stepsGoal = const Value.absent(),
            Value<int> caloriesBurnedGoal = const Value.absent(),
            Value<int> activeMinutesGoal = const Value.absent(),
            Value<int> distanceGoal = const Value.absent(),
            Value<int> workoutsPerWeekGoal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityGoalsCompanion(
            userId: userId,
            stepsGoal: stepsGoal,
            caloriesBurnedGoal: caloriesBurnedGoal,
            activeMinutesGoal: activeMinutesGoal,
            distanceGoal: distanceGoal,
            workoutsPerWeekGoal: workoutsPerWeekGoal,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            Value<int> stepsGoal = const Value.absent(),
            Value<int> caloriesBurnedGoal = const Value.absent(),
            Value<int> activeMinutesGoal = const Value.absent(),
            Value<int> distanceGoal = const Value.absent(),
            Value<int> workoutsPerWeekGoal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityGoalsCompanion.insert(
            userId: userId,
            stepsGoal: stepsGoal,
            caloriesBurnedGoal: caloriesBurnedGoal,
            activeMinutesGoal: activeMinutesGoal,
            distanceGoal: distanceGoal,
            workoutsPerWeekGoal: workoutsPerWeekGoal,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ActivityGoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActivityGoalsTable,
    ActivityGoal,
    $$ActivityGoalsTableFilterComposer,
    $$ActivityGoalsTableOrderingComposer,
    $$ActivityGoalsTableAnnotationComposer,
    $$ActivityGoalsTableCreateCompanionBuilder,
    $$ActivityGoalsTableUpdateCompanionBuilder,
    (
      ActivityGoal,
      BaseReferences<_$AppDatabase, $ActivityGoalsTable, ActivityGoal>
    ),
    ActivityGoal,
    PrefetchHooks Function()>;
typedef $$WeightRecordsTableCreateCompanionBuilder = WeightRecordsCompanion
    Function({
  Value<int> id,
  required String userId,
  required DateTime date,
  required double weight,
  Value<double?> bodyFatPercentage,
  Value<double?> muscleMass,
  Value<double?> visceralFat,
  Value<double?> bmi,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$WeightRecordsTableUpdateCompanionBuilder = WeightRecordsCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<DateTime> date,
  Value<double> weight,
  Value<double?> bodyFatPercentage,
  Value<double?> muscleMass,
  Value<double?> visceralFat,
  Value<double?> bmi,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

class $$WeightRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bodyFatPercentage => $composableBuilder(
      column: $table.bodyFatPercentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get muscleMass => $composableBuilder(
      column: $table.muscleMass, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get visceralFat => $composableBuilder(
      column: $table.visceralFat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bmi => $composableBuilder(
      column: $table.bmi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$WeightRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bodyFatPercentage => $composableBuilder(
      column: $table.bodyFatPercentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get muscleMass => $composableBuilder(
      column: $table.muscleMass, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get visceralFat => $composableBuilder(
      column: $table.visceralFat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bmi => $composableBuilder(
      column: $table.bmi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$WeightRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get bodyFatPercentage => $composableBuilder(
      column: $table.bodyFatPercentage, builder: (column) => column);

  GeneratedColumn<double> get muscleMass => $composableBuilder(
      column: $table.muscleMass, builder: (column) => column);

  GeneratedColumn<double> get visceralFat => $composableBuilder(
      column: $table.visceralFat, builder: (column) => column);

  GeneratedColumn<double> get bmi =>
      $composableBuilder(column: $table.bmi, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WeightRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeightRecordsTable,
    WeightRecord,
    $$WeightRecordsTableFilterComposer,
    $$WeightRecordsTableOrderingComposer,
    $$WeightRecordsTableAnnotationComposer,
    $$WeightRecordsTableCreateCompanionBuilder,
    $$WeightRecordsTableUpdateCompanionBuilder,
    (
      WeightRecord,
      BaseReferences<_$AppDatabase, $WeightRecordsTable, WeightRecord>
    ),
    WeightRecord,
    PrefetchHooks Function()> {
  $$WeightRecordsTableTableManager(_$AppDatabase db, $WeightRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<double?> bodyFatPercentage = const Value.absent(),
            Value<double?> muscleMass = const Value.absent(),
            Value<double?> visceralFat = const Value.absent(),
            Value<double?> bmi = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              WeightRecordsCompanion(
            id: id,
            userId: userId,
            date: date,
            weight: weight,
            bodyFatPercentage: bodyFatPercentage,
            muscleMass: muscleMass,
            visceralFat: visceralFat,
            bmi: bmi,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required DateTime date,
            required double weight,
            Value<double?> bodyFatPercentage = const Value.absent(),
            Value<double?> muscleMass = const Value.absent(),
            Value<double?> visceralFat = const Value.absent(),
            Value<double?> bmi = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              WeightRecordsCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            weight: weight,
            bodyFatPercentage: bodyFatPercentage,
            muscleMass: muscleMass,
            visceralFat: visceralFat,
            bmi: bmi,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeightRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeightRecordsTable,
    WeightRecord,
    $$WeightRecordsTableFilterComposer,
    $$WeightRecordsTableOrderingComposer,
    $$WeightRecordsTableAnnotationComposer,
    $$WeightRecordsTableCreateCompanionBuilder,
    $$WeightRecordsTableUpdateCompanionBuilder,
    (
      WeightRecord,
      BaseReferences<_$AppDatabase, $WeightRecordsTable, WeightRecord>
    ),
    WeightRecord,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodsTableTableManager get foods =>
      $$FoodsTableTableManager(_db, _db.foods);
  $$FoodSynonymsTableTableManager get foodSynonyms =>
      $$FoodSynonymsTableTableManager(_db, _db.foodSynonyms);
  $$CommonPortionsTableTableManager get commonPortions =>
      $$CommonPortionsTableTableManager(_db, _db.commonPortions);
  $$FoodEntriesTableTableManager get foodEntries =>
      $$FoodEntriesTableTableManager(_db, _db.foodEntries);
  $$FavoritePortionsTableTableManager get favoritePortions =>
      $$FavoritePortionsTableTableManager(_db, _db.favoritePortions);
  $$DailyNutritionSummariesTableTableManager get dailyNutritionSummaries =>
      $$DailyNutritionSummariesTableTableManager(
          _db, _db.dailyNutritionSummaries);
  $$RecognitionHistoriesTableTableManager get recognitionHistories =>
      $$RecognitionHistoriesTableTableManager(_db, _db.recognitionHistories);
  $$RecognitionResultsTableTableManager get recognitionResults =>
      $$RecognitionResultsTableTableManager(_db, _db.recognitionResults);
  $$RecognitionFeedbacksTableTableManager get recognitionFeedbacks =>
      $$RecognitionFeedbacksTableTableManager(_db, _db.recognitionFeedbacks);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$CustomFoodsTableTableManager get customFoods =>
      $$CustomFoodsTableTableManager(_db, _db.customFoods);
  $$UserFoodStatisticsTableTableManager get userFoodStatistics =>
      $$UserFoodStatisticsTableTableManager(_db, _db.userFoodStatistics);
  $$DailyActivitiesTableTableManager get dailyActivities =>
      $$DailyActivitiesTableTableManager(_db, _db.dailyActivities);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$ActivityGoalsTableTableManager get activityGoals =>
      $$ActivityGoalsTableTableManager(_db, _db.activityGoals);
  $$WeightRecordsTableTableManager get weightRecords =>
      $$WeightRecordsTableTableManager(_db, _db.weightRecords);
}
