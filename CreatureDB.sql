use master
go

drop database if exists CreatureDB
go

create database CreatureDB
go

use CreatureDB
go

-- PlayerCharacters table 
-- , is not referenced by other tables
create table PlayerCharacters
(
	CharacterID			int			identity	primary key
	,CharacterName		varchar(50)				not null	
)

insert into PlayerCharacters(CharacterName)
values ('Sola')
	,('Hrom')

-- Dice table
-- referenced by Creatures, Abilities, CreatureAttacks, and AttackModifiers
create table Dice
(
	DiceID				tinyint		identity	primary key
	,DiceType			tinyint					not null check(DiceType > 0)
)

insert into Dice(DiceType)
values (4)	--1
	,(6)	--2
	,(8)	--3
	,(10)	--4
	,(12)	--5
	,(20)	--6
	,(100)	--7

-- Size table
-- referenced by Creatures table
create table Size
(
	SizeID				tinyint		identity	primary key
	,Size				varchar(20)				not null
)

insert into Size(Size)
values ('Tiny')		--1
	,('Small')		--2
	,('Medium')		--3
	,('Large')		--4
	,('Huge')		--5
	,('Gargantuan')	--6

-- Type table
-- referenced by Creatures table
create table [Type]
(
	TypeID				tinyint		identity	primary key
	,[Type]				varchar(20)				not null
)

insert into [Type]([Type])
values ('Humanoid')
	,('Animal')
	,('Monster')
	,('Dragon')

-- Alignment table
-- referenced by Creatures table
create table Alignment
(
	AlignmentID			tinyint		identity	primary key
	,Alignment			varchar(20)				not null
)

insert into Alignment(Alignment)
values ('Unaligned')		--1
	,('Any')				--2
	,('Lawful Good')		--3
	,('Neutral Good')		--4
	,('Chaotic Good')		--5
	,('Lawful Neutral')		--6
	,('True Neutral')		--7
	,('Chaotic Neutral')	--8
	,('Lawful Evil')		--9
	,('Neutral Evil')		--10
	,('Chaotic Evil')		--11

-- ArmorTypes table
-- referenced by Creatures table
create table ArmorTypes
(
	ArmorID				tinyint		identity	primary key
	,ArmorType			varchar(50)				not null
)

insert into ArmorTypes(ArmorType)
values ('Natural')			--1
	,('Hide')				--2
	,('Scale')				--3
	,('Cloth')				--4
	,('Leather')			--5
	,('Studded Leather')	--6
	,('Chain')				--7
	,('Breast Plate')		--8
	,('Plate')				--9

-- Creatures table
-- referenced by CreatureMovement, CreatureSenses, CreatureResistances
-- , CreatureConditionalImmunities, CreatureSaves, CreatureSpecialAbilities
-- , CreatureLanguages, CreatureProficiences, CreatureAbilities, and CreatureAttacks
create table Creatures
(
	CreatureID			int			identity	primary key
	,CreatureName		varchar(100)			not null
	,CreatureSize		tinyint					references Size(SizeID)
	,CreatureType		tinyint					references [Type](TypeID)
	,CreatureAlignment	tinyint					references Alignment(AlignmentID)
	,HealthDieCount		tinyint					not null
	,HealthDie			tinyint					references Dice(DiceID)
	,HealthModifier		smallint				not null
	,CreatureArmor		tinyint					references ArmorTypes(ArmorID)
	,ArmorClass			tinyint					not null
	,Strength			tinyint					not null
	,Dexterity			tinyint					not null
	,Constitution		tinyint					not null
	,Intelligence		tinyint					not null
	,Wisdom				tinyint					not null
	,Charisma			tinyint					not null
	,ChallengeRating	varchar(4)				not null
	,Experience			int						not null check(Experience >= 0)
)

insert into Creatures(CreatureName, CreatureSize, CreatureType
	, CreatureAlignment, HealthDieCount, HealthDie, HealthModifier
	, CreatureArmor, ArmorClass, Strength, Dexterity, Constitution
	, Intelligence, Wisdom, Charisma, ChallengeRating, Experience)
values ('Goblin', 2, 1
	, 10, 2, 2, 0
	, 5, 15, 8, 14, 10
	, 10, 8, 8, '1/4', 50)
	,('Ancient White Dragon', 6, 4
	, 11, 18, 6, 144
	, 1, 20, 26, 10, 26
	, 10, 10, 14, '20', 25000)
	,('Ancient Bronze Dragon', 6, 4
	, 3, 24, 6, 192
	, 1, 22, 29, 10, 27
	, 18, 17, 21, '22', 41000)

-- MovementType table
-- referenced by CreatureMovement
create table MovementType
(
	MovementTypeID		tinyint		identity	primary key
	,MovementType		varchar(50)				not null
)

insert into MovementType(MovementType)
values ('None')
	,('Walking')
	,('Fly')
	,('Burrow')
	,('Climb')
	,('Jump')
	,('Swim')

-- CreatureMovement table
-- references MovementType and Creatures
create table CreatureMovement
(
	CreatureID				int					references Creatures(CreatureID)
	,CreatureMovementType	tinyint				references MovementType(MovementTypeID)
	,CreatureMovementSpeed	smallint			not null check(CreatureMovementSpeed >= 0)
	,primary key(CreatureID, CreatureMovementType)
)

insert into CreatureMovement(CreatureID, CreatureMovementType, CreatureMovementSpeed)
values (1, 2, 30)
	,(2, 2, 40)
	,(2, 4, 40)
	,(2, 3, 80)
	,(2, 7, 40)
	,(3, 2, 40)
	,(3, 3, 80)
	,(3, 7, 40)

-- Senses table
-- referenced by CreatureSenses
create table Senses
(
	SenseID				tinyint		identity	primary key
	,SenseType			varchar(50)				not null
)

insert into Senses(SenseType)
values ('Passive Perception')
	,('Darkvision')
	,('Blindsight')

-- CreatureSenses table
-- references Sesnses and Creatures
create table CreatureSenses
(
	CreatureID			int						references Creatures(CreatureID)
	,SenseID			tinyint					references Senses(SenseID)
	,SenseRange			smallint				not null check(SenseRange >= 0)
	,primary key(CreatureID, SenseID)
)

insert into CreatureSenses(CreatureID, SenseID, SenseRange)
values (1, 1, 9)
	,(1, 2, 60)
	,(2, 1, 23)
	,(2, 2, 120)
	,(2, 3, 60)
	,(3, 1, 27)
	,(3, 2, 120)
	,(3, 3, 60)

-- DamageType table
-- referenced by CreatureResistances, Abilities, CreatureAttacks, AttackModifiers
create table DamageType
(
	DamageID			tinyint		identity	primary key
	,DamageType			varchar(20)				not null
)

insert into DamageType(DamageType)
values ('Bludgeoning')	--1
	,('Piercing')		--2
	,('Slashing')		--3
	,('Force')			--4
	,('Thunder')		--5
	,('Lightning')		--6
	,('Cold')			--7
	,('Fire')			--8
	,('Acid')			--9
	,('Poison')			--10
	,('Radiant')		--11
	,('Necrotic')		--12
	,('Psychic')		--13

-- CreatureResistances table
-- references DamageType and Creatures
create table CreatureResistances
(
	CreatureID			int						references Creatures(CreatureID)
	,DamageResistanceID	tinyint					references DamageType(DamageID)
	,IsMagical			bit						not null
	,IsImmune			bit						not null
	,primary key(CreatureID, DamageResistanceID)
)

insert into CreatureResistances(CreatureID, DamageResistanceID, IsMagical, IsImmune)
values (2, 7, 1, 1)
		,(3, 6, 1, 1)

-- Conditions table
-- referenced by CreatureConditionalImmunities
create table Conditions
(
	ConditionID			tinyint		identity		primary key
	,Condition			varchar(50)					not null
)

insert into Conditions(Condition)
values ('Blinded')		--1
	,('Charmed')		--2
	,('Deafened')		--3
	,('Exhaustion')		--4
	,('Frightened')		--5
	,('Grappled')		--6
	,('Paralyzed')		--7
	,('Petrified')		--8
	,('Poisoned')		--9
	,('Prone')			--10
	,('Restrained')		--11
	,('Stunned')		--12

-- CreatureConditionalImmunities table
-- references Conditions and Creatures
create table CreatureConditionalImmunities
(
	CreatureID			int						references Creatures(CreatureID)
	,ConditionID		tinyint					references Conditions(ConditionID)
	,primary key(CreatureID, ConditionID)
)

-- Saves table
-- referenced by CreatureSaves
create table Saves
(
	SaveID				tinyint		identity	primary key
	,SaveType			varchar(50)				not null
)

insert into Saves(SaveType)
values ('Strength')		--1
	,('Dexterity')		--2
	,('Constitution')	--3
	,('Intelligence')	--4
	,('Wisdom')			--5
	,('Charisma')		--6

-- CreatureSaves table
-- references Saves and Creatures
create table CreatureSaves
(
	CreatureID			int						references Creatures(CreatureID)
	,SaveID				tinyint					references Saves(SaveID)
	,SaveModifier		tinyint					not null
	,primary key(CreatureID, SaveID)
)

insert into CreatureSaves(CreatureID, SaveID, SaveModifier)
values	(2, 2, 6)
	,(2, 3, 14)
	,(2, 5, 7)
	,(2, 6, 8)
	,(3, 2, 7)
	,(3, 3, 15)
	,(3, 5, 10)
	,(3, 6, 12)

-- SpecialAbilities table
-- referenced by CreatureSpecialAbilities
create table SpecialAbilities
(
	SpecialAbilityID	int			identity	primary key
	,SpecialAbility		varchar(2000)			not null
)

insert into SpecialAbilities(SpecialAbility)
values ('nimble escape')
	,('ice walk')
	,('amphibious')
	,('Multi Attack - Frightful Presence, 1 Bite, 2 Claw')

-- CreatureSpecialAbilities table
-- references SpecialAbilities and Creatures
create table CreatureSpecialAbilities
(
	CreatureID			int						references Creatures(CreatureID)
	,SpecialAbilityID	int						references SpecialAbilities(SpecialAbilityID)
	,primary key(CreatureID, SpecialAbilityID)
)

insert into CreatureSpecialAbilities(CreatureID, SpecialAbilityID)
values (1, 1)
	,(2, 2)
	,(2, 4)
	,(3, 3)
	,(3, 4)

-- Languages table
-- referenced by CreatureLanguages
create table Languages
(
	LanguageID			tinyint		identity	primary key
	,[Language]			varchar(50)				not null
)

insert into Languages([Language])
values ('common')
	,('goblin')
	,('draconic')

-- CreatureLanguages table
-- references Languages and Creatures
create table CreatureLanguages
(
	CreatureID			int						references Creatures(CreatureID)
	,CreatureLanguageID	tinyint					references Languages(LanguageID)
	,primary key(CreatureID, CreatureLanguageID)
)

insert into CreatureLanguages(CreatureID, CreatureLanguageID)
values (1, 1)
	,(1, 2)
	,(2, 1)
	,(2, 3)
	,(3, 1)
	,(3, 3)

-- Proficiencies table
-- referenced by CreatureProficiencies
create table Proficiencies
(
	ProficiencyID		tinyint		identity	primary key
	,ProficiencyType	varchar(50)				not null
)

insert into Proficiencies(ProficiencyType)
values ('Stealth')
	,('Perception')
	,('Insight')

-- CreatureProficiencies table
-- references Proficiencies and Creatures
create table CreatureProficiencies
(
	CreatureID				int					references Creatures(CreatureID)
	,ProficiencyID			tinyint				references Proficiencies(ProficiencyID)
	,ProficiencyModifier	tinyint				not null
	,primary key(CreatureID, ProficiencyID)
)

insert into CreatureProficiencies(CreatureID, ProficiencyID, ProficiencyModifier)
values (1, 1, 6)
	,(2, 1, 6)
	,(2, 2, 13)
	,(3, 1, 7)
	,(3, 2, 17)
	,(3, 3, 10)

-- ActionType table
-- referenced by Abilities
create table ActionType
(
	ActionID			tinyint		identity	primary key
	,ActionType			varchar(20)				not null
)

insert into ActionType(ActionType)
values ('Free Action')		--1
	,('Bounus Action')		--2
	,('Action')				--3
	,('Reaction')			--4
	,('Legendary Action')	--5

-- AreaOfEffect table
-- referenced by Abilities and CreatureAttacks
create table AreaOfEffect
(
	AOEID				tinyint		identity	primary key
	,AOE				varchar(20)				not null
)

insert into AreaOfEffect(AOE)
values ('Self')		--1
	,('Target')		--2
	,('Cone')		--3
	,('Cube')		--4
	,('Circle')		--5
	,('Line')		--6
	,('Sphere')		--7
	,('Cylinder')	--8

-- Attacks table
-- referenced by CreatureAttacks
create table Attacks
(
	AttackID			int			identity	primary key
	,AttackName			varchar(20)				not null
)

insert into Attacks(AttackName)
values ('Scimitar')
	,('Shortbow')
	,('Claw')
	,('Bite')
	,('Tail')

-- AttackModifiers table
-- references Dice and DamageType
-- referenced by CreatureAttacks
create table AttackModifiers
(
	AttackModifierID	int			identity	primary key
	,ModifierEffect		varchar(1000)			not null
	,ModifierDamageType	tinyint					references DamageType(DamageID)
	,ModifierDieCount	tinyint					not null
	,ModifierDie		tinyint					references Dice(DiceID)
	,ModifierDifficulty	tinyint					null
	,SaveHalf			bit						not null
	,SaveNegate			bit						not null
)

insert into AttackModifiers(ModifierEffect, ModifierDamageType, ModifierDieCount, ModifierDie
	, ModifierDifficulty, SaveHalf, SaveNegate)
values ('Cold damage from bite attack', 7, 2, 3, null, 0, 0)

-- CreatureAttacks table
-- references AreaOfEffect, Attacks, DamageType, AttackModifiers, Dice, and Creatures
create table CreatureAttacks
(
	CreatureID			int						references Creatures(CreatureID)
	,AttackID			int						references Attacks(AttackID)
	,AttackRange		varchar(10)				not null
	,AttackAOE			tinyint					references AreaOfEffect(AOEID)
	,AOESize			smallint				not null check(AOESize >= 0)
	,IsMagical			bit						not null
	,ToHitModifier		smallint				not null
	,DamageDieCount		tinyint					not null
	,DamageDie			tinyint					references Dice(DiceID)
	,DamageModifier		smallint				not null
	,DamageType			tinyint					references DamageType(DamageID)
	,AttackModifierID	int						null references AttackModifiers(AttackModifierID)
	,primary key(CreatureID, AttackID)
)

insert into CreatureAttacks(CreatureID, AttackID, AttackRange, AttackAOE, AOESize, IsMagical
	, ToHitModifier, DamageDieCount, DamageDie, DamageModifier, DamageType, AttackModifierID)
values (1, 1, '5', 2, 0, 0
	, 4, 1, 2, 2, 3, null)
	,(1, 2, '80/320', 2, 0, 0
	, 4, 1, 2, 2, 2, null)
	,(2, 4, '15', 2, 0, 0
	, 14, 2, 4, 8, 2, 1)
	,(2, 3, '10', 2, 0, 0
	, 14, 2, 2, 8, 3, null)
	,(2, 5, '20', 2, 0, 0
	, 14, 2, 3, 8, 1, null)

-- Abilities table
-- references ActionType, DamageType, AreaOfEffect, and Dice
-- referenced by CreatureAbilities
create table Abilities
(
	AbilityID			int			identity	primary key
	,AbilityName		varchar(50)				not null
	,AbilityDescription	varchar(2000)			not null
	,ActionType			tinyint					references ActionType(ActionID)
	,ActionCost			tinyint					not null
	,AbilityDifficulty	tinyint					not null
	,SaveHalf			bit						not null
	,SaveNegate			bit						not null
	,AbilityRange		varchar(10)				not null
	,AbilityAOE			tinyint					references AreaOfEffect(AOEID)
	,AOESize			smallint				not null check(AOESize >= 0)
	,IsMagical			bit						not null
	,AbilityDieCount	tinyint					not null
	,AbilityDie			tinyint					references Dice(DiceID)
	,AbilityModifier	tinyint					null
	,AbilityDamageType	tinyint					references DamageType(DamageID)
)

insert into Abilities(AbilityName, AbilityDescription, ActionType, ActionCost
	, AbilityDifficulty, SaveHalf, SaveNegate, AbilityRange, AbilityAOE, AOESize, IsMagical
	, AbilityDieCount, AbilityDie, AbilityModifier, AbilityDamageType)
values ('Lightning Breath', 'Exhales Lightning', 3, 1
	, 23, 1, 0, 120, 6, 10, 0
	, 16, 4, null, 6)

-- CreatureAbilities table
-- references Abilities
-- referenced by Creatures
create table CreatureAbilities
(
	CreatureID			int						references Creatures(CreatureID)
	,CreatureAbility	int						references Abilities(AbilityID)
	,primary key(CreatureID, CreatureAbility)
)

insert into CreatureAbilities(CreatureID, CreatureAbility)
values (3, 1)
